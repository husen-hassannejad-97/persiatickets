enum LoginRouteNames {
  loginEmail(path: '/login-email'),
  loginEmailOtp(path: '/login-email-otp'),
  loginEmailPassword(path: '/login-email-password'),
  loginPhoneNumber(path: '/login-phone-number'),
  loginPhoneNumberOtp(path: '/login-phone-number-otp'),
  welcome(path: '/welcome'),
  ;

  final String path;
  const LoginRouteNames({required this.path});
}
