// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_code_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyCodeDto _$VerifyCodeDtoFromJson(Map<String, dynamic> json) =>
    VerifyCodeDto(
      contactInfo: json['contact_info'] as String,
      contactType: json['contact_type'] as String,
      username: json['username'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      device: DeviceInfoDto.fromJson(json['device'] as Map<String, dynamic>),
      code: json['code'] as String,
    );

Map<String, dynamic> _$VerifyCodeDtoToJson(VerifyCodeDto instance) =>
    <String, dynamic>{
      'contact_info': instance.contactInfo,
      'contact_type': instance.contactType,
      'username': instance.username,
      'phone': instance.phone,
      'email': instance.email,
      'device': instance.device.toJson(),
      'code': instance.code,
    };
