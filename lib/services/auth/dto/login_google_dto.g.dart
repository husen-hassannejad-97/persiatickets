// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_google_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginGoogleDto _$LoginGoogleDtoFromJson(Map<String, dynamic> json) =>
    LoginGoogleDto(
      token: json['token'] as String,
      device: DeviceInfoDto.fromJson(json['device'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginGoogleDtoToJson(LoginGoogleDto instance) =>
    <String, dynamic>{
      'token': instance.token,
      'device': instance.device.toJson(),
    };
