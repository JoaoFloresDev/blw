import AppKit
import CoreText

// usage: swift compose.swift <art.png> <out.png> <line1> <line2>
let args = CommandLine.arguments
let inPath = args[1], outPath = args[2]
let line1 = args[3], line2 = args.count > 4 ? args[4] : ""

let W = 1320, H = 2868
guard let src = NSImage(contentsOfFile: inPath),
      let srcRep = src.representations.first as? NSBitmapImageRep else { fatalError("no input") }
let sw = CGFloat(srcRep.pixelsWide), sh = CGFloat(srcRep.pixelsHigh)

let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: W, pixelsHigh: H,
    bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
    colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
NSGraphicsContext.saveGraphicsState()
let ctx = NSGraphicsContext(bitmapImageRep: rep)!
NSGraphicsContext.current = ctx
let cg = ctx.cgContext

// mode: number = zoom anchored bottom (crop width) | "fitw" = fit width, bottom-aligned, extend bg on top
let mode = args.count > 5 ? args[5] : "1.0"
if let cgImg = srcRep.cgImage {
    cg.interpolationQuality = .high
    if mode == "fitw" {
        // fill canvas with the art's top-edge background color, then draw art bottom-aligned at full width
        let probe = srcRep.colorAt(x: Int(sw/2), y: 2) ?? NSColor.white
        cg.setFillColor(probe.usingColorSpace(.deviceRGB)!.cgColor)
        cg.fill(CGRect(x: 0, y: 0, width: CGFloat(W), height: CGFloat(H)))
        let scale = CGFloat(W) / sw
        let dh = sh * scale
        cg.draw(cgImg, in: CGRect(x: 0, y: 0, width: CGFloat(W), height: dh))
    } else {
        let zoom = CGFloat(Double(mode) ?? 1.0)
        let scale = CGFloat(H) / sh * zoom
        let dw = sw * scale
        let dh = sh * scale
        let dx = (CGFloat(W) - dw) / 2
        cg.draw(cgImg, in: CGRect(x: dx, y: 0, width: dw, height: dh))
    }
}

// headline: dark green, SF Pro Heavy, title case, 2 lines
let color = NSColor(calibratedRed: 0x14/255.0, green: 0x3A/255.0, blue: 0x24/255.0, alpha: 1)
func draw(_ text: String, centerY: CGFloat, maxSize: CGFloat) {
    guard !text.isEmpty else { return }
    var size = maxSize
    var font = NSFont.systemFont(ofSize: size, weight: .heavy)
    var attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color, .kern: -1.5]
    var line = CTLineCreateWithAttributedString(NSAttributedString(string: text, attributes: attrs))
    var width = CGFloat(CTLineGetTypographicBounds(line, nil, nil, nil))
    while width > 1216 && size > 60 {
        size -= 2
        font = NSFont.systemFont(ofSize: size, weight: .heavy)
        attrs[.font] = font
        line = CTLineCreateWithAttributedString(NSAttributedString(string: text, attributes: attrs))
        width = CGFloat(CTLineGetTypographicBounds(line, nil, nil, nil))
    }
    let x = (CGFloat(W) - width) / 2
    // flip: CoreText origin bottom-left; centerY given from TOP
    let y = CGFloat(H) - centerY - size * 0.35
    cg.textPosition = CGPoint(x: x, y: y)
    CTLineDraw(line, cg)
}
let base: CGFloat = 118
draw(line1, centerY: CGFloat(H) * 0.072, maxSize: base)
draw(line2, centerY: CGFloat(H) * 0.128, maxSize: base)

// coded floating pills (deterministic breakouts)
func drawPill(emoji: String, text: String, leftX: CGFloat, topY: CGFloat, checkCircle: Bool = false) {
    let ph: CGFloat = 104
    let font = NSFont.systemFont(ofSize: 46, weight: .bold)
    let tAttrs: [NSAttributedString.Key: Any] = [.font: font,
        .foregroundColor: NSColor(calibratedRed: 0.11, green: 0.11, blue: 0.12, alpha: 1), .kern: -0.5]
    let tLine = CTLineCreateWithAttributedString(NSAttributedString(string: text, attributes: tAttrs))
    let tw = CGFloat(CTLineGetTypographicBounds(tLine, nil, nil, nil))
    let iconW: CGFloat = 64
    let pw = 28 + iconW + 20 + tw + 30
    let y = CGFloat(H) - topY - ph
    let rect = CGRect(x: leftX, y: y, width: pw, height: ph)
    cg.saveGState()
    cg.setShadow(offset: CGSize(width: 0, height: -8), blur: 26,
                 color: NSColor.black.withAlphaComponent(0.16).cgColor)
    let path = CGPath(roundedRect: rect, cornerWidth: ph/2, cornerHeight: ph/2, transform: nil)
    cg.addPath(path); cg.setFillColor(NSColor.white.cgColor); cg.fillPath()
    cg.restoreGState()
    // icon
    let iconRect = CGRect(x: leftX + 24, y: y + (ph-iconW)/2, width: iconW, height: iconW)
    if checkCircle {
        cg.setFillColor(NSColor(calibratedRed: 0x22/255.0, green: 0xA4/255.0, blue: 0x4D/255.0, alpha: 1).cgColor)
        cg.fillEllipse(in: iconRect)
        let cAttrs: [NSAttributedString.Key: Any] = [.font: NSFont.systemFont(ofSize: 44, weight: .heavy), .foregroundColor: NSColor.white]
        let cLine = CTLineCreateWithAttributedString(NSAttributedString(string: "✓", attributes: cAttrs))
        let cw = CGFloat(CTLineGetTypographicBounds(cLine, nil, nil, nil))
        cg.textPosition = CGPoint(x: iconRect.midX - cw/2, y: iconRect.midY - 15)
        CTLineDraw(cLine, cg)
    } else {
        let eAttrs: [NSAttributedString.Key: Any] = [.font: NSFont.systemFont(ofSize: 58)]
        let eLine = CTLineCreateWithAttributedString(NSAttributedString(string: emoji, attributes: eAttrs))
        cg.textPosition = CGPoint(x: iconRect.minX, y: iconRect.minY + 8)
        CTLineDraw(eLine, cg)
    }
    cg.textPosition = CGPoint(x: leftX + 24 + iconW + 20, y: y + ph/2 - 16)
    CTLineDraw(tLine, cg)
}
if args.count > 6 && args[6] == "pills1" {
    drawPill(emoji: "", text: "Avocado", leftX: 830, topY: 1880, checkCircle: true)
    drawPill(emoji: "😊", text: "Loved it", leftX: 52, topY: 2160)
}

NSGraphicsContext.restoreGraphicsState()
let png = rep.representation(using: .png, properties: [:])!
try! png.write(to: URL(fileURLWithPath: outPath))
print("ok \(W)x\(H)")
