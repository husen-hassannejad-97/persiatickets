enum ResetPasswordRouteNames {
  forgotPasswordStep1(path: '/forgot-password-step-1'),
  forgotPasswordStep2(path: '/forgot-password-step-2'),
  forgotPasswordStep3(path: '/forgot-password-step-3'),
  forgotPasswordStep4(path: '/forgot-password-step-4');

  final String path;
  const ResetPasswordRouteNames({required this.path});
}
