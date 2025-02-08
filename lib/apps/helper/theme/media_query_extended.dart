import 'package:flutter/material.dart';

extension MediaQueryExtended on BuildContext {
  static const double responsive360 = 360;
  static const double responsive480 = 480;
  static const double responsive600 = 600;
  static const double responsive800 = 800;
  static const double responsive900 = 900;
  static const double responsive1200 = 1200;

  double get logicalResponsive1200 => responsive1200;
  double get logicalWidth => MediaQuery.of(this).size.width > 1366
      ? 1366
      : MediaQuery.of(this).size.width;
  double get logicalHeight => MediaQuery.of(this).size.height > 768
      ? 768
      : MediaQuery.of(this).size.height;
  double get logicalWidthSA =>
      MediaQuery.of(this).size.width -
      MediaQuery.of(this).viewPadding.horizontal;
  double get logicalHeightSA =>
      MediaQuery.of(this).size.height -
      MediaQuery.of(this).viewPadding.vertical;

  bool get isSmallSmartphone {
    if (logicalWidthSA < logicalHeightSA) {
      return (logicalWidthSA <= responsive360 ||
          logicalHeightSA <= responsive600);
    } else {
      return (logicalWidthSA <= responsive600 ||
          logicalHeightSA <= responsive360);
    }
  }

  bool get isRegularSmartphoneOrLess {
    if (logicalWidthSA < logicalHeightSA) {
      return (logicalWidthSA <= responsive480 ||
          logicalHeightSA <= responsive800);
    } else {
      return (logicalWidthSA <= responsive800 ||
          logicalHeightSA <= responsive480);
    }
  }

  bool get isSmallTabletOrLess {
    if (logicalWidthSA < logicalHeightSA) {
      return (logicalWidthSA <= responsive600 ||
          logicalHeightSA <= responsive900);
    } else {
      return (logicalWidthSA <= responsive900 ||
          logicalHeightSA <= responsive600);
    }
  }

  bool get isRegularTabletOrLess {
    if (logicalWidthSA < logicalHeightSA) {
      return (logicalWidthSA <= responsive800 ||
          logicalHeightSA <= responsive1200);
    } else {
      return (logicalWidthSA <= responsive1200 ||
          logicalHeightSA <= responsive800);
    }
  }
}
