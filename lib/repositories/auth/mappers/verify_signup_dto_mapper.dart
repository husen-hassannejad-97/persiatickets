import 'package:billit_now/repositories/auth/input_models/verify_signup_input_model.dart';
import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/services/auth/dto/verify_signup_dto.dart';
import 'package:injectable/injectable.dart';

@singleton
class VerifySignupDtoMapper
    extends BaseDtoMapper<VerifySignupDto, VerifySignupInputModel> {
  @override
  VerifySignupInputModel fromDto(VerifySignupDto dto) {
    // TODO: implement fromDto
    throw UnimplementedError();
  }

  @override
  VerifySignupDto toDto(VerifySignupInputModel model) {
    return VerifySignupDto(
        contactInfo: model.id,
        contactType: model.type.toString().split('.').last,
        code: model.code);
  }
}
