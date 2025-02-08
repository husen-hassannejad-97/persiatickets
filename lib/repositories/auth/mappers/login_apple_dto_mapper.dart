import 'package:billit_now/repositories/auth/input_models/code_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/complete_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/login_apple_input_model.dart';
import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/services/auth/dto/complete_dto.dart';
import 'package:billit_now/services/auth/dto/login_apple_dto.dart';
import 'package:injectable/injectable.dart';

@singleton
class LoginAppleDtoMapper extends BaseDtoMapper<LoginAppleDto, LoginAppleInputModel> {
  @override
  LoginAppleInputModel fromDto(LoginAppleDto dto) {
    // TODO: implement fromDto
    throw UnimplementedError();
  }

  @override
  LoginAppleDto toDto(LoginAppleInputModel model) {
    // TODO: implement toDto
    throw UnimplementedError();
  }

}