import 'package:billit_now/core/localization/layout_direction.dart';
import 'package:flutter/material.dart';

import '../../core/di/di_setup.dart';
import '../../core/localization/languages.dart';
import '../../core/localization/localize.dart';

mixin BaseWidgetMixin {

  final bool visibilityDetection = false;
  final Key visibilityKey = const Key("key");

  void onVisible(BuildContext context) {}
  void onInvisible(BuildContext context) {}
  void onVisibleFraction(BuildContext context, double fraction) {}
  String getString(String key) {
    return getIt<Localize>().values[key] ?? "";
  }
  LayoutDirection getLayoutDirection() {
    return getLanguage().layoutDirection;
  }
  Language getLanguage() {
    return getIt<Localize>().selectedLanguage.value;
  }
  bool allowRTLDirectionality() => false;

  TextDirection getTextDirection() =>
      getLayoutDirection() == LayoutDirection.ltr
          ? TextDirection.ltr
          : TextDirection.rtl;
}