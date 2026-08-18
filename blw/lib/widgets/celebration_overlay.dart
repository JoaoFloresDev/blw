import 'dart:math';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class CelebrationOverlay extends StatefulWidget {
  final String foodName;
  final String foodIcon;
  final VoidCallback onDismiss;

  const CelebrationOverlay({
    super.key,
    required this.foodName,
    required this.foodIcon,
    required this.onDismiss,
  });

  @override
  State<CelebrationOverlay> createState() => _CelebrationOverlayState();
}

class _CelebrationOverlayState extends State<CelebrationOverlay>
    with TickerProviderStateMixin {
  late AnimationController _confettiController;
  late AnimationController _cardController;
  late Animation<double> _cardScale;
  late Animation<double> _cardOpacity;
  late List<ConfettiParticle> _particles;

  final _random = Random();

  @override
  void initState() {
    super.initState();

    // Confetti animation
    _confettiController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    // Card animation
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _cardScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _cardController,
        curve: Curves.elasticOut,
      ),
    );

    _cardOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _cardController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    // Generate particles
    _particles = List.generate(50, (_) => ConfettiParticle(_random));

    _confettiController.repeat();
    _cardController.forward();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onDismiss,
      child: Material(
        color: Colors.black54,
        child: Stack(
          children: [
            // Confetti layer
            AnimatedBuilder(
              animation: _confettiController,
              builder: (context, child) {
                return CustomPaint(
                  size: MediaQuery.of(context).size,
                  painter: ConfettiPainter(
                    particles: _particles,
                    progress: _confettiController.value,
                  ),
                );
              },
            ),

            // Card layer
            Center(
              child: AnimatedBuilder(
                animation: _cardController,
                builder: (context, _) {
                  return Opacity(
                    opacity: _cardOpacity.value,
                    child: Transform.scale(
                      scale: _cardScale.value,
                      child: _buildCelebrationCard(context),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCelebrationCard(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28),
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Food hero inside a soft green halo, party badge on top
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                width: 128,
                height: 128,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF34C759).withValues(alpha: 0.18),
                      const Color(0xFF30D158).withValues(alpha: 0.08),
                    ],
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2FBF4),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF34C759).withValues(alpha: 0.25),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.foodIcon,
                    style: const TextStyle(fontSize: 52),
                  ),
                ),
              ),
              const Positioned(
                top: -8,
                right: -4,
                child: Text('🎉', style: TextStyle(fontSize: 34)),
              ),
            ],
          ),
          const SizedBox(height: 22),

          // Title
          Text(
            l10n.firstTime,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1C1C1E),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),

          // Food name pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
            decoration: BoxDecoration(
              color: const Color(0xFF34C759).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.foodName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1B9A43),
                letterSpacing: -0.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),

          // Subtitle
          Text(
            l10n.addedToDiary,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF6E6E73),
              letterSpacing: -0.2,
              height: 1.35,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Dismiss button
          GestureDetector(
            onTap: widget.onDismiss,
            child: Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF34C759), Color(0xFF2BB554)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.10),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  l10n.tapToContinue,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ConfettiParticle {
  late double x;
  late double y;
  late double size;
  late double speed;
  late double angle;
  late double rotationSpeed;
  late Color color;
  late int shape; // 0 = circle, 1 = rectangle, 2 = star

  static const colors = [
    Color(0xFF34C759), // Green
    Color(0xFFFF9500), // Orange
    Color(0xFF007AFF), // Blue
    Color(0xFFFF2D55), // Pink
    Color(0xFFAF52DE), // Purple
    Color(0xFFFFCC00), // Yellow
  ];

  ConfettiParticle(Random random) {
    x = random.nextDouble();
    y = -0.1 - random.nextDouble() * 0.2;
    size = 6 + random.nextDouble() * 8;
    speed = 0.3 + random.nextDouble() * 0.4;
    angle = random.nextDouble() * 0.4 - 0.2;
    rotationSpeed = random.nextDouble() * 4 - 2;
    color = colors[random.nextInt(colors.length)];
    shape = random.nextInt(3);
  }
}

class ConfettiPainter extends CustomPainter {
  final List<ConfettiParticle> particles;
  final double progress;

  ConfettiPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      final paint = Paint()..color = particle.color;

      final currentY = particle.y + progress * particle.speed * 1.5;
      final currentX = particle.x + sin(progress * 10 + particle.angle) * 0.05;

      if (currentY > 1.2) continue;

      final x = currentX * size.width;
      final y = currentY * size.height;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(progress * particle.rotationSpeed);

      switch (particle.shape) {
        case 0: // Circle
          canvas.drawCircle(Offset.zero, particle.size / 2, paint);
          break;
        case 1: // Rectangle
          canvas.drawRect(
            Rect.fromCenter(
              center: Offset.zero,
              width: particle.size,
              height: particle.size * 0.6,
            ),
            paint,
          );
          break;
        case 2: // Small star shape (simplified)
          final path = Path();
          for (int i = 0; i < 5; i++) {
            final angle = (i * 72 - 90) * pi / 180;
            final point = Offset(
              cos(angle) * particle.size / 2,
              sin(angle) * particle.size / 2,
            );
            if (i == 0) {
              path.moveTo(point.dx, point.dy);
            } else {
              path.lineTo(point.dx, point.dy);
            }
          }
          path.close();
          canvas.drawPath(path, paint);
          break;
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(ConfettiPainter oldDelegate) => true;
}
