// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_details_music_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDetailsMusicResponseDto _$EventDetailsMusicResponseDtoFromJson(
        Map<String, dynamic> json) =>
    EventDetailsMusicResponseDto(
      name: json['name'] as String,
      fileUrl: json['file_url'] as String?,
    );

Map<String, dynamic> _$EventDetailsMusicResponseDtoToJson(
        EventDetailsMusicResponseDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'file_url': instance.fileUrl,
    };
