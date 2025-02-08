import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final bool enable;
  final String? initValue;
  final TextInputType? keyboardType;
  final String? labelText;
  final Color? fillColor;
  final String? placeHolder;
  final String? helpText;
  final String? errorText;
  final AppIconName? icon;
  final Color? iconColor;
  final double? iconSize;
  final BorderSide? borderSide;
  final BorderRadius borderRadius;
  final bool isObscure;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const AppTextField._internal(
      {super.key,
      this.controller,
      this.keyboardType,
      this.labelText,
      this.placeHolder,
      this.helpText,
      this.fillColor,
      this.errorText,
      this.icon,
      this.iconColor,
      this.iconSize,
      this.enable = true,
      this.initValue,
      required this.borderSide,
      required this.borderRadius,
      this.isObscure = false,
      this.inputFormatters,
      required this.enabled,
      this.validator,
      this.onChanged});

  factory AppTextField.main(
          {Key? key,
          TextEditingController? controller,
          bool enable = true,
          String? initValue,
          required TextInputType keyboardType,
          String? labelText,
          Color? fillColor,
          required String placeHolder,
          required String helpText,
          AppIconName? icon,
          Color? iconColor,
          double? iconSize,
          bool isObscure = false,
          BorderSide? borderSide,
          BorderRadius? borderRadius,
          bool enabled = true,
          required String? Function(String?) validator,
          Function(String)? onChanged}) =>
      AppTextField._internal(
        key: key,
        controller: controller,
        enable: enable,
        initValue: initValue,
        keyboardType: keyboardType,
        labelText: labelText,
        fillColor: fillColor,
        placeHolder: placeHolder,
        isObscure: isObscure,
        icon: icon,
        iconColor: iconColor,
        iconSize: iconSize,
        helpText: helpText,
        borderSide: borderSide,

        borderRadius: borderRadius ?? BorderRadius.circular(8),
        // errorText: errorText,
        // inputFormatters: inputFormatters,
        validator: validator,
        onChanged: onChanged,
        enabled: enabled,
      );

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isPassword = false;
  bool isObscure = false;

  @override
  void initState() {
    isPassword = widget.isObscure;
    isObscure = widget.isObscure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelText != null
            ? Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  widget.labelText!,
                  style: Theme.of(context).appTexts.textSmMedium.copyWith(
                      color: Theme.of(context).appColors.textSecondary700),
                ),
              )
            : Container(),
        TextFormField(
            enabled: widget.enable,
            initialValue: widget.enable ? null : widget.initValue,
            controller: widget.enable ? widget.controller : null,
            keyboardType: widget.keyboardType,
            maxLines: 1,
            obscureText: isObscure,
            obscuringCharacter: "*",
            cursorColor: Theme.of(context).appColors.borderBrand,
            style: Theme.of(context)
                .appTexts
                .textMdRegular
                .copyWith(color: Theme.of(context).appColors.textPrimary900),
            decoration: InputDecoration(
                prefixIcon: widget.icon != null
                    ? Padding(
                        padding: EdgeInsets.all(widget.iconSize ?? 15),
                        child: AppIcon.button(
                          appIconName: widget.icon!,
                          context: context,
                          size: widget.iconSize ?? 15,
                        ),
                      )
                    : null,
                suffixIcon: isPassword
                    ? IconButton(
                        icon: Icon(isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(
                            () {
                              isObscure = !isObscure;
                            },
                          );
                        },
                      )
                    : null,
                prefixIconColor: widget.iconColor,
                filled: true,
                fillColor:
                    widget.fillColor ?? Theme.of(context).appColors.bgSecondary,
                hintText: widget.placeHolder,
                hintStyle: Theme.of(context).appTexts.textMdMedium.copyWith(
                    color: Theme.of(context).appColors.textPlaceholder),
                errorText: widget.errorText,
                border: OutlineInputBorder(
                  borderRadius: widget.borderRadius,
                  borderSide: BorderSide(
                    color: Theme.of(context).appColors.borderPrimary,
                    width: 1.0,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: widget.borderRadius,
                  borderSide: widget.borderSide ??
                      BorderSide(
                        color: Theme.of(context).appColors.borderPrimary,
                        width: 1.0,
                      ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: widget.borderRadius,
                  borderSide: widget.borderSide ??
                      BorderSide(
                        color: Theme.of(context).appColors.borderPrimary,
                        width: 1.0,
                      ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: widget.borderRadius,
                  borderSide: BorderSide(
                    color: Theme.of(context).appColors.borderError,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: widget.borderRadius,
                  borderSide: BorderSide(
                    color: Theme.of(context).appColors.borderBrand,
                    width: 1.0,
                  ),
                )),
            onChanged: widget.onChanged,
            inputFormatters: widget.inputFormatters,
            validator: widget.validator),
        widget.helpText != null
            ? Text(
                widget.helpText!,
                style: Theme.of(context).appTexts.textSmRegular.copyWith(
                    color: Theme.of(context).appColors.textTeritory600),
              )
            : Container(),
      ],
    );
  }
}
