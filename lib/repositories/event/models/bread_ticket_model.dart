import 'package:billit_now/repositories/base/base_model.dart';
import 'package:billit_now/repositories/event/models/about_organizer_model.dart';

class BreadTicketModel implements BaseModel {
  String title;
  String location;
  DateTime date;
  String role; // TODO Check to see if we could move this inside organizer model
  List<String> sponsors;
  OrganizerModel organizerModel;
  BreadTicketModel({
    required this.title,
    required this.location,
    required this.date,
    required this.role,
    required this.sponsors,
    required this.organizerModel,
  });
}