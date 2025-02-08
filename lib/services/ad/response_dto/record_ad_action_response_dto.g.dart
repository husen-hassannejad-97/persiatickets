// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_ad_action_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordAdActionResponseDto _$RecordAdActionResponseDtoFromJson(
        Map<String, dynamic> json) =>
    RecordAdActionResponseDto(
      id: (json['id'] as num).toInt(),
      adId: (json['ad_id'] as num).toInt(),
      actionType: json['action_type'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$RecordAdActionResponseDtoToJson(
        RecordAdActionResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ad_id': instance.adId,
      'action_type': instance.actionType,
      'timestamp': instance.timestamp.toIso8601String(),
    };
