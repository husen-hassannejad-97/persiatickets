import 'package:billit_now/repositories/auth/input_models/login_input_model.dart';
import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/services/auth/dto/login_dto.dart';
import 'package:injectable/injectable.dart';

import '../../shared/mappers/device_info_dto_mapper.dart';
import '../../shared/models/code_type.dart';

@singleton
class LoginDtoMapper extends BaseDtoMapper<LoginDto, LoginInputModel> {

  final DeviceInfoDtoMapper deviceInfoDtoMapper;
  LoginDtoMapper({required this.deviceInfoDtoMapper});

  @override
  LoginInputModel fromDto(LoginDto dto) {
    // TODO: implement fromDto
    throw UnimplementedError();
  }

  @override
  LoginDto toDto(LoginInputModel model) {
    return LoginDto(
        contactInfo: model.email,
        contactType: model.codeType.toString().split('.').last,
        password: model.password,
        rememberMe: false,
        device: deviceInfoDtoMapper.toDto(model.deviceInfoModel)
    );
  }

}