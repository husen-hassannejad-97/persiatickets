import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_venue_facility_item_response_dto.g.dart';

@JsonSerializable()
class EventVenueFacilityItemResponseDto implements BaseDto {
  @JsonKey(name: 'icon')
  final String icon;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'description')
  final String description;

  EventVenueFacilityItemResponseDto({
    required this.icon,
    required this.title,
    required this.description,
  });

  @factoryMethod
  factory EventVenueFacilityItemResponseDto.fromJson(Map<String, dynamic> json) => _$EventVenueFacilityItemResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EventVenueFacilityItemResponseDtoToJson(this);
}