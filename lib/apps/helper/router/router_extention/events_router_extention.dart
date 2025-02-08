import 'package:billit_now/apps/event_data.dart';
import 'package:billit_now/apps/helper/router/route_names/events_route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension LandingRouterExtention on BuildContext {
  void goEventPage() =>
      go(EventsRouteNames.eventPage.path);
  void goEventMapPage() => go(EventsRouteNames.eventMapPage.path);
  void goEventCheckout() => go(EventsRouteNames.eventCheckout.path);
  void goEventTicket() => go(EventsRouteNames.eventTicket.path);
}
