import 'package:billit_now/apps/helper/router/route_names/landing_route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension LandingRouterExtention on BuildContext {
  void goLanding() => go(LandingRouteName.landing.path);
}
