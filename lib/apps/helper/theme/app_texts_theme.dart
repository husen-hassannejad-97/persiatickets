import 'package:flutter/material.dart';

class AppTextsTheme extends ThemeExtension<AppTextsTheme> {
  static const _fontFamilyBody = "SourceSans3";
  static const _fontFamilyDisplay = "SourceSerif4";
  // static const _yekanBakh = "yekan_bakh";

  final TextStyle displaySmSemiBold;
  final TextStyle displayXlSemibold;
  final TextStyle displayLgSemibold;
  final TextStyle displayMdSemibold;
  final TextStyle textMdSemiBold;
  final TextStyle textMdRegular;
  final TextStyle textSmRegular;
  final TextStyle textSmMedium;
  final TextStyle textMdMedium;
  final TextStyle textSmSemiBord;
  final TextStyle textLgSemiBold;
  final TextStyle textXlSemibold;
  final TextStyle textLgRegular;
  final TextStyle textXlRegular;
  final TextStyle displaySmSemibold;
  final TextStyle displayXsSemibold;
  final TextStyle textXsMedium;
  final TextStyle textXsSemibold;

  const AppTextsTheme._internal({
    required this.displaySmSemiBold,
    required this.displayXlSemibold,
    required this.textMdSemiBold,
    required this.textMdRegular,
    required this.textSmRegular,
    required this.textSmMedium,
    required this.textMdMedium,
    required this.textSmSemiBord,
    required this.textLgSemiBold,
    required this.displayMdSemibold,
    required this.textLgRegular,
    required this.textXlRegular,
    required this.displaySmSemibold,
    required this.displayXsSemibold,
    required this.displayLgSemibold,
    required this.textXlSemibold,
    required this.textXsMedium,
    required this.textXsSemibold,
  });

  factory AppTextsTheme.main() => const AppTextsTheme._internal(
        displaySmSemiBold: TextStyle(
            fontFamily: _fontFamilyDisplay,
            fontWeight: FontWeight.w600,
            letterSpacing: -2,
            fontSize: 30),
        displayXlSemibold: TextStyle(
            fontFamily: _fontFamilyDisplay,
            fontWeight: FontWeight.w600,
            letterSpacing: -2,
            fontSize: 60),
        displayMdSemibold: TextStyle(
            fontFamily: _fontFamilyDisplay,
            fontWeight: FontWeight.w600,
            letterSpacing: -2,
            fontSize: 36),
        textMdRegular: TextStyle(
            fontFamily: _fontFamilyBody,
            fontWeight: FontWeight.w400,
            fontSize: 16),
        textSmRegular: TextStyle(
            fontFamily: _fontFamilyBody,
            fontWeight: FontWeight.w400,
            fontSize: 14),
        textSmMedium: TextStyle(
            fontFamily: _fontFamilyBody,
            fontWeight: FontWeight.w500,
            fontSize: 14),
        textMdMedium: TextStyle(
            fontFamily: _fontFamilyBody,
            fontWeight: FontWeight.w400,
            fontSize: 16),
        textMdSemiBold: TextStyle(
            fontFamily: _fontFamilyBody,
            fontWeight: FontWeight.w600,
            fontSize: 16),
        textSmSemiBord: TextStyle(
            fontFamily: _fontFamilyBody,
            fontWeight: FontWeight.w600,
            fontSize: 14),
        textLgSemiBold: TextStyle(
            fontFamily: _fontFamilyBody,
            fontWeight: FontWeight.w600,
            fontSize: 18),
        textLgRegular: TextStyle(
            fontFamily: _fontFamilyBody,
            fontWeight: FontWeight.w400,
            fontSize: 18),
        textXlRegular: TextStyle(
            fontFamily: _fontFamilyBody,
            fontWeight: FontWeight.w400,
            height: 30,
            fontSize: 20),
        displaySmSemibold: TextStyle(
            fontFamily: _fontFamilyBody,
            fontWeight: FontWeight.w600,
            letterSpacing: -2,
            fontSize: 30),
        displayXsSemibold: TextStyle(
            fontFamily: _fontFamilyBody,
            fontWeight: FontWeight.w600,
            fontSize: 24),
        displayLgSemibold: TextStyle(
            fontFamily: _fontFamilyDisplay,
            fontWeight: FontWeight.w600,
            letterSpacing: -2,
            fontSize: 48),
        textXlSemibold: TextStyle(
            fontFamily: _fontFamilyBody,
            fontWeight: FontWeight.w600,
            fontSize: 20),
        textXsMedium: TextStyle(
            fontFamily: _fontFamilyBody,
            fontWeight: FontWeight.w500,
            fontSize: 12),
        textXsSemibold: TextStyle(
            fontFamily: _fontFamilyBody,
            fontWeight: FontWeight.w600,
            fontSize: 12),
      );

  @override
  ThemeExtension<AppTextsTheme> copyWith() {
    return AppTextsTheme._internal(
        displaySmSemiBold: displaySmSemiBold,
        displayXlSemibold: displayXlSemibold,
        displayMdSemibold: displayMdSemibold,
        textMdSemiBold: textMdSemiBold,
        textMdRegular: textMdRegular,
        textSmRegular: textSmRegular,
        textSmMedium: textSmMedium,
        textMdMedium: textMdMedium,
        textSmSemiBord: textSmSemiBord,
        textLgSemiBold: textLgSemiBold,
        textLgRegular: textLgRegular,
        textXlRegular: textXlRegular,
        displaySmSemibold: displaySmSemibold,
        displayXsSemibold: displayXsSemibold,
        displayLgSemibold: displayLgSemibold,
        textXlSemibold: textXlSemibold,
        textXsMedium: textXsMedium,
        textXsSemibold: textXsSemibold);
  }

  @override
  ThemeExtension<AppTextsTheme> lerp(
          covariant ThemeExtension<AppTextsTheme>? other, double t) =>
      this;
}
