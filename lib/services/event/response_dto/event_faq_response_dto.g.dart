// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_faq_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventFaqResponseDto _$EventFaqResponseDtoFromJson(Map<String, dynamic> json) =>
    EventFaqResponseDto(
      id: (json['id'] as num).toInt(),
      eventId: (json['event_id'] as num).toInt(),
      faqId: (json['faq_id'] as num?)?.toInt(),
      customQuestion: json['custom_question'] as String?,
      customAnswer: json['custom_answer'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$EventFaqResponseDtoToJson(
        EventFaqResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'faq_id': instance.faqId,
      'custom_question': instance.customQuestion,
      'custom_answer': instance.customAnswer,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
