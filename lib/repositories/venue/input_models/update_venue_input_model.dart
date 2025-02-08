import '../../base/base_model.dart';

class UpdateVenueInputModel implements BaseModel {
  final String name;
  final String address;
  final String description;
  final int capacity;

  UpdateVenueInputModel({
    required this.name,
    required this.address,
    required this.description,
    required this.capacity,
  });
}