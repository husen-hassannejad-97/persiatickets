// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDto _$LoginDtoFromJson(Map<String, dynamic> json) => LoginDto(
      contactInfo: json['contact_info'] as String,
      contactType: json['contact_type'] as String,
      password: json['password'] as String,
      rememberMe: json['remember_me'] as bool,
      device: DeviceInfoDto.fromJson(json['device'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginDtoToJson(LoginDto instance) => <String, dynamic>{
      'contact_info': instance.contactInfo,
      'contact_type': instance.contactType,
      'password': instance.password,
      'remember_me': instance.rememberMe,
      'device': instance.device.toJson(),
    };
