// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getting_there_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GettingThereResponseDto _$GettingThereResponseDtoFromJson(
        Map<String, dynamic> json) =>
    GettingThereResponseDto(
      title: json['title'] as String,
      routes:
          (json['routes'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GettingThereResponseDtoToJson(
        GettingThereResponseDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'routes': instance.routes,
    };
