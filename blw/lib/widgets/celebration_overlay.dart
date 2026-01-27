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
      margin: const EdgeInsets.all(32),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Celebration icon
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF34C759), Color(0xFF30D158)],
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF34C759).withValues(alpha: 0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Text(
                widget.foodIcon,
                style: const TextStyle(fontSize: 50),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Star animation
          const Text(
            '🎉',
            style: TextStyle(fontSize: 40),
          ),
          const SizedBox(height: 16),

          // Title
          Text(
            l10n.firstTime,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1C1C1E),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),

          // Food name
          Text(
            widget.foodName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF34C759),
              letterSpacing: -0.3,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),

          // Subtitle
          Text(
            l10n.addedToDiary,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF8E8E93),
              letterSpacing: -0.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Tap to dismiss hint
          Text(
            l10n.tapToContinue,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
              fontWeight: FontWeight.w500,
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
