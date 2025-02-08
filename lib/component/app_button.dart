import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppButton extends StatefulWidget {
  final String? text;
  final String? subText;
  final AppIconName? icon;
  final MainAxisAlignment align;
  final Radio? radio;
  final Color? iconColor;
  final double? iconSize;
  final Function() onTap;
  final TextStyle textStyle;
  final TextStyle? subTextStyle;
  final Color textColor;
  final Color bgColor;
  final Color bgHoverColor;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final Color focusBorderColor;
  final EdgeInsetsGeometry? padding;
  final bool disable;
  final bool? isRTL;
  final bool isLoading;
  final bool isIconNetwork;

  const AppButton._internal(
      {super.key,
      required this.text,
      this.subText,
      this.icon,
      this.radio,
      this.iconColor,
      this.iconSize,
      required this.onTap,
      required this.textStyle,
      this.subTextStyle,
      required this.textColor,
      required this.bgColor,
      required this.bgHoverColor,
      this.border,
      this.borderRadius,
      required this.focusBorderColor,
      required this.padding,
      required this.disable,
      this.isRTL,
      required this.align,
      required this.isLoading,
      required this.isIconNetwork});

  factory AppButton.buttonPrimary({
    Key? key,
    String? text,
    required BuildContext context,
    required Function() onTap,
    EdgeInsetsGeometry? padding,
    bool disable = false,
    bool isLoading = false,
    bool isIconNetwork = false,
  }) =>
      AppButton._internal(
        text: text,
        key: key,
        onTap: onTap,
        textStyle: Theme.of(context)
            .appTexts
            .textMdSemiBold
            .copyWith(color: Theme.of(context).appColors.buttonPrimaryFg),
        align: MainAxisAlignment.center,
        textColor: disable
            ? Theme.of(context).appColors.fgDisabled
            : Theme.of(context).appColors.buttonPrimaryFg,
        bgColor: disable
            ? Theme.of(context).appColors.bgDisabled
            : Theme.of(context).appColors.buttonPrimaryBg,
        bgHoverColor: Theme.of(context).appColors.buttonPrimaryBgHover,
        padding: padding,
        border: disable
            ? Theme.of(context).appDimensions.borderDisablePrimaryButton
            : Theme.of(context).appDimensions.borderPrimaryButton,
        focusBorderColor: Theme.of(context).appColors.borderBrand,
        disable: disable,
        isLoading: isLoading,
        isIconNetwork: isIconNetwork,
      );

  factory AppButton.buttonTertiary({
    Key? key,
    AppIconName? icon,
    bool isRTL = false,
    String? text,
    Color? textColor,
    TextStyle? textStyle,
    required BuildContext context,
    required Function() onTap,
    EdgeInsetsGeometry? padding,
    MainAxisAlignment align = MainAxisAlignment.center,
    bool disable = false,
    Color? bgColor,
    Color? bgHoverColor,
    BoxBorder? border,
    bool isLoading = false,
    bool isIconNetwork = false,
  }) =>
      AppButton._internal(
        text: text,
        icon: icon,
        iconSize: 12,
        iconColor:
            textStyle?.color ?? Theme.of(context).appColors.buttonTeritoryFg,
        isRTL: isRTL,
        align: align,
        key: key,
        onTap: onTap,
        disable: disable,
        textStyle: textStyle ??
            Theme.of(context)
                .appTexts
                .textMdSemiBold
                .copyWith(color: Theme.of(context).appColors.buttonTeritoryFg),
        textColor: textColor ??
            (disable
                ? Theme.of(context).appColors.fgDisabled
                : Theme.of(context).appColors.textSecondary700),
        bgColor: bgColor ?? Colors.transparent,
        bgHoverColor: bgHoverColor ?? Theme.of(context).appColors.bgActive,
        focusBorderColor: Theme.of(context).appColors.borderBrand,
        padding: padding,
        border: border,
        isLoading: isLoading,
        isIconNetwork: isIconNetwork,
      );

  factory AppButton.buttonIcon(
    AppIconName icon, {
    double? iconSize,
    String? text,
    Color? iconColor,
    Key? key,
    required Color bgColor,
    required Color bgHoverColor,
    required Color textColor,
    BoxBorder? border,
    MainAxisAlignment align = MainAxisAlignment.center,
    BorderRadiusGeometry? borderRadius,
    bool isRTL = false,
    required BuildContext context,
    required Function() onTap,
    EdgeInsetsGeometry? padding,
    bool disable = false,
    bool isIconNetwork = false,
  }) =>
      AppButton._internal(
        text: text,
        key: key,
        icon: icon,
        iconColor: iconColor,
        iconSize: iconSize,
        onTap: onTap,
        align: align,
        textStyle: Theme.of(context)
            .appTexts
            .textMdSemiBold
            .copyWith(color: Theme.of(context).appColors.buttonPrimaryFg),
        textColor: textColor,
        bgColor: bgColor,
        border: border,
        borderRadius: borderRadius,
        isRTL: isRTL,
        bgHoverColor: bgHoverColor,
        focusBorderColor: Theme.of(context).appColors.borderBrand,
        padding: padding,
        disable: disable,
        isLoading: false,
        isIconNetwork: isIconNetwork,
      );

  factory AppButton.radio(
    Radio radio, {
    double? iconSize,
    required String text,
    String? subText,
    required TextStyle textStyle,
    TextStyle? subTextStyle,
    Color? iconColor,
    Key? key,
    required Color bgColor,
    required Color bgHoverColor,
    required Color textColor,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
    bool isRTL = false,
    required BuildContext context,
    required Function() onTap,
    EdgeInsetsGeometry? padding,
    bool disable = false,
    bool isIconNetwork = false,
  }) =>
      AppButton._internal(
        text: text,
        subText: subText,
        key: key,
        radio: radio,
        iconColor: iconColor,
        align: MainAxisAlignment.center,
        iconSize: iconSize,
        onTap: onTap,
        textStyle: textStyle,
        subTextStyle: subTextStyle,
        textColor: textColor,
        bgColor: bgColor,
        border: border,
        borderRadius: borderRadius,
        isRTL: isRTL,
        bgHoverColor: bgHoverColor,
        focusBorderColor: Theme.of(context).appColors.borderBrand,
        padding: padding,
        disable: disable,
        isLoading: false,
        isIconNetwork: false,
      );

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool isHovering = false;
  bool isPressing = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: widget.disable
          ? null
          : () {
              if (!widget.disable) {
                widget.onTap();
              }
            },

      onHover: widget.disable
          ? null
          : (hovering) {
              if (!widget.disable) {
                setState(() => isHovering = hovering);
              }
            },
      child:
          // Focused Border
          // AnimatedContainer(
          // duration: const Duration(milliseconds: 200),
          // decoration: BoxDecoration(
          //     color: Colors.transparent,
          //     borderRadius:
          //         Theme.of(context).appDimensions.radiusBorderPrimaryButton,
          //     border: Border.all(
          //       color:
          //           isPressing ? widget.focusBorderColor : Colors.transparent,
          //       width: 2.0,
          //     )),
          // child:
          // Button
          AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
        padding: widget.padding,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: isHovering ? widget.bgHoverColor : widget.bgColor,

          borderRadius: widget.borderRadius ??
              Theme.of(context).appDimensions.radiusPrimaryButton,
          border: widget.border,
          // boxShadow: const [
          //   BoxShadow(
          //       color: Color(0xffA67A4E),
          //       blurRadius: 0,
          //       offset: Offset(0, 0),
          //       spreadRadius: 1,
          //       blurStyle: BlurStyle.solid),
          // ],
        ),
        child: widget.isLoading
            ? Lottie.asset(
                'assets/anims/loading.json',
                // width: 100,
                height: 20,
                repeat: true,
                alignment: Alignment.center,
                fit: BoxFit.fill,
              )
            : Row(
                mainAxisAlignment: widget.align,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.isRTL != null && !widget.isRTL! && widget.radio != null
                      ? Padding(
                          padding: EdgeInsets.only(
                              right: widget.text != null ? 12 : 0),
                          child: widget.radio)
                      : Container(),
                  widget.isRTL != null && !widget.isRTL! && widget.icon != null
                      ? Padding(
                          padding: EdgeInsets.only(
                              right: widget.text != null ? 12 : 0),
                          child: AppIcon.button(
                              appIconName: widget.icon!,
                              context: context,
                              size: widget.iconSize ?? 15,
                              color: widget.iconColor),
                        )
                      : Container(),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.text != null
                            ? Text(widget.text!,
                                style: widget.textStyle
                                    .copyWith(color: widget.textColor))
                            : Container(),
                        widget.subText != null
                            ? Text(widget.subText!, style: widget.subTextStyle)
                            : Container(),
                      ]),
                  widget.isRTL != null && widget.isRTL! && widget.icon != null
                      ? Padding(
                          padding: EdgeInsets.only(
                              left: widget.text != null ? 12 : 0),
                          child: AppIcon.button(
                              appIconName: widget.icon!,
                              context: context,
                              size: widget.iconSize ?? 15,
                              color: widget.iconColor),
                        )
                      : Container(),
                  widget.isRTL != null && widget.isRTL! && widget.icon != null
                      ? Padding(
                          padding: EdgeInsets.only(
                              left: widget.text != null ? 12 : 0),
                          child: widget.radio)
                      : Container(),
                ],
              ),
      ),
      // )
    );
  }
}
