// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompleteDto _$CompleteDtoFromJson(Map<String, dynamic> json) => CompleteDto(
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String,
      password: json['password'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
    );

Map<String, dynamic> _$CompleteDtoToJson(CompleteDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'password': instance.password,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
    };
