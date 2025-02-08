// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_wrapper_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenWrapperResponseDto _$TokenWrapperResponseDtoFromJson(
        Map<String, dynamic> json) =>
    TokenWrapperResponseDto(
      message: json['message'] as String,
      token: json['token'] == null
          ? null
          : TokenResponseDto.fromJson(json['token'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TokenWrapperResponseDtoToJson(
        TokenWrapperResponseDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'token': instance.token?.toJson(),
    };
