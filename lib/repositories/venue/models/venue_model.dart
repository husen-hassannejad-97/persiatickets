import '../../base/base_model.dart';

class VenueModel implements BaseModel {
  final String name;
  final String address;
  final String description;
  final int capacity;
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;

  VenueModel({
    required this.name,
    required this.address,
    required this.description,
    required this.capacity,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });
}