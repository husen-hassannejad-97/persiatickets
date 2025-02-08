import 'dart:math';

import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:flutter/material.dart';

class CircularPercentIndicator extends StatelessWidget {
  final double percent;

  const CircularPercentIndicator({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size.fromRadius(50),
      painter: _CircularPercentPainter(percent, context),
    );
  }
}

class _CircularPercentPainter extends CustomPainter {
  final double percent;
  final BuildContext context;

  const _CircularPercentPainter(this.percent, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Theme.of(context).appColors.fgPrimary900.withOpacity(0.3)
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawCircle(center, radius, paint);

    paint.color = Theme.of(context).appColors.fgPrimary900;
    paint.strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      pi * 2 * percent,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is! _CircularPercentPainter ||
        percent != oldDelegate.percent;
  }
}
