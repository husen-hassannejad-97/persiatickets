import 'package:billit_now/repositories/event/models/about_organizer_model.dart';

import '../../base/base_model.dart';

class EventHeroModel implements BaseModel {
  final Function() reserveTickets;
  final OrganizerModel organizerModel;
  final String role;
  final List<String> sponsors;

  EventHeroModel(
      {required this.reserveTickets,
        required this.organizerModel,
        required this.role,
      required this.sponsors});
}
