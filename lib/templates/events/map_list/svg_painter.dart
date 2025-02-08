import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/repositories/event_map/models/map_model.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:xml/xml.dart';

class SvgPainter extends StatelessWidget {
  const SvgPainter({
    super.key,
    required this.size,
    required this.context,
    required this.svgContent,
    required this.hoveredId,
    required this.selectedSeats,
    required this.scaleFactor,
    required this.offset,
    required this.availableSeats,
    required this.specials,
    required this.allSeats,
  });

  final Size size;
  final BuildContext context;
  final String svgContent;
  final String? hoveredId;
  final List<MapSeatModel> selectedSeats;
  final double scaleFactor;
  final Offset offset;
  final List<MapSeatModel> availableSeats;
  final List<MapSpecialSeatModel>? specials;
  final List<MapSeatModel> allSeats;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: Painter(
          context: context,
          svgContent: svgContent,
          hoveredId: hoveredId,
          selectedSeats: selectedSeats,
          scaleFactor: scaleFactor,
          offset: offset,
          availableSeats: availableSeats,
          specials: specials,
          allSeats: allSeats),
    );
  }
}

class Painter extends CustomPainter {
  final BuildContext context;
  final String svgContent;
  final String? hoveredId;
  final List<MapSeatModel> selectedSeats;
  final double scaleFactor;
  final Offset offset;
  final List<MapSeatModel> availableSeats;
  final List<MapSpecialSeatModel>? specials;
  final List<MapSeatModel> allSeats;

