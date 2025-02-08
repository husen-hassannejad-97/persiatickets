import 'dart:async';

import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/apps/helper/utils/country_model.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_text_field.dart';
import 'package:billit_now/component/signup_modal/stepper.dart';
import 'package:billit_now/repositories/event_map/models/stepper_num.dart';
import 'package:billit_now/templates/auth/widgets/country_code.dart';
import 'package:billit_now/templates/auth/widgets/main_logo.dart';
import 'package:flutter/material.dart';

class CheckPhone extends StatefulWidget {
  const CheckPhone(
      {super.key,
      required this.phoneNumber,
      required this.country,
      required this.verificationCode,
      required this.resendCode});

  final String phoneNumber;
  final CountryModel? country;
  final Function(String code) verificationCode;
  final Function() resendCode;

  @override
  State<CheckPhone> createState() => _CheckPhoneState();
}

class _CheckPhoneState extends State<CheckPhone> {
  int _time = 60;
  Timer? _timer;

  final _otpFormKey = GlobalKey<FormState>();
  final TextEditingController _codeOtpController = TextEditingController();

  void startTimer() {
    _time = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_time == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _time--;
        });
      }
    });
  }

  @override
  initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 24.0,
            ),
            // logo
            MainLogo(iconName: AppIconName.uec69Phone),
            // X
            AppButton.buttonIcon(AppIconName.ueaefXClose,
                bgColor: Colors.transparent,
                bgHoverColor: Colors.transparent,
                textColor: Colors.transparent,
                iconSize: 24,
                context: context, onTap: () {
              Navigator.pop(context);
            })
          ],
        ),
        const SizedBox(height: 16.0),
        // title
        Container(
          padding: const EdgeInsets.only(bottom: 12),
          child: Center(
            child: Text(
              'Check your phone',
              style: Theme.of(context)
                  .appTexts
                  .textLgSemiBold
                  .copyWith(color: Theme.of(context).appColors.textPrimary900),
            ),
          ),
        ),
        // subtitle
        Center(
          child: Text(
            'We sent a verification code to your phone number. Please enter it.',
            style: Theme.of(context)
                .appTexts
                .textSmRegular
                .copyWith(color: Theme.of(context).appColors.textTeritory600),
            textAlign: TextAlign.center,
          ),
        ),
        // Content
        Form(
          key: _otpFormKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CountryCode(
                  labelText: 'Phone number',
                  dropdownPlaceHolder: 'Select country code',
                  dropdownSearchPlaceHolder: 'Search country name',
                  textFieldController: TextEditingController(),
                  enabled: false,
                  defaultSelected: widget.country,
                  defaultTextFieldValue: widget.phoneNumber,
                  selectedCountry: (CountryModel country) {},
                ),
                AppTextField.main(
                    controller: _codeOtpController,
                    keyboardType: TextInputType.number,
                    labelText: 'Verification code',
                    placeHolder: '--- ---',
                    helpText: '',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter verification code';
                      }
                      return null;
                    }),
                Row(
                  children: [
                    Expanded(
                      child: AppButton.buttonPrimary(
                        text: _time == 0
                            ? 'Resend code'
                            : 'Resend code (‘$_time)',
                        context: context,
                        disable: _time == 0 ? false : true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        onTap: () {
                          startTimer();
                          widget.resendCode();
                        },
                      ),
                    ),
                    Expanded(
                      child: AppButton.buttonPrimary(
                        text: 'Verify email',
                        context: context,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        disable: _time == 0 ? true : false,
                        onTap: () {
                          if (_otpFormKey.currentState!.validate()) {
                            widget.verificationCode(_codeOtpController.text);
                            // Process the email, e.g., send it to a server
                            print('Email: ${_codeOtpController.text}');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ), // Stepper
        StepperSignUp(step: StepperNum.step2),
      ],
    );
  }
}
