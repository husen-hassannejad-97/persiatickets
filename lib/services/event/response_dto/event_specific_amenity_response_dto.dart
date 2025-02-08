import 'package:billit_now/services/base/base_dto.dart';
import 'package:billit_now/services/event/response_dto/event_specific_amenity_item_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_specific_amenity_response_dto.g.dart';

@JsonSerializable()
class EventSpecificAmenityResponseDto implements BaseDto {
  final int id;
  @JsonKey(name: 'event_id')
  final int eventId;
  @JsonKey(name: 'specific_amenity_id')
  final int? specificAmenityId;
  final List<EventSpecificAmenityItemResponseDto> items;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  EventSpecificAmenityResponseDto({
    required this.id,
    required this.eventId,
    required this.specificAmenityId,
    required this.items,
    required this.createdAt,
    required this.updatedAt
  });

  @factoryMethod
  factory EventSpecificAmenityResponseDto.fromJson(Map<String, dynamic> json) => _$EventSpecificAmenityResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EventSpecificAmenityResponseDtoToJson(this);
}