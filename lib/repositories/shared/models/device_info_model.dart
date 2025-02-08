import '../../base/base_model.dart';

class DeviceInfoModel implements BaseModel {
  final String deviceName;
  final String fcmToken;
  final String osVersion;
  final String deviceModel;
  final String appVersion;
  final bool isActive;
  final bool notificationsEnabled;

  DeviceInfoModel({
    required this.deviceName,
    required this.fcmToken,
    required this.osVersion,
    required this.deviceModel,
    required this.appVersion,
    required this.isActive,
    required this.notificationsEnabled,
  });
}