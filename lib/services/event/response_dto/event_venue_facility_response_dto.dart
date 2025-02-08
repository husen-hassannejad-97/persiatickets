import 'package:billit_now/services/base/base_dto.dart';
import 'package:billit_now/services/event/response_dto/event_venue_facility_item_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_venue_facility_response_dto.g.dart';

@JsonSerializable()
class EventVenueFacilityResponseDto implements BaseDto {
  final int id;
  @JsonKey(name: 'event_id')
  final int eventId;
  @JsonKey(name: 'general_venue_facility_id')
  final int? generalVenueFacilityId;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'name')
  final String name;
  final List<EventVenueFacilityItemResponseDto> items;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  EventVenueFacilityResponseDto({
    required this.id,
    required this.eventId,
    required this.generalVenueFacilityId,
    required this.description,
    required this.name,
    required this.items,
    required this.createdAt,
    required this.updatedAt
  });

  @factoryMethod
  factory EventVenueFacilityResponseDto.fromJson(Map<String, dynamic> json) => _$EventVenueFacilityResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EventVenueFacilityResponseDtoToJson(this);
}