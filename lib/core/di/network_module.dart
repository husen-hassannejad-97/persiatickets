import 'package:billit_now/core/network/interceptors/dio_token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../constants/app_constants.dart';

@module
abstract class NetworkModule {

  @singleton
  DioTokenInterceptor get dioTokenInterceptor;

  @singleton
  PrettyDioLogger get _prettyDioLogger => PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 160);

  _getDio(
      DioTokenInterceptor dioTokenInterceptor
      ) {
    var dio = Dio(BaseOptions(baseUrl: AppConstants.baseApiUrl));
    dio.interceptors.add(dioTokenInterceptor);
    if (kDebugMode) {
      dio.interceptors.add(_prettyDioLogger);
    }
    dio.options.connectTimeout = Duration(milliseconds: 10000);
    dio.options.receiveTimeout = Duration(milliseconds: 10000);
    dio.options.sendTimeout = Duration(milliseconds: 10000);
    return dio;
  }

  @singleton
  Dio get dio => _getDio(dioTokenInterceptor);

}