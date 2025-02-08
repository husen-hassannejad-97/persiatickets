import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class AppDropDown extends StatefulWidget {
  final List<String> items;
  final String? label;
  final String hint;
  final String? selectedValue;
  final Function(String?) onChanged;

  const AppDropDown._internal({
    super.key,
    required this.items,
    this.label,
    required this.hint,
    required this.selectedValue,
    required this.onChanged,
  });

  factory AppDropDown.def({
    Key? key,
    required List<String> items,
    String? label,
    required String hint,
    String? selectedValue,
    required Function(String?) onChanged,
  }) =>
      AppDropDown._internal(
          key: key,
          label: label,
          hint: hint,
          selectedValue: selectedValue,
          onChanged: onChanged,
          items: items);

  @override
  State<AppDropDown> createState() => _AppDropDownState();
}

class _AppDropDownState extends State<AppDropDown> {
  final TextEditingController textEditingController = TextEditingController();
  String? selectedItem;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label == null
            ? Container()
            : Text(widget.label!,
                style: Theme.of(context).appTexts.textSmMedium.copyWith(
                    color: Theme.of(context).appColors.textSecondary700)),
        SizedBox(height: 6.0),
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(widget.hint,
                style: Theme.of(context).appTexts.textMdRegular.copyWith(
                    color: Theme.of(context).appColors.textPrimary900)),
            items: List.generate(
                widget.items.length,
                (index) => DropdownMenuItem(
                    value: widget.items[index],
                    child: Text(widget.items[index],
                        style: Theme.of(context)
                            .appTexts
                            .textMdRegular
                            .copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textPrimary900)))),
            value: selectedItem ?? widget.selectedValue,
            onChanged: (String? value) {
              setState(() {
                selectedItem = value;
              });
            },
            buttonStyleData: ButtonStyleData(
                padding: EdgeInsets.only(left: 14, right: 14),
                elevation: 2,
                decoration: BoxDecoration(
                    color: Theme.of(context).appColors.bgSecondary,
                    border: Border.all(
                        color: Theme.of(context).appColors.borderPrimary),
                    borderRadius: BorderRadius.circular(8.0))),
            iconStyleData: IconStyleData(
              icon: AppIcon.button(
                  appIconName: AppIconName.chevronDown,
                  context: context,
                  size: 8),
              iconEnabledColor: Theme.of(context).appColors.fgQuinary400,
              iconDisabledColor: Theme.of(context).appColors.fgQuinary400,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).appColors.bgActive,
              ),
              offset: const Offset(0, 0),
            ),
          ),
        ),
      ],
    );
  }
}
