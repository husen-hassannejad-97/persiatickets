// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_comment_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateCommentResponseDto _$RateCommentResponseDtoFromJson(
        Map<String, dynamic> json) =>
    RateCommentResponseDto(
      id: (json['id'] as num).toInt(),
      eventId: (json['event_id'] as num).toInt(),
      rating: (json['rating'] as num?)?.toDouble(),
      comment: json['comment'] as String?,
      isApproved: json['is_approved'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$RateCommentResponseDtoToJson(
        RateCommentResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'rating': instance.rating,
      'comment': instance.comment,
      'is_approved': instance.isApproved,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
