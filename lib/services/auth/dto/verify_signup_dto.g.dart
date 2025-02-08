// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_signup_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifySignupDto _$VerifySignupDtoFromJson(Map<String, dynamic> json) =>
    VerifySignupDto(
      contactInfo: json['contact_info'] as String,
      contactType: json['contact_type'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$VerifySignupDtoToJson(VerifySignupDto instance) =>
    <String, dynamic>{
      'contact_info': instance.contactInfo,
      'contact_type': instance.contactType,
      'code': instance.code,
    };
