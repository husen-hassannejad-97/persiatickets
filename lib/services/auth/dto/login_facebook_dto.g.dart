// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_facebook_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginFacebookDto _$LoginFacebookDtoFromJson(Map<String, dynamic> json) =>
    LoginFacebookDto(
      token: json['token'] as String,
      device: DeviceInfoDto.fromJson(json['device'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginFacebookDtoToJson(LoginFacebookDto instance) =>
    <String, dynamic>{
      'token': instance.token,
      'device': instance.device.toJson(),
    };
