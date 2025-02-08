import 'package:flutter/material.dart';

class AppColorsTheme extends ThemeExtension<AppColorsTheme> {
  // Base
  static const _white = Color(0xFFFFFFFF);
  static const _black = Color(0xFF000000);
  static const _transparent = Colors.transparent;

  // Gray
  static const _gray50 = Color(0xFFFAFAFA);
  static const _gray100 = Color(0xFFF5F5F5);
  static const _gray200 = Color(0xFFE5E5E5);
  static const _gray300 = Color(0xFFD4D4D4);
  static const _gray400 = Color(0xFFA3A3A3);
  static const _gray500 = Color(0xFF737373);
  static const _gray600 = Color(0xFF525252);
  static const _gray700 = Color(0xFF404040);
  static const _gray800 = Color(0xFF262626);
  static const _gray900 = Color(0xFF171717);
  static const _gray950 = Color(0xFF0A0A0A);

  // Brand
  static const _brand50 = Color(0xFFF5E9DA);
  static const _brand100 = Color(0xFFECDCCC);
  static const _brand200 = Color(0xFFDBC1A1);
  static const _brand300 = Color(0xFFC9A180);
  static const _brand400 = Color(0xFFB88C64);
  static const _brand500 = Color(0xFFA67A4E);
  static const _brand600 = Color(0xFF8B6436);
  static const _brand700 = Color(0xFF7F5A30);
  static const _brand800 = Color(0xFF6D4A26);
  static const _brand900 = Color(0xFF5D3D1F);
  static const _brand950 = Color(0xFF4E3117);

  // Warning
  static const _warning200 = Color(0xFFFEDF89);
  static const _warning400 = Color(0xFFFDB022);
  static const _warning500 = Color(0xFFF79009);
  static const _warning300 = Color(0xFFFEC84B);
  static const _warning600 = Color(0xFFDC6803);

  // Error
  static const _error400 = Color(0xFFF97066);
  static const _error500 = Color(0xFFC85454);
  static const _error600 = Color(0xFFAD3B3B);

  // Success
  static const _success300 = Color(0xFF75E0A7);
  static const _success400 = Color(0xFF47CD89);
  static const _success500 = Color(0xFF17B26A);
  static const _success600 = Color(0xFF079455);

  // Alpha
  static const _alphaWite20 = Color(0xFF0A0A0A);
  static const _alphaWite30 = Color(0xFF0A0A0A);

  // Vanilla
  static const _vanilla900 = Color(0xFF554239);

  // Mallard
  static const _mallard100 = Color(0xFFE9F3D8);
  static const _mallard600 = Color(0xFF5F8B2D);

  // Border
  final Color borderPrimary;
  final Color borderSecondary;
  final Color borderBrand;
  final Color borderError;
  final Color fgBrandPrimary600;

  // Mallard
  final Color mallard100;
  final Color mallard600;

  // Foreground
  final Color fgDisabled;
  final Color fgBrandPrimaryAlt;
  final Color fgDisabledSubtle;
  final Color fgSecondary700;
  final Color fgPrimary900;
  final Color fgQuinary400;
  final Color fgTertiary600;
  final Color textBrandSecondary700;
  final Color fgWarningPrimary;

  // bg
  final Color bgPrimary;
  final Color bgPrimaryHover;
  final Color bgBrand;
  final Color bgSecondary;
  final Color bgSecondaryHover;
  final Color bgDisabled;
  final Color bgActive;
  final Color bgQuaternary;
  final Color bgSuccessSolid;
  final Color bgBrandSolid;
  final Color bgTertiary;
  final Color bgOverlay;

  // Text
  final Color textWhite;
  final Color textPrimary900;
  final Color textErrorPrimary600;

  final Color textSecondary700;
  final Color textPlaceholder;

  final Color textTeritory600;
  final Color textQuaternary500;
  final Color textWarningPrimary600;

  // Button
  final Color buttonPrimaryFg;
  final Color buttonPrimaryBg;
  final Color buttonPrimaryBgHover;

  final Color buttonSecondaryFgHover;
  final Color buttonSecondaryFg;
  final Color buttonSecondaryBorder;

  final Color buttonTeritoryFg;
  final Color buttonTeritoryFgHover;
  final Color buttonTeritoryColorFg;

  // Success
  final Color textSuccessPrimary;
  final Color utilitySuccess700;
  final Color utilitySuccess600;
  final Color utilitySuccess500;

  // Warning
  final Color bgWarningSecondary;
  final Color utilityWarning200;
  final Color utilityWarning600;
  final Color utilityWarning700;

  // Error
  final Color utilityError500;

  // Breadcrumbs
  final Color breadcrumbFg;
  final Color breadcrumbBrandFgHover;

  // Component Colors / Components / Icons / Modern
  final Color featuredIconModernBorder;

  // Component colors / Alpha
  final Color alphaWite20;
  final Color alphaWite30;

  // Components / Application navigation
  final Color navItemIconFg;

  // Vanilla
  final Color vanilla900;

