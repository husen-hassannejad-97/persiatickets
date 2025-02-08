import '../../base/base_model.dart';

class UpdateSeatInputModel implements BaseModel {
  final String seatNumber;
  final String rowNumber;
  final String seatType;

  UpdateSeatInputModel({
    required this.seatNumber,
    required this.rowNumber,
    required this.seatType,
  });
}