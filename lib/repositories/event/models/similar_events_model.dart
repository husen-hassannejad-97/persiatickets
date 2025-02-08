import 'package:billit_now/apps/helper/event_status.dart';
import 'package:billit_now/repositories/base/base_model.dart';

class SimilarEventsModel implements BaseModel {
  final String image;
  final EventStatus status;
  final String title;
  final String date;
  final String location;
  final String price;

  SimilarEventsModel(
      {required this.image,
      required this.status,
      required this.title,
      required this.date,
      required this.location,
      required this.price});
}
