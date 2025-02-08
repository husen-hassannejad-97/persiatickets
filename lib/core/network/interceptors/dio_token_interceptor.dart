import 'dart:convert';

import 'package:billit_now/core/constants/app_constants.dart';
import 'package:billit_now/core/localization/localize.dart';
import 'package:billit_now/local_storage/auth/AuthStorage.dart';
import 'package:billit_now/services/auth/auth_service.dart';
import 'package:dio/dio.dart';

import '../../../local_storage/auth/entities/token_entity.dart';
import '../../../repositories/auth/mappers/token_response_dto_entity_mapper.dart';
import '../../../services/auth/response_dto/token_response_dto.dart';

class DioTokenInterceptor extends Interceptor {

  AuthStorage authStorage;
  TokenResponseDtoEntityMapper tokenDtoEntityMapper;
  Localize localize;
  DioTokenInterceptor({
    required this.authStorage,
    required this.tokenDtoEntityMapper,
    required this.localize,
  });

  String _composeToken(TokenEntity token) {
    return '${token.tokenType} ${token.accessToken}';
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      // Retrieve token from Hive
      // FIXME
      // final token = await authStorage.readToken();

      options.headers['accept'] = 'application/json';
      options.headers['credentials'] = 'include';
      options.headers['lang'] = localize.selectedLanguage.value.name();

      // FIXME
      // if (token != null) {
      //   // Add Authorization header
      //   options.headers['Authorization'] = _composeToken(token);
      // }

      // Continue the request
      handler.next(options);
    } catch (e) {
      // If there's an error while reading the token, pass it as a DioError
      handler.reject(
        DioException(
          requestOptions: options,
          error: 'Failed to retrieve token: $e',
        ),
      );
    }
  }

  DioException _copyExceptionWithCustomMessage(DioException err, String message) {
    return DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: err.error,
        stackTrace: err.stackTrace,
        message: message
    );
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      TokenEntity? tokenModel;
      try {
        tokenModel = (await authStorage.readToken());
      } catch (e) {
        handler.next(
            _copyExceptionWithCustomMessage(err, "Failed to retrieve token: $e")
        );
      }
      // If 401 and we have refresh token, we refresh the token
      if(tokenModel?.refreshToken.isNotEmpty == true) {
        final Dio dio = Dio();
        Response<dynamic>? response;
        try {
          response = await dio.post(
            "${AppConstants.baseApiUrl}auth/api/$AuthServiceVersion/auth/refresh-token",
            data: jsonEncode({"refresh_token": tokenModel!.refreshToken})
          );
        } catch(e) {
          return handler.next(
            _copyExceptionWithCustomMessage(err, "Couldn't refresh the token $e")
          );
        }
        if(response.statusCode == 200) {
          TokenResponseDto tokenResponseDto = TokenResponseDto.fromJson(response.data);
          TokenEntity newTokenEntity = tokenDtoEntityMapper.fromDto(tokenResponseDto);
          try {
            await authStorage.saveToken(newTokenEntity);
          } catch(e) {
            return handler.next(
                _copyExceptionWithCustomMessage(err, "Couldn't save the token $e")
            );
          }
          err.requestOptions.headers["Authorization"] = _composeToken(newTokenEntity);
          final opts = Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers
          );
          final cloneReq = await dio.request(
              err.requestOptions.path,
              options: opts,
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters
          );
          return handler.resolve(cloneReq);
        } else {
          return handler.next(
              _copyExceptionWithCustomMessage(err, "Couldn't refresh the token")
          );
        }
      } else {
        return handler.next(
          _copyExceptionWithCustomMessage(err, "Couldn't refresh the token ANYMORE!")
        );
      }
    } else {
      // If it didn't get 401 as status code, nothing to do here
      return handler.next(err);
    }
  }
}
