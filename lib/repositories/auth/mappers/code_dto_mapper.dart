import 'package:billit_now/repositories/auth/input_models/code_input_model.dart';
import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/services/auth/dto/code_dto.dart';
import 'package:billit_now/services/shared_dto/device_info_dto.dart';
import 'package:injectable/injectable.dart';

import '../../shared/models/code_type.dart';

@singleton
class CodeDtoMapper extends BaseDtoMapper<CodeDto, CodeInputModel> {
  @override
  CodeInputModel fromDto(CodeDto dto) {
    // TODO: implement fromDto
    throw UnimplementedError();
  }

  @override
  CodeDto toDto(CodeInputModel model) {
    return CodeDto(
        contactInfo: "contactInfo",
        contactType: "contactType",
        email: model.codeType == CodeType.email ? model.input : null,
        phone: model.codeType == CodeType.phone ? model.input : null,
        device: DeviceInfoDto(
            deviceName: "deviceName",
            fcmToken: "fcmToken",
            osVersion: "osVersion",
            deviceModel: "deviceModel",
            appVersion: "appVersion",
            isActive: true,
            notificationsEnabled: true,
        )
    );
  }

}