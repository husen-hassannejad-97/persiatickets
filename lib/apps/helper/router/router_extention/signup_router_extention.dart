import 'package:billit_now/apps/helper/router/route_names/signup_route_names.dart';
import 'package:billit_now/templates/auth/signup/signup_email.dart';
import 'package:billit_now/templates/auth/signup/signup_email_otp.dart';
import 'package:billit_now/templates/auth/signup/signup_phone_number.dart';
import 'package:billit_now/templates/auth/signup/signup_terms.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../templates/auth/signup/signup_details.dart';
import '../../../../templates/auth/signup/signup_phone_number_otp.dart';

extension SignupRouterExtension on BuildContext {
  void goSignupEmail(SignupEmailPageExtra extra) => go(SignupRouteNames.signupEmail.path, extra: extra);
  void goSignupEmailOtp(SignupEmailOtpPageExtra extra) => go(
      SignupRouteNames.signupEmailOtp.path, extra: extra);

  void goSignupPhoneNumber(SignupPhoneNumberPageExtra extra) => go(
      SignupRouteNames.signupPhoneNumber.path, extra: extra);
  void goSignupPhoneNumberOtp(SignupPhoneNumberOtpPageExtra extra) => go(
      SignupRouteNames.signupPhoneNumberOtp.path, extra: extra);
  void goSignupDetails(SignupDetailsPageExtra extra) => go(
      SignupRouteNames.signupDetails.path, extra: extra);
  void goSignupTerms(SignupTermsPageExtra extra) => go(
      SignupRouteNames.signupTerms.path, extra: extra);
  void goSignupSuccess() => go(SignupRouteNames.signupSuccess.path);
}
