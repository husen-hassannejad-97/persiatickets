import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_venue_dto.g.dart';

@JsonSerializable()
class CreateVenueDto implements BaseDto {
  final String name;
  final String address;
  final String description;
  final int capacity;

  CreateVenueDto({
    required this.name,
    required this.address,
    required this.description,
    required this.capacity,
  });

  @factoryMethod
  factory CreateVenueDto.fromJson(Map<String, dynamic> json) => _$CreateVenueDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateVenueDtoToJson(this);
}