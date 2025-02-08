import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/apps/helper/utils/country_model.dart';
import 'package:billit_now/component/app_text_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class AppInputDropDown extends StatefulWidget {
  final bool enabled;
  final String? labelText;
  final String placeHolder;
  final TextStyle? placeHolderStyle;
  final String searchPlaceHolder;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final List<DropdownMenuItem<CountryModel>> items;
  final CountryModel? selectedValue;
  final Function(CountryModel?) onChanged;

  const AppInputDropDown._internal({
    super.key,
    required this.enabled,
    this.labelText,
    required this.placeHolder,
    this.placeHolderStyle,
    required this.searchPlaceHolder,
    this.border,
    this.borderRadius,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  factory AppInputDropDown.counrtyCode({
    Key? key,
    bool enabled = true,
    required BuildContext context,
    String? labelText,
    required String placeHolder,
    TextStyle? placeHolderStyle,
    required String searchPlaceHolder,
    required List<DropdownMenuItem<CountryModel>> items,
    CountryModel? selectedValue,
    BoxBorder? border,
    BorderRadius? borderRadius,
    required Function(CountryModel?) onChanged,
  }) =>
      AppInputDropDown._internal(
        key: key,
        enabled: enabled,
        labelText: labelText,
        placeHolder: placeHolder,
        placeHolderStyle: placeHolderStyle ??
            Theme.of(context)
                .appTexts
                .textMdRegular
                .copyWith(color: Theme.of(context).appColors.textPlaceholder),
        searchPlaceHolder: searchPlaceHolder,
        // helpText: helpText,

        border: border ??
            Border.all(
              color: Theme.of(context).appColors.borderPrimary,
            ),
        borderRadius:
            borderRadius ?? const BorderRadius.all(Radius.circular(8.0)),
        items: items,
        selectedValue: selectedValue,
        onChanged: onChanged,
      );

  @override
  State<AppInputDropDown> createState() => _AppInputDropDownState();
}

class _AppInputDropDownState extends State<AppInputDropDown> {
  final TextEditingController textEditingController = TextEditingController();
  CountryModel? selectedItem;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelText != null
            ? Text(widget.labelText!,
                style: Theme.of(context).appTexts.textSmMedium.copyWith(
                    color: Theme.of(context).appColors.textSecondary700))
            : Container(),
        SizedBox(height: widget.labelText != null ? 6.0 : 0.0),
        DropdownButtonHideUnderline(
            child: DropdownButton2<CountryModel>(
          isExpanded: true,
          hint: Text(
            widget.placeHolder,
            style: widget.placeHolderStyle,
          ),
          items: widget.items,
          value: selectedItem ?? widget.selectedValue,
          onChanged: widget.enabled
              ? (value) {
                  widget.onChanged(value);
                  setState(() {
                    selectedItem = value;
                  });
                }
              : null,
          buttonStyleData: ButtonStyleData(
              decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            border: widget.border,
          )),
          dropdownStyleData: DropdownStyleData(
              maxHeight: 400,
              decoration: BoxDecoration(
                color: Theme.of(context).appColors.bgPrimary,
              )),
          menuItemStyleData: const MenuItemStyleData(height: 50),
          dropdownSearchData: DropdownSearchData(
            searchController: textEditingController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: AppTextField.main(
                    controller: textEditingController,
                    keyboardType: TextInputType.text,
                    placeHolder: widget.searchPlaceHolder,
                    helpText: '',
                    icon: AppIconName.ueb1dSearchLg,
                    validator: (value) => null)),
            searchMatchFn:
                (DropdownMenuItem<CountryModel> item, String searchValue) {
              CountryModel country = item.value as CountryModel;
              return country.name
                      .toLowerCase()
                      .contains(searchValue.trim().toLowerCase()) ||
                  country.code
                      .toLowerCase()
                      .contains(searchValue.trim().toLowerCase()) ||
                  country.dialCode.contains(searchValue.trim().toLowerCase());
            },
          ),
          //This to clear the search value when you close the menu
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              textEditingController.clear();
            }
          },
        )),
      ],
    );
  }
}