  Painter({
    required this.context,
    required this.svgContent,
    required this.hoveredId,
    required this.selectedSeats,
    required this.scaleFactor,
    required this.offset,
    required this.availableSeats,
    required this.specials,
    required this.allSeats,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    canvas.scale(scaleFactor);

    for (MapSeatModel seat in allSeats) {
      final cx = seat.seatX;
      final cy = seat.seatY;
      final r = seat.seatR;
      final id = seat.seatId;
      final MapSeatModel? seatModel = _findSeatById(id);

      paint.color = _getSeatColor(
          seatModel, id == hoveredId, _isSelected(seatModel, selectedSeats));
      canvas.drawCircle(Offset(cx, cy), r, paint);

      MapSpecialSeatModel? special = _findSpacialById(id);
      if (special != null) {
        paint.color = Color(0xFF000000);
        final Path iconPath = special.special == Special.wheelchairServices
            ? _getWheelchairPath()
            : _getVipPath();
        final double scaleFactor =
            r / 9.0; // Assuming the original icon size fits in a 24x24 box
        final Matrix4 transformMatrix = Matrix4.identity()
          ..translate(cx + 5, cy + 5)
          ..scale(scaleFactor, scaleFactor)
          ..translate(-11.0, -11.0); // Center the icon
        canvas.save();
        canvas.transform(transformMatrix.storage);
        canvas.drawPath(iconPath, paint);
        canvas.restore();
      }
    }

    // Render the stage path from the SVG
    final document = XmlDocument.parse(svgContent);
    final stagePaths = document.findAllElements('path').map((element) {
      final pathData = element.getAttribute('d');
      final fillColor = element.getAttribute('fill') ?? '#000000';
      return {'d': pathData, 'fill': fillColor};
    });

    for (var path in stagePaths) {
      if (path['d'] != null) {
        final Path parsedPath = parseSvgPathData(path['d']!);
        paint.color = _colorFromHex(path['fill']!);
        canvas.drawPath(parsedPath, paint);
      }
    }

    canvas.restore();
  }

  MapSeatModel? _findSeatById(String id) {
    for (var seat in availableSeats) {
      if (seat.seatId == id) {
        return seat;
      }
    }
    return null;
  }

  MapSpecialSeatModel? _findSpacialById(String id) {
    if (specials == null) {
      return null;
    } else {
      for (MapSpecialSeatModel special in specials!) {
        if (special.id == id) {
          return special;
        }
      }
    }

    return null;
  }

  bool _isSelected(MapSeatModel? seatModel, List<MapSeatModel> selectedSeats) {
    if (seatModel == null) {
      return false;
    }

    for (MapSeatModel seat in selectedSeats) {
      if (seat.seatId == seatModel.seatId) {
        return true;
      }
    }
    return false;
  }

  Color _getSeatColor(MapSeatModel? seatModel, bool isHovered, bool isClicked) {
    if (seatModel == null) {
      return Theme.of(context).appColors.fgSecondary700;
    }

    final colors = Theme.of(context).appColors;

    Color baseColor;
    if (seatModel.dealScore != null) {
      switch (seatModel.dealScore!) {
        case >= 9:
          baseColor = colors.utilitySuccess700;
          break;
        case >= 7:
          baseColor = colors.utilitySuccess600;
          break;
        case >= 5:
          baseColor = colors.utilitySuccess500;
          break;
        case >= 4:
          baseColor = colors.utilityWarning600;
          break;
        case >= 3:
          baseColor = colors.utilityWarning700;
          break;
        case >= 1:
          baseColor = colors.utilityError500;
          break;
        default:
          baseColor = colors.fgSecondary700;
      }
    } else {
      baseColor = colors.fgSecondary700;
    }

    return isHovered || isClicked ? baseColor.withOpacity(0.5) : baseColor;
  }

  // Helper method to convert hex color strings to Color
  Color _colorFromHex(String hexColor) {
    final buffer = StringBuffer();
    if (hexColor.length == 6 || hexColor.length == 7) buffer.write('ff');
    buffer.write(hexColor.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  Path _getWheelchairPath() {
    final Path path = Path();
    path.moveTo(5.82108, 7.21592);
    path.cubicTo(5.17622, 7.20485, 4.53935, 7.35868, 3.97181, 7.66257);
    path.cubicTo(3.40427, 7.96647, 2.92519, 8.41019, 2.58069, 8.95102);
    path.cubicTo(2.2362, 9.49184, 2.03791, 10.1115, 2.00492, 10.7504);
    path.cubicTo(1.97193, 11.3893, 2.10535, 12.0259, 2.39232, 12.5988);
    path.cubicTo(2.6793, 13.1717, 3.11018, 13.6616, 3.64344, 14.0215);
    path.cubicTo(4.17671, 14.3813, 4.7944, 14.5988, 5.43702, 14.6532);
    path.cubicTo(6.07965, 14.7075, 6.72556, 14.5968, 7.31254, 14.3318);
    path.cubicTo(7.89952, 14.0667, 8.4078, 13.6562, 8.78842, 13.1397);
    path.moveTo(13.3333, 13.9221);
    path.lineTo(10.3284, 10.1964);
    path.lineTo(7.32353, 10.1964);
    path.lineTo(9.57721, 6.47078);
    path.lineTo(6.57231, 4.23539);
    path.lineTo(3.56741, 4.98052);
    path.moveTo(10.3284, 3.49026);
    path.cubicTo(10.3284, 3.8855, 10.4867, 4.26456, 10.7685, 4.54404);
    path.cubicTo(11.0503, 4.82351, 11.4324, 4.98052, 11.8309, 4.98052);
    path.cubicTo(12.2294, 4.98052, 12.6115, 4.82351, 12.8933, 4.54404);
    path.cubicTo(13.175, 4.26456, 13.3333, 3.8855, 13.3333, 3.49026);
    path.cubicTo(13.3333, 3.09502, 13.175, 2.71597, 12.8933, 2.43649);
    path.cubicTo(12.6115, 2.15701, 12.2294, 2, 11.8309, 2);
    path.cubicTo(11.4324, 2, 11.0503, 2.15701, 10.7685, 2.43649);
    path.cubicTo(10.4867, 2.71597, 10.3284, 3.09502, 10.3284, 3.49026);
    path.close();
    // Additional detailed path for more intricate wheelchair shape
    path.moveTo(5, 8);
    path.lineTo(9, 8);
    path.lineTo(9, 10);
    path.lineTo(5, 10);
    path.lineTo(5, 8);
    path.moveTo(6, 10);
    path.lineTo(6, 14);
    path.lineTo(8, 14);
    path.lineTo(8, 10);
    path.lineTo(6, 10);
    path.close();
    return path;
  }

  Path _getVipPath() {
    final Path path = Path();
    //TODO vip shape
    return path;
  }

  @override
  bool shouldRepaint(covariant Painter oldDelegate) {
    return hoveredId != oldDelegate.hoveredId ||
        selectedSeats != oldDelegate.selectedSeats ||
        scaleFactor != oldDelegate.scaleFactor ||
        offset != oldDelegate.offset;
  }
}
