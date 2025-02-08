// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_apple_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginAppleDto _$LoginAppleDtoFromJson(Map<String, dynamic> json) =>
    LoginAppleDto(
      identityToken: json['identity_token'] as String,
      device: DeviceInfoDto.fromJson(json['device'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginAppleDtoToJson(LoginAppleDto instance) =>
    <String, dynamic>{
      'identity_token': instance.identityToken,
      'device': instance.device.toJson(),
    };
