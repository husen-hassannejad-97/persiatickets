import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/country_model.dart';
import 'package:billit_now/component/signup_modal/check_mail.dart';
import 'package:billit_now/component/signup_modal/check_phone.dart';
import 'package:billit_now/component/signup_modal/terms.dart';
import 'package:flutter/material.dart';

class SignUpModal extends StatefulWidget {
  const SignUpModal(
      {super.key,
      required this.email,
      required this.country,
      required this.phoneNumber,
      required this.verificationCodeMail,
      required this.resendCodeMail,
      required this.verificationCodePhone,
      required this.resendCodePhone,
      required this.onAgreeTerms});

  final String email;
  final CountryModel? country;
  final String phoneNumber;
  final Function(String code) verificationCodeMail;
  final Function() resendCodeMail;
  final Function(String code) verificationCodePhone;
  final Function() resendCodePhone;
  final Function() onAgreeTerms;

  @override
  State<SignUpModal> createState() => _SignUpModalState();
}

class _SignUpModalState extends State<SignUpModal> {
  bool isVerifiedMail = false;
  bool isVerifiedPhone = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Theme.of(context).appColors.bgPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
          padding: EdgeInsets.all(12.0),
          height: 530.0,
          width: 400.0,
          child: !isVerifiedMail
              ? CheckMail(
                  email: widget.email,
                  verificationCode: (String code) {
                    widget.verificationCodeMail(code);
                    setState(() {
                      isVerifiedMail = true;
                    });
                  },
                  resendCode: widget.resendCodeMail,
                )
              : !isVerifiedPhone
                  ? CheckPhone(
                      verificationCode: (String code) {
                        widget.verificationCodePhone(code);
                        setState(() {
                          isVerifiedPhone = true;
                        });
                      },
                      resendCode: widget.resendCodePhone,
                      phoneNumber: widget.phoneNumber,
                      country: widget.country,
                    )
                  : Terms(onAgreeTerms: widget.onAgreeTerms)),
    );
  }
}
