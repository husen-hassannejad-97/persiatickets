import 'package:billit_now/repositories/auth/input_models/code_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/complete_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/login_apple_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/login_facebook_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/login_google_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/login_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/password_reset_confirm_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/password_reset_request_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/register_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/send_code_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/verify_code_input_model.dart';
import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/services/auth/dto/complete_dto.dart';
import 'package:billit_now/services/auth/dto/login_apple_dto.dart';
import 'package:billit_now/services/auth/dto/login_dto.dart';
import 'package:billit_now/services/auth/dto/login_facebook_dto.dart';
import 'package:billit_now/services/auth/dto/login_google_dto.dart';
import 'package:billit_now/services/auth/dto/password_reset_confirm_dto.dart';
import 'package:billit_now/services/auth/dto/password_reset_request_dto.dart';
import 'package:billit_now/services/auth/dto/register_dto.dart';
import 'package:billit_now/services/auth/dto/send_code_dto.dart';
import 'package:billit_now/services/auth/dto/verify_code_dto.dart';
import 'package:injectable/injectable.dart';

@singleton
class VerifyCodeDtoMapper extends BaseDtoMapper<VerifyCodeDto, VerifyCodeInputModel> {
  @override
  VerifyCodeInputModel fromDto(VerifyCodeDto dto) {
    // TODO: implement fromDto
    throw UnimplementedError();
  }

  @override
  VerifyCodeDto toDto(VerifyCodeInputModel model) {
    // TODO: implement toDto
    throw UnimplementedError();
  }

}