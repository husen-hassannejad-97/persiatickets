import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'getting_there_response_dto.dart';

part 'venue_response_dto.g.dart';

@JsonSerializable()
class VenueResponseDto implements BaseDto {
  final int id;
  final String name;
  final String address;
  final String? description;
  final int capacity;
  final double? latitude;
  final double? longitude;
  final String? overview;
  @JsonKey(name: 'getting_there')
  final List<GettingThereResponseDto>? gettingThere;
  @JsonKey(name: 'nearby_amenities')
  final String? nearbyAmenities;
  @JsonKey(name: 'gallery')
  final List<String>? gallery;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  VenueResponseDto({
    required this.name,
    required this.address,
    required this.description,
    required this.gallery,
    required this.nearbyAmenities,
    required this.gettingThere,
    required this.overview,
    required this.capacity,
    required this.latitude,
    required this.longitude,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  @factoryMethod
  factory VenueResponseDto.fromJson(Map<String, dynamic> json) => _$VenueResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VenueResponseDtoToJson(this);
}