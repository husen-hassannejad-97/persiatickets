import 'package:billit_now/repositories/base/base_dto_entity_mapper.dart';
import 'package:injectable/injectable.dart';

import '../../../local_storage/auth/entities/token_entity.dart';
import '../../../services/auth/response_dto/token_response_dto.dart';

@injectable
class TokenResponseDtoEntityMapper extends BaseDtoEntityMapper<TokenResponseDto, TokenEntity> {
  @override
  TokenEntity fromDto(TokenResponseDto dto) {
    return TokenEntity(tokenType: dto.tokenType, accessToken: dto.accessToken, refreshToken: dto.refreshToken ?? "");
  }

  @override
  TokenResponseDto toDto(TokenEntity entity) {
    return TokenResponseDto(tokenType: entity.tokenType, accessToken: entity.accessToken, refreshToken: entity.refreshToken);
  }

}