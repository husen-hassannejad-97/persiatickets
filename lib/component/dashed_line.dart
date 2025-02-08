import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  final bool isVertical;
  final double width;
  final double height;
  const DashedLine._internal(
      {super.key, this.isVertical = true, this.width = 0.0, this.height = 0.0});

  factory DashedLine.vertical({
    Key? key,
    required double width,
    required double height,
  }) =>
      DashedLine._internal(
        key: key,
        isVertical: true,
        height: height,
        width: width,
      );

  factory DashedLine.horizontal({
    Key? key,
    required double width,
    required double height,
  }) =>
      DashedLine._internal(
        key: key,
        isVertical: false,
        height: height,
        width: width,
      );

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: isVertical
          ? VerticalDashedLinePainter()
          : HorizontalDashedLinePainter(),
    );
  }
}

class HorizontalDashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF404040)
      ..strokeWidth = size.height // Thickness of the dashed line
      ..style = PaintingStyle.stroke;

    double dashWidth = 10; // Width of each dash
    double dashSpacing = 5; // Space between dashes
    double startX = 0; // Starting X position for drawing

    while (startX < size.width) {
      // Draw a dash
      canvas.drawLine(
        Offset(startX, size.height / 2), // Starting point
        Offset(startX + dashWidth, size.height / 2), // Ending point
        paint,
      );
      // Move to the next dash position
      startX += dashWidth + dashSpacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint for static dashed lines
  }
}

class VerticalDashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF404040)
      ..strokeWidth = size.width // Thickness of the dashed line
      ..style = PaintingStyle.stroke;

    double dashHeight = 10; // Height of each dash
    double dashSpacing = 5; // Space between dashes
    double startY = 0; // Starting Y position for drawing

    while (startY < size.height) {
      // Draw a dash
      canvas.drawLine(
        Offset(size.width / 2, startY), // Starting point
        Offset(size.width / 2, startY + dashHeight), // Ending point
        paint,
      );
      // Move to the next dash position
      startY += dashHeight + dashSpacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint for static dashed lines
  }
}
