import 'package:billit_now/apps/helper/country_code/country_codes_data.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/country_model.dart';
import 'package:billit_now/component/app_input_dropdown.dart';
import 'package:billit_now/component/app_text_field.dart';
import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class CountryCode extends BaseStatefulWidget {
  const CountryCode(
      {super.key,
      required this.labelText,
      required this.dropdownPlaceHolder,
      required this.dropdownSearchPlaceHolder,
      required this.textFieldController,
      required this.selectedCountry,
      this.defaultSelected,
      required this.enabled,
      this.defaultTextFieldValue});

  final String labelText;
  final String dropdownPlaceHolder;
  final String dropdownSearchPlaceHolder;
  final TextEditingController textFieldController;
  final Function(CountryModel country) selectedCountry;
  final CountryModel? defaultSelected;
  final bool enabled;
  final String? defaultTextFieldValue;

  @override
  State<CountryCode> createState() => _CountryCodeState();
}

class _CountryCodeState extends BaseWidgetState<CountryCode> {
  late String textFieldPlaceHolder;
  late String selectedPhoneCode;
  late int selectedPhoneLenght;
  late List<CountryModel> countries;
  late CountryModel defaultSelected;

  @override
  void initState() {
    super.initState();
    countries = CountryCodes.getCountryModels();

    defaultSelected = widget.defaultSelected ?? countries[0];

    textFieldPlaceHolder = defaultSelected.format;
    selectedPhoneCode = defaultSelected.dialCode;
    selectedPhoneLenght = defaultSelected.mobileNumberLength;
  }

  @override
  Widget body(BuildContext context) {
    return Column(children: [
      AppInputDropDown.counrtyCode(
        context: context,
        labelText: widget.labelText,
        enabled: widget.enabled,
        placeHolder: widget.dropdownPlaceHolder,
        selectedValue: defaultSelected,
        searchPlaceHolder: widget.dropdownSearchPlaceHolder,
        items: List.generate(countries.length, (index) {
          return DropdownMenuItem(
              enabled: widget.enabled,
              value: countries[index],
              child: Row(children: [
                CountryFlag.fromCountryCode(
                  countries[index].code,
                  width: 25,
                  height: 25,
                  shape: const Circle(),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    countries[index].name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).appTexts.textMdMedium.copyWith(
                          color: Theme.of(context).appColors.textPrimary900,
                        ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '(+${countries[index].dialCode})',
                  style: Theme.of(context).appTexts.textMdRegular.copyWith(
                      color: Theme.of(context).appColors.textTeritory600),
                ),
              ]));
        }),
        border: Border(
          top: BorderSide(
            color: Theme.of(context).appColors.borderPrimary,
          ),
          right: BorderSide(
            color: Theme.of(context).appColors.borderPrimary,
          ),
          left: BorderSide(
            color: Theme.of(context).appColors.borderPrimary,
          ),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        onChanged: (CountryModel? value) {
          setState(() {
            textFieldPlaceHolder = value?.format ?? '';
            selectedPhoneCode = value?.dialCode ?? '';
            selectedPhoneLenght = value?.mobileNumberLength ?? 0;

            widget.selectedCountry(value ?? defaultSelected);
          });
        },
      ),
      AppTextField.main(
        controller: widget.textFieldController,
        keyboardType: TextInputType.phone,
        enable: widget.enabled,
        initValue: widget.defaultTextFieldValue,
        placeHolder: textFieldPlaceHolder,
        helpText: '',
        fillColor: Theme.of(context).appColors.bgSecondary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        borderSide: BorderSide(
          color: Theme.of(context).appColors.borderPrimary,
          width: 1.0,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return getString("please_enter_your_phone_number");
          } else if (num.tryParse(value) == null) {
            return getString("please_enter_valid_phone_number");
          } else if (value.length != selectedPhoneLenght) {
            return getString("please_enter_valid_phone_number");
          }

          return null;
        },
      ),
    ]);
  }
}
