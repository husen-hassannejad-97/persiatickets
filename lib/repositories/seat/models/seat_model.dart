import '../../base/base_model.dart';

class SeatModel implements BaseModel {
  final int venueId;
  final String seatNumber;
  final String rowNumber;
  final String seatType;
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;

  SeatModel({
    required this.venueId,
    required this.seatNumber,
    required this.rowNumber,
    required this.seatType,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });
}