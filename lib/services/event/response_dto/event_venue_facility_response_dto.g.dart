// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_venue_facility_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventVenueFacilityResponseDto _$EventVenueFacilityResponseDtoFromJson(
        Map<String, dynamic> json) =>
    EventVenueFacilityResponseDto(
      id: (json['id'] as num).toInt(),
      eventId: (json['event_id'] as num).toInt(),
      generalVenueFacilityId:
          (json['general_venue_facility_id'] as num?)?.toInt(),
      description: json['description'] as String,
      name: json['name'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => EventVenueFacilityItemResponseDto.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$EventVenueFacilityResponseDtoToJson(
        EventVenueFacilityResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'general_venue_facility_id': instance.generalVenueFacilityId,
      'description': instance.description,
      'name': instance.name,
      'items': instance.items,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
