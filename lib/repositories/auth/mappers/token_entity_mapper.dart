import 'package:billit_now/repositories/auth/models/token_model.dart';
import 'package:billit_now/repositories/base/base_entity_mapper.dart';
import 'package:injectable/injectable.dart';

import '../../../local_storage/auth/entities/token_entity.dart';

@singleton
class TokenEntityMapper extends BaseEntityMapper<TokenEntity, TokenModel> {
  @override
  TokenModel fromEntity(TokenEntity entity) {
    return TokenModel(tokenType: entity.tokenType, accessToken: entity.accessToken, refreshToken: entity.refreshToken);
  }

  @override
  TokenEntity toEntity(TokenModel model) {
    return TokenEntity(tokenType: model.tokenType, accessToken: model.accessToken, refreshToken: model.refreshToken ?? "");
  }

}