import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_specific_amenity_item_response_dto.g.dart';

@JsonSerializable()
class EventSpecificAmenityItemResponseDto implements BaseDto {
  @JsonKey(name: 'icon')
  final String icon;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'description')
  final String description;

  EventSpecificAmenityItemResponseDto({
    required this.icon,
    required this.title,
    required this.description,
  });

  @factoryMethod
  factory EventSpecificAmenityItemResponseDto.fromJson(Map<String, dynamic> json) => _$EventSpecificAmenityItemResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EventSpecificAmenityItemResponseDtoToJson(this);
}