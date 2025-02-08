import 'package:billit_now/apps/event_data.dart';
import 'package:billit_now/apps/helper/router/route_names/events_route_names.dart';
import 'package:billit_now/apps/helper/router/route_names/landing_route_name.dart';
import 'package:billit_now/apps/helper/router/route_names/login_route_names.dart';
import 'package:billit_now/apps/helper/router/route_names/reset_password_route_names.dart';
import 'package:billit_now/apps/helper/router/route_names/signup_route_names.dart';
import 'package:billit_now/repositories/event/models/checkout_model.dart';
import 'package:billit_now/repositories/event/models/why_persia_tickets_model.dart';
import 'package:billit_now/repositories/event_map/models/map_model.dart';
import 'package:billit_now/templates/auth/login/login_email_otp.dart';
import 'package:billit_now/templates/auth/login/login_email_password.dart';
import 'package:billit_now/templates/auth/login/login_phone.dart';
import 'package:billit_now/templates/auth/login/login_phone_otp.dart';
import 'package:billit_now/templates/auth/login/login_welcome.dart';
import 'package:billit_now/templates/auth/reset_password/forgot_password_step_1.dart';
import 'package:billit_now/templates/auth/reset_password/forgot_password_step_2.dart';
import 'package:billit_now/templates/auth/reset_password/forgot_password_step_3.dart';
import 'package:billit_now/templates/auth/reset_password/forgot_password_step_4.dart';
import 'package:billit_now/templates/auth/signup/signup_details.dart';
import 'package:billit_now/templates/auth/signup/signup_email.dart';
import 'package:billit_now/templates/auth/signup/signup_email_otp.dart';
import 'package:billit_now/templates/auth/signup/signup_phone_number.dart';
import 'package:billit_now/templates/auth/signup/signup_phone_number_otp.dart';
import 'package:billit_now/templates/auth/signup/signup_success.dart';
import 'package:billit_now/templates/auth/signup/signup_terms.dart';
import 'package:billit_now/templates/events/checkout/checkout.dart';
import 'package:billit_now/templates/events/event_page/event_details_page.dart';
import 'package:billit_now/templates/events/map_list/map_list.dart';
import 'package:billit_now/templates/events/ticket/ticket.dart';
import 'package:flutter/foundation.dart';
import 'package:billit_now/templates/landing/landing.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../../templates/auth/login/login_email.dart';

@module
abstract class AppRouter {
  @singleton
  GoRouter get router => GoRouter(
        debugLogDiagnostics: kDebugMode,
        initialLocation: LandingRouteName.landing.path,
        routes: [..._loginRoutes],
        errorBuilder: (context, state) => LandingPage(),
      );
}

