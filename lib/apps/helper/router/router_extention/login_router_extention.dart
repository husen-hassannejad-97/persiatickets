import 'package:billit_now/apps/helper/router/route_names/login_route_names.dart';
import 'package:billit_now/apps/helper/router/route_names/reset_password_route_names.dart';
import 'package:billit_now/templates/auth/login/login_phone_otp.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../templates/auth/login/login_email_otp.dart';

extension LoginRouterExtension on BuildContext {
  void goLoginEmail() => go(LoginRouteNames.loginEmail.path);
  void goLoginEmailOtp(LoginEmailOtpPageExtra extra) => go(
      LoginRouteNames.loginEmailOtp.path, extra: extra);
  void goLoginEmailPassword() => go(
      LoginRouteNames.loginEmailPassword.path);
  void goLoginPhoneNumber() => go(LoginRouteNames.loginPhoneNumber.path);
  void goLoginPhoneNumberOtp(LoginPhoneOtpPageExtra extra) => go(
      LoginRouteNames.loginPhoneNumberOtp.path, extra: extra);

  // reset passwords
  void goForgotPasswordStep1() =>
      go(ResetPasswordRouteNames.forgotPasswordStep1.path);
  void goForgotPasswordStep2() =>
      go(ResetPasswordRouteNames.forgotPasswordStep2.path);
  void goForgotPasswordStep3() =>
      go(ResetPasswordRouteNames.forgotPasswordStep3.path);
  void goForgotPasswordStep4() =>
      go(ResetPasswordRouteNames.forgotPasswordStep4.path);

  void goLoginWelcome() =>
      go(LoginRouteNames.welcome.path);
}
