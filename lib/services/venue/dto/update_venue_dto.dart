import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_venue_dto.g.dart';

@JsonSerializable()
class UpdateVenueDto implements BaseDto {
  final String name;
  final String address;
  final String description;
  final int capacity;

  UpdateVenueDto({
    required this.name,
    required this.address,
    required this.description,
    required this.capacity,
  });

  @factoryMethod
  factory UpdateVenueDto.fromJson(Map<String, dynamic> json) => _$UpdateVenueDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateVenueDtoToJson(this);
}