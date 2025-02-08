// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_guideline_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventGuidelineResponseDto _$EventGuidelineResponseDtoFromJson(
        Map<String, dynamic> json) =>
    EventGuidelineResponseDto(
      id: (json['id'] as num).toInt(),
      eventId: (json['event_id'] as num).toInt(),
      guidelineId: (json['guideline_id'] as num?)?.toInt(),
      customDescription: json['custom_description'] as String?,
      customName: json['custom_name'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$EventGuidelineResponseDtoToJson(
        EventGuidelineResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'guideline_id': instance.guidelineId,
      'custom_name': instance.customName,
      'custom_description': instance.customDescription,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
