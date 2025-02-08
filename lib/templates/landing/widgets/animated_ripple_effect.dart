import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RippleLoadingWidget extends StatelessWidget {
  final double height;

  const RippleLoadingWidget({
    super.key,
    this.height = 400,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Clip the ripple effect to stay inside the widget bounds
          ClipRect(
            child: Positioned.fill(
              child: _AnimatedRippleEffect(),
            ),
          ),

          // Centered loading animation
          LoadingAnimationWidget.horizontalRotatingDots(
            color: Color(0xFFA67A4E),
            size: 100,
          ),
        ],
      ),
    );
  }
}

class _AnimatedRippleEffect extends StatefulWidget {
  const _AnimatedRippleEffect({Key? key}) : super(key: key);

  @override
  State<_AnimatedRippleEffect> createState() => _AnimatedRippleEffectState();
}

class _AnimatedRippleEffectState extends State<_AnimatedRippleEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: RipplePainter(_controller.value),
          child: Container(),
        );
      },
    );
  }
}

class RipplePainter extends CustomPainter {
  final double progress;

  RipplePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    var mainOpacity = 0.08;
    final paint = Paint()..color = Color(0xFFA67A4E).withOpacity(mainOpacity);

    // Ripple radii based on progress
    final double maxRadius = size.width * 0.6;
    final radii = [
      maxRadius * (progress),
      maxRadius * ((progress - 0.33).clamp(0.0, 1.0)),
      maxRadius * ((progress - 0.66).clamp(0.0, 1.0)),
    ];

    // Draw the circles
    for (var radius in radii) {
      canvas.drawCircle(
        size.center(Offset.zero),
        radius,
        paint..color = paint.color.withOpacity((1.0 - radius / maxRadius) * mainOpacity),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
