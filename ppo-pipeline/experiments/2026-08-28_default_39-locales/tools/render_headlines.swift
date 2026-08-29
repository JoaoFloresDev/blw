// Render verb-split headlines (SF Pro Black, white + soft black shadow) on top of
// text-free print art, using CoreText so every script (Arabic, Hebrew, Indic,
// Thai, CJK) is shaped and falls back to the right system font.
//
// Build:  swiftc -O render_headlines.swift -o render_headlines
// Usage:  render_headlines jobs.json
//
// jobs.json:
// {
//   "layout": {"width":1320,"height":2868,"centerX":660,
//              "line1": {"size":238,"baseline":288,"maxWidth":1160},
//              "line2": {"size":91,"baseline":394,"maxWidth":1160},
//              "shadow": {"blur":14,"dx":0,"dy":6,"alpha":0.75}},
//   "jobs": [{"base":"...png","out":"...png","lang":"pt-BR","line1":"CONTE","line2":"CADA PASSO",
//             "scale1":1.0,"scale2":1.0,"uppercase":true}]
// }
import AppKit
import CoreText
import Foundation

struct LineSpec: Decodable { let size: CGFloat; let baseline: CGFloat; let maxWidth: CGFloat }
struct ShadowSpec: Decodable { let blur: CGFloat; let dx: CGFloat; let dy: CGFloat; let alpha: CGFloat }
struct Layout: Decodable {
    let width: Int; let height: Int; let centerX: CGFloat
    let line1: LineSpec; let line2: LineSpec; let shadow: ShadowSpec
}
struct Job: Decodable {
    let base: String; let out: String; let lang: String
    let line1: String; let line2: String
    let scale1: CGFloat?; let scale2: CGFloat?; let uppercase: Bool?
}
struct Spec: Decodable { let layout: Layout; let jobs: [Job] }

func loadCGImage(_ path: String) -> CGImage? {
    guard let src = CGImageSourceCreateWithURL(URL(fileURLWithPath: path) as CFURL, nil) else { return nil }
    return CGImageSourceCreateImageAtIndex(src, 0, nil)
}

func makeLine(_ text: String, size: CGFloat, lang: String) -> CTLine {
    let font = NSFont.systemFont(ofSize: size, weight: .black)
    let attrs: [NSAttributedString.Key: Any] = [
        .font: font,
        .foregroundColor: NSColor.white,
        NSAttributedString.Key(kCTLanguageAttributeName as String): lang,
    ]
    return CTLineCreateWithAttributedString(NSAttributedString(string: text, attributes: attrs))
}

/// Ink bounds (glyph paths), relative to the line origin.
func inkBounds(_ line: CTLine) -> CGRect {
    CTLineGetBoundsWithOptions(line, [.useGlyphPathBounds])
}

func fittedLine(_ text: String, spec: LineSpec, scale: CGFloat, lang: String) -> (CTLine, CGFloat) {
    var size = spec.size * scale
    var line = makeLine(text, size: size, lang: lang)
    let width = inkBounds(line).width
    if width > spec.maxWidth {
        size = size * spec.maxWidth / width
        line = makeLine(text, size: size, lang: lang)
    }
    return (line, size)
}

func drawCentered(_ line: CTLine, baselineFromTop: CGFloat, in ctx: CGContext, layout: Layout) {
    let ink = inkBounds(line)
    let x = layout.centerX - (ink.minX + ink.width / 2)
    let y = CGFloat(layout.height) - baselineFromTop
    ctx.textPosition = CGPoint(x: x, y: y)
    CTLineDraw(line, ctx)
}

func render(job: Job, layout: Layout) throws {
    guard let base = loadCGImage(job.base) else { throw NSError(domain: "render", code: 1, userInfo: [NSLocalizedDescriptionKey: "cannot load \(job.base)"]) }
    let w = layout.width, h = layout.height
    let cs = CGColorSpace(name: CGColorSpace.sRGB)!
    guard let ctx = CGContext(data: nil, width: w, height: h, bitsPerComponent: 8, bytesPerRow: w * 4,
                              space: cs, bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue) else {
        throw NSError(domain: "render", code: 2, userInfo: [NSLocalizedDescriptionKey: "no context"])
    }
    ctx.draw(base, in: CGRect(x: 0, y: 0, width: w, height: h))

    let locale = Locale(identifier: job.lang)
    let upper = job.uppercase ?? true
    let t1 = upper ? job.line1.uppercased(with: locale) : job.line1
    let t2 = upper ? job.line2.uppercased(with: locale) : job.line2
    let (l1, _) = fittedLine(t1, spec: layout.line1, scale: job.scale1 ?? 1, lang: job.lang)
    let (l2, _) = fittedLine(t2, spec: layout.line2, scale: job.scale2 ?? 1, lang: job.lang)

    ctx.saveGState()
    let sh = layout.shadow
    ctx.setShadow(offset: CGSize(width: sh.dx, height: -sh.dy), blur: sh.blur,
                  color: CGColor(srgbRed: 0, green: 0, blue: 0, alpha: sh.alpha))
    drawCentered(l1, baselineFromTop: layout.line1.baseline, in: ctx, layout: layout)
    drawCentered(l2, baselineFromTop: layout.line2.baseline, in: ctx, layout: layout)
    ctx.restoreGState()

    guard let img = ctx.makeImage() else { throw NSError(domain: "render", code: 3) }
    let rep = NSBitmapImageRep(cgImage: img)
    guard let png = rep.representation(using: .png, properties: [:]) else { throw NSError(domain: "render", code: 4) }
    try FileManager.default.createDirectory(atPath: (job.out as NSString).deletingLastPathComponent, withIntermediateDirectories: true)
    try png.write(to: URL(fileURLWithPath: job.out))
}

let args = CommandLine.arguments
guard args.count >= 2 else { print("usage: render_headlines jobs.json"); exit(1) }
let data = try Data(contentsOf: URL(fileURLWithPath: args[1]))
let spec = try JSONDecoder().decode(Spec.self, from: data)
var failures = 0
for (i, job) in spec.jobs.enumerated() {
    do {
        try render(job: job, layout: spec.layout)
        if i % 10 == 0 { print("[\(i + 1)/\(spec.jobs.count)] \(job.lang) \(job.out.split(separator: "/").suffix(2).joined(separator: "/"))") }
    } catch {
        failures += 1
        print("FAIL \(job.out): \(error)")
    }
}
print("done: \(spec.jobs.count - failures) ok, \(failures) failed")
exit(failures == 0 ? 0 : 2)
