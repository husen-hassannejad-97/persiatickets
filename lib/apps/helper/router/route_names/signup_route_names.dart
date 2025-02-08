enum SignupRouteNames {
  signupEmail(path: '/signup-email'),
  signupEmailOtp(path: '/signup-email-otp'),
  signupPhoneNumber(path: '/signup-phone-number'),
  signupPhoneNumberOtp(path: '/signup-phone-number-otp'),
  signupDetails(path: '/signup-details'),
  signupTerms(path: '/signup-terms'),
  signupSuccess(path: '/signup-success'),
  ;

  final String path;
  const SignupRouteNames({required this.path});
}
