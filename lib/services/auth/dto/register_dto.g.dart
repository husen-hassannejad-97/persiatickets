// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterDto _$RegisterDtoFromJson(Map<String, dynamic> json) => RegisterDto(
      contactInfo: json['contact_info'] as String,
      contactType: json['contact_type'] as String,
      password: json['password'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      device: DeviceInfoDto.fromJson(json['device'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterDtoToJson(RegisterDto instance) =>
    <String, dynamic>{
      'contact_info': instance.contactInfo,
      'contact_type': instance.contactType,
      'password': instance.password,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'device': instance.device.toJson(),
    };