List<GoRoute> _loginRoutes = [
  // Welcome
  GoRoute(
      path: LoginRouteNames.welcome.path,
      builder: (context, state) => LoginWelcome()),
  // Landing
  GoRoute(
      path: LandingRouteName.landing.path,
      builder: (context, state) => LandingPage()),
  // Event Details
  GoRoute(
      path: EventsRouteNames.eventPage.path,
      builder: (context, state) {
        return EventDetailsPage();
      }),
  // Map
  GoRoute(
    path: EventsRouteNames.eventMapPage.path,
    builder: (context, state) {
      return MapListPage();
    },
  ),
  // checkout
  GoRoute(
    path: EventsRouteNames.eventCheckout.path,
    builder: (context, state) {
      return Checkout(
        currency: '\$',
        data: CheckoutModel(
            durationMinutes: 20,
            venueTitle: 'EBI live in Vienna',
            venueDate: DateTime(2025, 5, 25),
            venueTime: '19:00',
            venueLocation: 'Wiener Stadthalle, Hall F, Vienna, Austria',
            seats: [
              MapSeatModel(
                  image: 'assets/images/sections.png',
                  dealScore: 10,
                  price: 90,
                  row: 26,
                  seatNumber: 92,
                  sectionName: 'Back Left 1',
                  seatX: 96.2,
                  seatY: 1477,
                  seatR: 12,
                  seatId: '2005009013'),
              MapSeatModel(
                  image: 'assets/images/sections.png',
                  dealScore: 8,
                  price: 90,
                  row: 26,
                  seatNumber: 91,
                  sectionName: 'Back Left 1',
                  seatX: 123,
                  seatY: 1482.7,
                  seatR: 12,
                  seatId: '2005009012'),
            ],
            fee: 0.16,
            whyPersiaTickets: [
              WhyPersiaTicketsModel(
                  icon: 'assets/images/uebe8-phone-01.png',
                  title: 'Effortless Ticketing Experience',
                  desc:
                      'Receive your e-ticket instantly—Apple Wallet-ready or printable.'),
              WhyPersiaTicketsModel(
                  icon: 'assets/images/ueb60-bell-01.png',
                  title: 'Timely Change Notifications',
                  desc:
                      'Get instant alerts for concert changes. Cancel or switch events if plans no longer suit you.'),
              WhyPersiaTicketsModel(
                  icon: 'assets/images/uecbb-pencil-02.png',
                  title: 'Booking Adjustments',
                  desc:
                      'Modify your reservation—seat, date, or quantity—within the allowed change period.'),
              WhyPersiaTicketsModel(
                  icon: 'assets/images/hours-24.png',
                  title: 'Unmatched Support',
                  desc: '24/7 premium support for prompt issue resolution.'),
            ]),
      );
    },
  ),
  // ticket
  GoRoute(
    path: EventsRouteNames.eventTicket.path,
    builder: (context, state) => TicketPage(),
  ),
  // Login
  GoRoute(
    path: LoginRouteNames.loginEmail.path,
    builder: (context, state) => LoginEmailPage(),
  ),
  GoRoute(
    path: LoginRouteNames.loginEmailOtp.path,
    builder: (context, state) {
      // if(state.extra == null) {
      //   return LoginEmailOtpPage(argument: null);
      // }
      return LoginEmailOtpPage();
    },
  ),
  GoRoute(
    path: LoginRouteNames.loginEmailPassword.path,
    builder: (context, state) => LoginEmailPasswordPage(),
  ),
  GoRoute(
      path: LoginRouteNames.loginPhoneNumber.path,
      builder: (context, state) => LoginPhonePage()),
  GoRoute(
    path: LoginRouteNames.loginPhoneNumberOtp.path,
    builder: (context, state) {
      // if(state.extra == null) {
      //   return LoginPhoneOtpPage(argument: null);
      // } else {
      //   return LoginPhoneOtpPage(
      //     argument: state.extra as LoginPhoneOtpPageExtra,
      //   );
      // }
      return LoginPhoneOtpPage();
    },
  ),
  // Forgot Password
  GoRoute(
    path: ResetPasswordRouteNames.forgotPasswordStep1.path,
    builder: (context, state) => ForgotPasswordStep1Page(),
  ),
  GoRoute(
    path: ResetPasswordRouteNames.forgotPasswordStep2.path,
    builder: (context, state) => ForgotPasswordStep2Page(),
  ),
  GoRoute(
    path: ResetPasswordRouteNames.forgotPasswordStep3.path,
    builder: (context, state) => ForgotPasswordStep3Page(),
  ),
  GoRoute(
    path: ResetPasswordRouteNames.forgotPasswordStep4.path,
    builder: (context, state) => ForgotPasswordStep4Page(),
  ),
  // Signup
  GoRoute(
    path: SignupRouteNames.signupEmail.path,
    builder: (context, state) {
      // if(state.extra == null) {
      //   return SignupEmailPage(argument: null);
      // } else {
      //   return SignupEmailPage(argument: state.extra as SignupEmailPageExtra);
      // }
      return SignupEmailPage();
    },
  ),
  GoRoute(
    path: SignupRouteNames.signupEmailOtp.path,
    builder: (context, state) {
      // if(state.extra == null) {
      //   return SignupEmailOtpPage(argument: null);
      // } else {
      //   return SignupEmailOtpPage(argument: state.extra as SignupEmailOtpPageExtra);
      // }
      return SignupEmailOtpPage();
    },
  ),
  GoRoute(
    path: SignupRouteNames.signupPhoneNumber.path,
    builder: (context, state) {
      // if(state.extra == null) {
      //   return SignupPhoneNumberPage(argument: null);
      // } else {
      //   return SignupPhoneNumberPage(argument: state.extra as SignupPhoneNumberPageExtra);
      // }
      return SignupPhoneNumberPage();
    },
  ),
  GoRoute(
    path: SignupRouteNames.signupPhoneNumberOtp.path,
    builder: (context, state) {
      // if(state.extra == null) {
      //   return SignupPhoneNumberOtpPage(argument: null);
      // } else {
      //   return SignupPhoneNumberOtpPage(
      //     argument: state.extra as SignupPhoneNumberOtpPageExtra,
      //   );
      // }
      return SignupPhoneNumberOtpPage();
    },
  ),
  GoRoute(
    path: SignupRouteNames.signupDetails.path,
    builder: (context, state) {
      // if(state.extra == null) {
      //   return SignupDetailsPage(argument: null);
      // } else {
      //   return SignupDetailsPage(argument: state.extra as SignupDetailsPageExtra);
      // }
      return SignupDetailsPage();
    },
  ),
  GoRoute(
    path: SignupRouteNames.signupTerms.path,
    builder: (context, state) {
      // if(state.extra == null) {
      //   return SignupTermsPage(argument: null);
      // } else {
      //   return SignupTermsPage(argument: state.extra as SignupTermsPageExtra);
      // }
      return SignupTermsPage();
    },
  ),
  GoRoute(
    path: SignupRouteNames.signupSuccess.path,
    builder: (context, state) => SignupSuccess(),
  ),
];
