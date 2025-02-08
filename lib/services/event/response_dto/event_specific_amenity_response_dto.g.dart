// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_specific_amenity_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventSpecificAmenityResponseDto _$EventSpecificAmenityResponseDtoFromJson(
        Map<String, dynamic> json) =>
    EventSpecificAmenityResponseDto(
      id: (json['id'] as num).toInt(),
      eventId: (json['event_id'] as num).toInt(),
      specificAmenityId: (json['specific_amenity_id'] as num?)?.toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => EventSpecificAmenityItemResponseDto.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$EventSpecificAmenityResponseDtoToJson(
        EventSpecificAmenityResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'specific_amenity_id': instance.specificAmenityId,
      'items': instance.items,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
