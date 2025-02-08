// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateEventDto _$UpdateEventDtoFromJson(Map<String, dynamic> json) =>
    UpdateEventDto(
      name: json['name'] as String,
      description: json['description'] as String,
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: DateTime.parse(json['end_time'] as String),
      category: json['category'] as String,
      seatMap: json['seat_map'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$UpdateEventDtoToJson(UpdateEventDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'start_time': instance.startTime.toIso8601String(),
      'end_time': instance.endTime.toIso8601String(),
      'category': instance.category,
      'seat_map': instance.seatMap,
    };
