import 'package:billit_now/repositories/auth/input_models/code_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/complete_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/login_apple_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/login_facebook_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/login_google_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/login_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/password_reset_confirm_input_model.dart';
import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/services/auth/dto/complete_dto.dart';
import 'package:billit_now/services/auth/dto/login_apple_dto.dart';
import 'package:billit_now/services/auth/dto/login_dto.dart';
import 'package:billit_now/services/auth/dto/login_facebook_dto.dart';
import 'package:billit_now/services/auth/dto/login_google_dto.dart';
import 'package:billit_now/services/auth/dto/password_reset_confirm_dto.dart';
import 'package:injectable/injectable.dart';

@singleton
class PasswordResetConfirmDtoMapper extends BaseDtoMapper<PasswordResetConfirmDto, PasswordResetConfirmInputModel> {
  @override
  PasswordResetConfirmInputModel fromDto(PasswordResetConfirmDto dto) {
    // TODO: implement fromDto
    throw UnimplementedError();
  }

  @override
  PasswordResetConfirmDto toDto(PasswordResetConfirmInputModel model) {
    // TODO: implement toDto
    throw UnimplementedError();
  }

}