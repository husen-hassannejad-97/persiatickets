import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:flutter/material.dart';

class AppSwitch extends StatefulWidget {
  final String? label;
  final Color? diableColor;
  final Color? enableColor;
  final bool enable;
  final Function(bool value) onChange;

  const AppSwitch._internal(
      {super.key,
      this.label,
      this.diableColor,
      this.enableColor,
      this.enable = false,
      required this.onChange});

  factory AppSwitch.main(
          {Key? key,
          String? label,
          Color? diableColor,
          Color? enableColor,
          bool enable = false,
          required Function(bool value) onChange}) =>
      AppSwitch._internal(
          label: label,
          diableColor: diableColor,
          enableColor: enableColor,
          enable: enable,
          onChange: onChange);

  @override
  State<AppSwitch> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  bool? value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          activeColor: Colors.white,
          activeTrackColor: widget.enableColor,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: widget.diableColor,
          value: value ?? widget.enable,
          onChanged: (val) {
            setState(() {
              value = val;
            });
            widget.onChange(val);
          },
        ),
        widget.label != null ? const SizedBox(width: 12) : Container(),
        widget.label != null
            ? Text(widget.label!,
                style: Theme.of(context).appTexts.textMdMedium.copyWith(
                    color: Theme.of(context).appColors.textSecondary700))
            : Container()
      ],
    );
  }
}
