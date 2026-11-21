
import 'dart:math';
import 'package:flutter/material.dart';

class WeatherAtmosphere extends StatefulWidget {
  final String condition;
  final bool isDay;

  const WeatherAtmosphere({
    super.key,
    required this.condition,
    required this.isDay,
  });

  @override
  State<WeatherAtmosphere> createState() =>
      _WeatherAtmosphereState();
}

class _WeatherAtmosphereState extends State<WeatherAtmosphere>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _AtmospherePainter(
          condition: widget.condition,
          isDay: widget.isDay,
          animation: _controller,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _AtmospherePainter extends CustomPainter {
  final String condition;
  final bool isDay;
  final Animation<double> animation;

  _AtmospherePainter({
    required this.condition,
    required this.isDay,
    required this.animation,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final weather = condition.toLowerCase();
    final random = Random(42);
    final progress = animation.value;

    if (weather.contains('rain') ||
        weather.contains('drizzle') ||
        weather.contains('thunder')) {
      _drawRain(canvas, size, random, progress);
    } else if (weather.contains('snow')) {
      _drawSnow(canvas, size, random, progress);
    } else if (!isDay &&
        (weather.contains('clear') ||
            weather.contains('mainly clear'))) {
      _drawStars(canvas, size, random, progress);
    }
  }

  void _drawRain(
    Canvas canvas,
    Size size,
    Random random,
    double progress,
  ) {
    final paint = Paint()
      ..color = Colors.lightBlueAccent.withValues(alpha: 0.40)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 90; i++) {
      final x = random.nextDouble() * size.width;
      final startY = random.nextDouble() * size.height;

      final y = (startY + progress * size.height * 2) %
          size.height;

      canvas.drawLine(
        Offset(x, y),
        Offset(x - 6, y + 20),
        paint,
      );
    }
  }

  void _drawSnow(
    Canvas canvas,
    Size size,
    Random random,
    double progress,
  ) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.75);

    for (int i = 0; i < 65; i++) {
      final startX = random.nextDouble() * size.width;
      final startY = random.nextDouble() * size.height;
      final radius = 1.5 + random.nextDouble() * 2;

      final y = (startY + progress * size.height) %
          size.height;

      final x = startX + sin(progress * 2 * pi + i) * 10;

      canvas.drawCircle(
        Offset(x, y),
        radius,
        paint,
      );
    }
  }

  void _drawStars(
    Canvas canvas,
    Size size,
    Random random,
    double progress,
  ) {
    for (int i = 0; i < 75; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = 0.5 + random.nextDouble() * 1.5;

      final brightness =
          0.4 + 0.4 * (sin(progress * 2 * pi + i) + 1) / 2;

      final paint = Paint()
        ..color = Colors.white.withValues(alpha: brightness);

      canvas.drawCircle(
        Offset(x, y),
        radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _AtmospherePainter oldDelegate) {
    return oldDelegate.condition != condition ||
        oldDelegate.isDay != isDay ||
        oldDelegate.animation != animation;
  }
}
