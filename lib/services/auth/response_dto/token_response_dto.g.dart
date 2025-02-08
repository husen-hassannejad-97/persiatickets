// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenResponseDto _$TokenResponseDtoFromJson(Map<String, dynamic> json) =>
    TokenResponseDto(
      tokenType: json['token_type'] as String,
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String?,
      deviceId: json['deviceId'] as String?,
    );

Map<String, dynamic> _$TokenResponseDtoToJson(TokenResponseDto instance) =>
    <String, dynamic>{
      'token_type': instance.tokenType,
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'deviceId': instance.deviceId,
    };
