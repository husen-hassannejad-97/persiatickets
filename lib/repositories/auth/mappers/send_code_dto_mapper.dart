import 'package:billit_now/repositories/auth/input_models/send_code_input_model.dart';
import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/repositories/shared/mappers/device_info_dto_mapper.dart';
import 'package:billit_now/services/auth/dto/send_code_dto.dart';
import 'package:injectable/injectable.dart';

import '../../shared/models/code_type.dart';

@singleton
class SendCodeDtoMapper extends BaseDtoMapper<SendCodeDto, SendCodeInputModel> {
  DeviceInfoDtoMapper deviceInfoDtoMapper;
  SendCodeDtoMapper({
    required this.deviceInfoDtoMapper,
  });
  @override
  SendCodeInputModel fromDto(SendCodeDto dto) {
    // TODO: implement fromDto
    throw UnimplementedError();
  }

  @override
  SendCodeDto toDto(SendCodeInputModel model) {
    return SendCodeDto(
      email: model.codeType == CodeType.email ? model.input : null,
      phoneNumber: model.codeType == CodeType.phone ? model.input : null,
      deviceInfo: deviceInfoDtoMapper.toDto(model.deviceInfoModel),
    );
  }
}
