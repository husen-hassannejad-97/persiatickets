import 'package:billit_now/repositories/auth/models/logged_user_info_model.dart';
import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/services/auth/dto/logged_user_info_dto.dart';
import 'package:injectable/injectable.dart';

@singleton
class LoggedUserInfoDtoMapper
    extends BaseDtoMapper<LoggedUserInfoDto, LoggedUserInfoModel> {
  @override
  LoggedUserInfoModel fromDto(LoggedUserInfoDto model) {
    return LoggedUserInfoModel(
        sub: model.sub,
        email: model.email,
        username: model.username,
        tokenVersion: model.tokenVersion,
        firstName: model.firstName,
        lastName: model.lastName,
        profileImg: model.profileImg,
        exp: model.exp,
        jti: model.jti,
        type: model.type);
  }

  @override
  LoggedUserInfoDto toDto(LoggedUserInfoModel model) {
    // TODO: implement fromDto
    throw UnimplementedError();
  }
}
