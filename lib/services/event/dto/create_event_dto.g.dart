// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateEventDto _$CreateEventDtoFromJson(Map<String, dynamic> json) =>
    CreateEventDto(
      name: json['name'] as String,
      description: json['description'] as String,
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: DateTime.parse(json['end_time'] as String),
      venueId: (json['venue_id'] as num).toInt(),
      category: json['category'] as String,
      seatMap: json['seat_map'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$CreateEventDtoToJson(CreateEventDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'start_time': instance.startTime.toIso8601String(),
      'end_time': instance.endTime.toIso8601String(),
      'venue_id': instance.venueId,
      'category': instance.category,
      'seat_map': instance.seatMap,
    };
