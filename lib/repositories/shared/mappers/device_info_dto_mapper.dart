import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/repositories/shared/models/device_info_model.dart';
import 'package:billit_now/services/shared_dto/device_info_dto.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeviceInfoDtoMapper extends BaseDtoMapper<DeviceInfoDto, DeviceInfoModel> {
  @override
  DeviceInfoModel fromDto(DeviceInfoDto dto) {
    return DeviceInfoModel(deviceName: dto.deviceName, fcmToken: dto.fcmToken, osVersion: dto.osVersion, deviceModel: dto.deviceModel, appVersion: dto.appVersion, isActive: dto.isActive, notificationsEnabled: dto.notificationsEnabled ?? false);
  }

  @override
  DeviceInfoDto toDto(DeviceInfoModel model) {
    return DeviceInfoDto(deviceName: model.deviceName, fcmToken: model.fcmToken, osVersion: model.osVersion, deviceModel: model.deviceModel, appVersion: model.appVersion, isActive: model.isActive, notificationsEnabled: model.notificationsEnabled);
  }

}