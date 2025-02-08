import '../../base/base_model.dart';

class UpdateEventInputModel implements BaseModel {
  final String name;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String category;
  final Map<String, dynamic> seatMap;

  UpdateEventInputModel({
    required this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.category,
    required this.seatMap,
  });
}