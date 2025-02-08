// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordResetRequestDto _$PasswordResetRequestDtoFromJson(
        Map<String, dynamic> json) =>
    PasswordResetRequestDto(
      contactInfo: json['contact_info'] as String,
      contactType: json['contact_type'] as String,
    );

Map<String, dynamic> _$PasswordResetRequestDtoToJson(
        PasswordResetRequestDto instance) =>
    <String, dynamic>{
      'contact_info': instance.contactInfo,
      'contact_type': instance.contactType,
    };
