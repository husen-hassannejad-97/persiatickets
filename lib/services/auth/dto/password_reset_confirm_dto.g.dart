// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset_confirm_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordResetConfirmDto _$PasswordResetConfirmDtoFromJson(
        Map<String, dynamic> json) =>
    PasswordResetConfirmDto(
      token: json['token'] as String,
      newPassword: json['new_password'] as String,
    );

Map<String, dynamic> _$PasswordResetConfirmDtoToJson(
        PasswordResetConfirmDto instance) =>
    <String, dynamic>{
      'token': instance.token,
      'new_password': instance.newPassword,
    };
