import '../../base/base_model.dart';

class TokenModel implements BaseModel {
  String tokenType;
  String accessToken;
  String? refreshToken;
  TokenModel({required this.tokenType, required  this.accessToken, required this.refreshToken});
}