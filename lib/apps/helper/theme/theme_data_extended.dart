import 'package:billit_now/apps/helper/theme/app_colors_theme.dart';
import 'package:billit_now/apps/helper/theme/app_dimensions_theme.dart';
import 'package:billit_now/apps/helper/theme/app_texts_theme.dart';
import 'package:flutter/material.dart';

extension ThemeDataExtended on ThemeData {
  AppDimensionsTheme get appDimensions => extension<AppDimensionsTheme>()!;
  AppColorsTheme get appColors => extension<AppColorsTheme>()!;
  AppTextsTheme get appTexts => extension<AppTextsTheme>()!;
}
