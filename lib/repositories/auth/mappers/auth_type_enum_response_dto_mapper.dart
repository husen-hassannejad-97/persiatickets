import 'package:billit_now/repositories/auth/models/auth_type_enum_model.dart';
import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/services/auth/response_dto/auth_type_enum_response_dto.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthTypeEnumResponseDtoMapper extends BaseDtoMapper<AuthTypeEnumResponseDto, AuthTypeEnumModel> {
  @override
  AuthTypeEnumModel fromDto(AuthTypeEnumResponseDto dto) {
    if(dto == AuthTypeEnumResponseDto.login) {
      return AuthTypeEnumModel.login;
    } else if(dto == AuthTypeEnumResponseDto.signup) {
      return AuthTypeEnumModel.signup;
    }
    return AuthTypeEnumModel.undefined;
  }

  @override
  AuthTypeEnumResponseDto toDto(AuthTypeEnumModel model) {
    if(model == AuthTypeEnumModel.login) {
      return AuthTypeEnumResponseDto.login;
    } else if(model == AuthTypeEnumModel.signup) {
      return AuthTypeEnumResponseDto.signup;
    }
    throw UnimplementedError();
  }

}