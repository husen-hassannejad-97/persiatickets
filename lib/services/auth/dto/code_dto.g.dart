// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CodeDto _$CodeDtoFromJson(Map<String, dynamic> json) => CodeDto(
      contactInfo: json['contact_info'] as String,
      contactType: json['contact_type'] as String,
      username: json['username'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      device: DeviceInfoDto.fromJson(json['device'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CodeDtoToJson(CodeDto instance) => <String, dynamic>{
      'contact_info': instance.contactInfo,
      'contact_type': instance.contactType,
      'username': instance.username,
      'phone': instance.phone,
      'email': instance.email,
      'device': instance.device.toJson(),
    };
