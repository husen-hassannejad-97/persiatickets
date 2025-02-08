// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logged_user_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoggedUserInfoDto _$LoggedUserInfoDtoFromJson(Map<String, dynamic> json) =>
    LoggedUserInfoDto(
      sub: json['sub'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      tokenVersion: (json['token_version'] as num).toInt(),
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      profileImg: json['profile_picture_url'] as String?,
      exp: (json['exp'] as num).toInt(),
      jti: json['jti'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$LoggedUserInfoDtoToJson(LoggedUserInfoDto instance) =>
    <String, dynamic>{
      'sub': instance.sub,
      'email': instance.email,
      'username': instance.username,
      'token_version': instance.tokenVersion,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'profile_picture_url': instance.profileImg,
      'exp': instance.exp,
      'jti': instance.jti,
      'type': instance.type,
    };
