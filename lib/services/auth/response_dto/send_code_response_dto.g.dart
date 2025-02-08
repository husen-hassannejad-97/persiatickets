// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_code_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendCodeResponseDto _$SendCodeResponseDtoFromJson(Map<String, dynamic> json) =>
    SendCodeResponseDto(
      message: json['message'] as String,
      type: $enumDecode(_$AuthTypeEnumResponseDtoEnumMap, json['type']),
    );

Map<String, dynamic> _$SendCodeResponseDtoToJson(
        SendCodeResponseDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'type': _$AuthTypeEnumResponseDtoEnumMap[instance.type]!,
    };

const _$AuthTypeEnumResponseDtoEnumMap = {
  AuthTypeEnumResponseDto.login: 'login',
  AuthTypeEnumResponseDto.signup: 'signup',
};
