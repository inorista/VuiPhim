import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vuiphim/core/router/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _drawAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4500),
    );

    _drawAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.65, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 20.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.65, 0.85, curve: Curves.easeInExpo),
      ),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 0.85, curve: Curves.easeOut),
      ),
    );

    _controller.forward().then((_) {
      if (mounted) {
        context.go(AppRouter.main);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: CustomPaint(
                  size: const Size(120, 160),
                  painter: VPainter(
                    progress: _drawAnimation.value,
                    scale: _scaleAnimation.value,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class VPainter extends CustomPainter {
  final double progress;
  final double scale;

  VPainter({required this.progress, required this.scale});

  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 35.0;

    // Glowing shadow - Only draw when scale is close to 1.0 to prevent Impeller crashes
    Paint? shadowPaint;
    if (scale <= 1.5) {
      shadowPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeJoin = StrokeJoin.miter
        ..strokeCap = StrokeCap.square
        ..strokeMiterLimit = 4.0
        ..color = const Color(0xFFE50914)
            .withValues(alpha: 0.6 * (1.5 - scale) / 0.5) // fade out shadow
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15.0);
    }

    // Main stroke
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeJoin = StrokeJoin.miter
      ..strokeCap = StrokeCap.square
      ..strokeMiterLimit = 4.0;

    // Gradient to simulate depth and light reflection
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    const Gradient gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFFF0A16), // Bright Red at top
        Color(0xFFE50914), // Netflix Red
        Color(0xFF83050C), // Dark Red at bottom (depth)
      ],
      stops: [0.0, 0.5, 1.0],
    );
    paint.shader = gradient.createShader(rect);

    // The 'V' path
    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);

    final PathMetrics pathMetrics = path.computeMetrics();
    for (final PathMetric metric in pathMetrics) {
      final Path extractPath = metric.extractPath(
        0.0,
        metric.length * progress,
      );

      if (progress > 0) {
        // Draw the glow if available
        if (shadowPaint != null) {
          canvas.drawPath(extractPath, shadowPaint);
        }
        // Draw the main 'V'
        canvas.drawPath(extractPath, paint);
      }
      // Only process the first contour (the entire 'V' is one continuous contour)
      break;
    }
  }

  @override
  bool shouldRepaint(covariant VPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.scale != scale;
  }
}
