import 'package:billit_now/repositories/venue/models/venue_model.dart';

import '../../../apps/helper/event_status.dart';
import '../../base/base_model.dart';
import 'event_category_model.dart';

class EventModel implements BaseModel {
  final String name;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final int venueId;
  final EventCategoryModel category;
  final Map<String, dynamic> seatMap;
  final String imageKey;
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double startingPrice;
  final VenueModel venue;
  final EventStatus status;

  EventModel({
    required this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.venueId,
    required this.category,
    required this.seatMap,
    required this.imageKey,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.venue,
    required this.startingPrice,
    required this.status,
  });
}