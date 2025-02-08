// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_code_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendCodeDto _$SendCodeDtoFromJson(Map<String, dynamic> json) => SendCodeDto(
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      deviceInfo:
          DeviceInfoDto.fromJson(json['deviceInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SendCodeDtoToJson(SendCodeDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'deviceInfo': instance.deviceInfo.toJson(),
    };
