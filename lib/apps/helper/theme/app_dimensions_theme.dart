import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:flutter/material.dart';

class AppDimensionsTheme extends ThemeExtension<AppDimensionsTheme> {
  final BorderRadius radiusPrimaryButton;
  final BoxBorder borderPrimaryButton;
  final BoxBorder borderPrimary;
  final BoxBorder borderDisablePrimaryButton;
  final BoxBorder borderThirdParty;
  final BorderRadius radiusBorderPrimaryButton;
  final double highlightHeightResponsive;
  final ColorFilter blackAndWhiteFilter;

  final EdgeInsets horizontalRespoonsivePaddingLoginSingUp;
  final BoxConstraints minMaxWidthLoginSingUp;
  final EdgeInsets topBottonMarginLoginSingUp;

  const AppDimensionsTheme._internal(
      {required this.radiusPrimaryButton,
      required this.borderPrimaryButton,
      required this.borderPrimary,
      required this.borderDisablePrimaryButton,
      required this.borderThirdParty,
      required this.radiusBorderPrimaryButton,
      required this.blackAndWhiteFilter,
      required this.minMaxWidthLoginSingUp,
      required this.topBottonMarginLoginSingUp,
      required this.horizontalRespoonsivePaddingLoginSingUp,
      required this.highlightHeightResponsive});

  factory AppDimensionsTheme.main(BuildContext context) =>
      AppDimensionsTheme._internal(
        radiusPrimaryButton: BorderRadius.circular(8),
        borderPrimaryButton:
            Border.all(width: 1, color: const Color(0xFF7F5A30)),
        borderDisablePrimaryButton:
            Border.all(width: 1, color: const Color(0xffE5E5E5)),
        borderPrimary: Border.all(width: 1, color: const Color(0xFFD4D4D4)),
        borderThirdParty: Border.all(
            width: 2, color: const Color(0xFFFFFFFF).withOpacity(0.12)),
        radiusBorderPrimaryButton: BorderRadius.circular(14),
        minMaxWidthLoginSingUp: BoxConstraints(
            maxWidth: 400, minWidth: 375, minHeight: context.logicalHeight),
        topBottonMarginLoginSingUp: const EdgeInsets.only(top: 64, bottom: 48),
        horizontalRespoonsivePaddingLoginSingUp: EdgeInsets.symmetric(
            horizontal: context.isSmallSmartphone
                ? 16
                : context.isRegularSmartphoneOrLess
                    ? 32
                    : context.isSmallTabletOrLess
                        ? 128
                        : context.isRegularTabletOrLess
                            ? 256
                            : 512),
        highlightHeightResponsive: context.logicalWidth < 400
            ? 1600
            : context.logicalWidth < 500
                ? 1800
                : context.logicalWidth < 600
                    ? 2000
                    : context.logicalWidth < 700
                        ? 2300
                        : context.logicalWidth < 800
                            ? 2600
                            : context.isSmallTabletOrLess ||
                                    context.logicalWidth < 1200
                                ? context.logicalHeight + 400
                                : context.logicalHeight,
        blackAndWhiteFilter: ColorFilter.matrix(
          <double>[
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0,
            0,
            0,
            1,
            0,
          ],
        ),
      );

  @override
  ThemeExtension<AppDimensionsTheme> copyWith() {
    return AppDimensionsTheme._internal(
        radiusPrimaryButton: radiusPrimaryButton,
        borderPrimary: borderPrimary,
        radiusBorderPrimaryButton: radiusBorderPrimaryButton,
        borderPrimaryButton: borderPrimaryButton,
        borderThirdParty: borderThirdParty,
        borderDisablePrimaryButton: borderDisablePrimaryButton,
        minMaxWidthLoginSingUp: minMaxWidthLoginSingUp,
        topBottonMarginLoginSingUp: topBottonMarginLoginSingUp,
        horizontalRespoonsivePaddingLoginSingUp:
            horizontalRespoonsivePaddingLoginSingUp,
        highlightHeightResponsive: highlightHeightResponsive,
        blackAndWhiteFilter: blackAndWhiteFilter);
  }

  @override
  ThemeExtension<AppDimensionsTheme> lerp(
          covariant ThemeExtension<AppDimensionsTheme>? other, double t) =>
      this;
}
