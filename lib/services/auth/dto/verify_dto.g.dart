// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyDto _$VerifyDtoFromJson(Map<String, dynamic> json) => VerifyDto(
      contactInfo: json['contact_info'] as String,
      contactType: json['contact_type'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$VerifyDtoToJson(VerifyDto instance) => <String, dynamic>{
      'contact_info': instance.contactInfo,
      'contact_type': instance.contactType,
      'code': instance.code,
    };