  const AppColorsTheme._internal(
      {required this.borderPrimary,
      required this.borderBrand,
      required this.textErrorPrimary600,
      required this.borderError,
      required this.textPlaceholder,
      required this.textPrimary900,
      required this.textSecondary700,
      required this.buttonPrimaryFg,
      required this.buttonTeritoryFg,
      required this.buttonSecondaryFgHover,
      required this.buttonSecondaryFg,
      required this.buttonSecondaryBorder,
      required this.borderSecondary,
      required this.bgBrand,
      required this.bgSecondary,
      required this.textTeritory600,
      required this.bgPrimary,
      required this.fgDisabled,
      required this.buttonTeritoryFgHover,
      required this.bgDisabled,
      required this.buttonPrimaryBg,
      required this.buttonPrimaryBgHover,
      required this.bgActive,
      required this.bgPrimaryHover,
      required this.featuredIconModernBorder,
      required this.fgBrandPrimaryAlt,
      required this.bgQuaternary,
      required this.alphaWite20,
      required this.fgDisabledSubtle,
      required this.bgSuccessSolid,
      required this.bgTertiary,
      required this.bgBrandSolid,
      required this.fgSecondary700,
      required this.alphaWite30,
      required this.fgPrimary900,
      required this.fgQuinary400,
      required this.textWhite,
      required this.fgTertiary600,
      required this.vanilla900,
      required this.textBrandSecondary700,
      required this.textQuaternary500,
      required this.bgOverlay,
      required this.navItemIconFg,
      required this.breadcrumbFg,
      required this.breadcrumbBrandFgHover,
      required this.mallard600,
      required this.mallard100,
      required this.textSuccessPrimary,
      required this.textWarningPrimary600,
      required this.fgBrandPrimary600,
      required this.buttonTeritoryColorFg,
      required this.bgSecondaryHover,
      required this.utilitySuccess700,
      required this.utilitySuccess600,
      required this.utilitySuccess500,
      required this.utilityWarning700,
      required this.utilityWarning600,
      required this.utilityError500,
      required this.bgWarningSecondary,
      required this.utilityWarning200,
      required this.fgWarningPrimary});

  // factory for light mode:
  factory AppColorsTheme.dark() {
    return const AppColorsTheme._internal(
        borderPrimary: _gray700,
        borderBrand: _brand400,
        textErrorPrimary600: _error400,
        borderError: _error400,
        textPlaceholder: _gray500,
        textPrimary900: _gray50,
        textSecondary700: _gray300,
        buttonPrimaryFg: _white,
        buttonTeritoryFg: _gray400,
        buttonSecondaryFgHover: _gray100,
        buttonSecondaryFg: _gray300,
        buttonSecondaryBorder: _gray700,
        borderSecondary: _gray800,
        bgBrand: _brand900,
        bgSecondary: _gray900,
        textTeritory600: _gray400,
        bgPrimary: _gray950,
        buttonTeritoryFgHover: _gray200,
        fgDisabled: _gray500,
        bgDisabled: _gray800,
        buttonPrimaryBg: _brand400,
        buttonPrimaryBgHover: _brand500,
        bgActive: _gray800,
        bgPrimaryHover: _gray800,
        featuredIconModernBorder: _gray700,
        fgBrandPrimaryAlt: _gray300,
        bgQuaternary: _gray700,
        alphaWite20: _alphaWite20,
        alphaWite30: _alphaWite30,
        fgDisabledSubtle: _gray600,
        bgSuccessSolid: _success600,
        bgBrandSolid: _brand600,
        bgTertiary: _gray800,
        fgSecondary700: _gray300,
        fgPrimary900: _white,
        fgQuinary400: _gray500,
        textWhite: _white,
        fgTertiary600: _gray400,
        vanilla900: _vanilla900,
        textBrandSecondary700: _gray300,
        textQuaternary500: _gray400,
        bgOverlay: _gray800,
        navItemIconFg: _gray400,
        breadcrumbFg: _gray300,
        breadcrumbBrandFgHover: _white,
        mallard600: _mallard600,
        mallard100: _mallard100,
        textSuccessPrimary: _success400,
        textWarningPrimary600: _warning400,
        fgBrandPrimary600: _brand500,
        buttonTeritoryColorFg: _gray300,
        bgSecondaryHover: _gray800,
        utilitySuccess700: _success300,
        utilitySuccess600: _success400,
        utilitySuccess500: _success500,
        utilityWarning700: _warning300,
        utilityWarning600: _warning400,
        utilityError500: _error500,
        bgWarningSecondary: _warning600,
        utilityWarning200: _warning200,
        fgWarningPrimary: _warning500);
  }

  @override
  ThemeExtension<AppColorsTheme> copyWith() {
    // if (lightMode == null || lightMode == true) {
    //   return AppColorsTheme.light();
    // }
    // return AppColorsTheme.dark();
    return AppColorsTheme.dark();
  }

  @override
  ThemeExtension<AppColorsTheme> lerp(
          covariant ThemeExtension<AppColorsTheme>? other, double t) =>
      this;
}
