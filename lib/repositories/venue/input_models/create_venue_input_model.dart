import '../../base/base_model.dart';

class CreateVenueInputModel implements BaseModel {
  final String name;
  final String address;
  final String description;
  final int capacity;

  CreateVenueInputModel({
    required this.name,
    required this.address,
    required this.description,
    required this.capacity,
  });
}