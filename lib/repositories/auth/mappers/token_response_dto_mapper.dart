import 'package:billit_now/repositories/auth/models/token_model.dart';
import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:injectable/injectable.dart';

import '../../../services/auth/response_dto/token_response_dto.dart';

@singleton
class TokenResponseDtoMapper extends BaseDtoMapper<TokenResponseDto, TokenModel> {
  @override
  TokenModel fromDto(TokenResponseDto dto) {
    return TokenModel(tokenType: dto.tokenType, accessToken: dto.accessToken, refreshToken: dto.refreshToken);
  }

  @override
  TokenResponseDto toDto(TokenModel model) {
    return TokenResponseDto(tokenType: model.tokenType, accessToken: model.accessToken, refreshToken: model.refreshToken);
  }

}