import 'package:billit_now/services/base/base_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_info_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class DeviceInfoDto implements BaseDto {
  @JsonKey(name: 'device_name')
  final String deviceName;

  @JsonKey(name: 'fcm_token')
  final String fcmToken;

  @JsonKey(name: 'os_version')
  final String osVersion;

  @JsonKey(name: 'device_model')
  final String deviceModel;

  @JsonKey(name: 'app_version')
  final String appVersion;

  @JsonKey(name: 'is_active')
  final bool isActive;

  @JsonKey(name: 'notifications_enabled')
  final bool? notificationsEnabled;

  DeviceInfoDto({
    required this.deviceName,
    required this.fcmToken,
    required this.osVersion,
    required this.deviceModel,
    required this.appVersion,
    required this.isActive,
    required this.notificationsEnabled,
  });

  // Generated methods
  factory DeviceInfoDto.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceInfoDtoToJson(this);
}