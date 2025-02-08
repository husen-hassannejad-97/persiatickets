import '../../base/base_model.dart';

class CreateSeatInputModel implements BaseModel {
  final int venueId;
  final String seatNumber;
  final String rowNumber;
  final String seatType;

  CreateSeatInputModel({
    required this.venueId,
    required this.seatNumber,
    required this.rowNumber,
    required this.seatType,
  });
}