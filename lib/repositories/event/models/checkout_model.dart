import 'package:billit_now/repositories/event/models/why_persia_tickets_model.dart';
import 'package:billit_now/repositories/event_map/models/map_model.dart';

import '../../base/base_model.dart';

class CheckoutModel implements BaseModel {
  final int durationMinutes;
  final String venueTitle;
  final DateTime venueDate;
  final String venueTime;
  final String venueLocation;
  final List<MapSeatModel> seats;
  final double fee;
  final List<WhyPersiaTicketsModel> whyPersiaTickets;

  CheckoutModel(
      {required this.durationMinutes,
      required this.venueTitle,
      required this.venueDate,
      required this.venueTime,
      required this.venueLocation,
      required this.seats,
      required this.fee,
      required this.whyPersiaTickets});
}
