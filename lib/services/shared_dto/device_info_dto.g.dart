// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceInfoDto _$DeviceInfoDtoFromJson(Map<String, dynamic> json) =>
    DeviceInfoDto(
      deviceName: json['device_name'] as String,
      fcmToken: json['fcm_token'] as String,
      osVersion: json['os_version'] as String,
      deviceModel: json['device_model'] as String,
      appVersion: json['app_version'] as String,
      isActive: json['is_active'] as bool,
      notificationsEnabled: json['notifications_enabled'] as bool?,
    );

Map<String, dynamic> _$DeviceInfoDtoToJson(DeviceInfoDto instance) =>
    <String, dynamic>{
      'device_name': instance.deviceName,
      'fcm_token': instance.fcmToken,
      'os_version': instance.osVersion,
      'device_model': instance.deviceModel,
      'app_version': instance.appVersion,
      'is_active': instance.isActive,
      'notifications_enabled': instance.notificationsEnabled,
    };
