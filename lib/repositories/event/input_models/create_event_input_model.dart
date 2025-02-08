import '../../base/base_model.dart';

class CreateEventInputModel implements BaseModel {
  final String name;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final int venueId;
  final String category;
  final Map<String, dynamic> seatMap;

  CreateEventInputModel({
    required this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.venueId,
    required this.category,
    required this.seatMap,
  });
}