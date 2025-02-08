import 'package:billit_now/core/di/di_setup.dart';
import 'package:flutter/material.dart';

import '../../core/localization/languages.dart';
import '../../core/localization/layout_direction.dart';
import '../../core/localization/localize.dart';

mixin BasePageMixin {
  List<dynamic> setProviders(BuildContext context) {
    return [];
  }
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