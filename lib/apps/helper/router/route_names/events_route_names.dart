enum EventsRouteNames {
  eventPage(path: '/event-page'),
  eventMapPage(path: '/event-map-page'),
  eventCheckout(path: '/event-checkout'),
  eventTicket(path: '/event-ticket'),
  ;

  final String path;
  const EventsRouteNames({required this.path});
}
