import 'package:billit_now/local_storage/base/base_storage.dart';
import 'package:billit_now/core/constants/app_constants.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import 'entities/token_entity.dart';

@injectable // TODO Fix the issue when it doesn't work with @singleton
class AuthStorage extends BaseStorage {
  Future<void> saveToken(TokenEntity token) async {
    saveTokenAsString(token.accessToken);
    Box<TokenEntity> box =
        await Hive.openBox<TokenEntity>(AppConstants.hiveBox);
    await box.put(AppConstants.hiveAuthToken, token);
  }

  Future<void> saveTokenAsString(String token) async {
    // print('*TAGX*****$token');
    Box<String> box = await Hive.openBox<String>(AppConstants.hiveBox);
    await box.put(AppConstants.hiveAuthTokenString, token);
  }

  Future<TokenEntity?> readToken() async {
    Box<TokenEntity> box =
        await Hive.openBox<TokenEntity>(AppConstants.hiveBox);

    TokenEntity? token = box.get(AppConstants.hiveAuthToken);

    return token;
  }

  Future<String?> readTokenAsString() async {
    Box<String> box = await Hive.openBox<String>(AppConstants.hiveBox);
    String? token = box.get(AppConstants.hiveAuthTokenString);
    return token;
  }

  Future<void> removeToken() async {
    Box box = await Hive.openBox(AppConstants.hiveBox);

    return box.delete(AppConstants.hiveAuthToken);
  }

  Future<void> removeTokenAsString() async {
    print('TAGX storage');
    Box<String> box = await Hive.openBox<String>(AppConstants.hiveBox);
    return box.delete(AppConstants.hiveAuthToken);
  }
}
