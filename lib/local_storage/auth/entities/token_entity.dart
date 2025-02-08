import 'package:billit_now/local_storage/base/base_entity.dart';
import 'package:hive_flutter/adapters.dart';

part 'token_entity.g.dart';

@HiveType(typeId: 1)
class TokenEntity extends HiveObject implements BaseEntity {
  @HiveField(0)
  late String tokenType;

  @HiveField(1)
  late String accessToken;

  @HiveField(2)
  late String refreshToken;

  TokenEntity(
      {required this.tokenType,
      required this.accessToken,
      required this.refreshToken});

  TokenEntity.fromJson(Map<String, dynamic> json) {
    tokenType = json['token_type'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'token_type': tokenType,
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }
}
