import 'package:billit_now/repositories/shared/errors.dart';
import 'package:billit_now/repositories/shared/result.dart';
import 'package:dio/dio.dart';

abstract class BaseRepository {
  Future<Result<T>> callApi<T>(Future<T> Function() apiCall) async {
    try {
      return Success(data: await apiCall());
    } on DioException catch (dioError) {
      return Error(error: handleApiError(dioError));
    } catch (e) {
      throw Error(
          error: UnexpectedError(
              message:
                  "An unexpected error happened! Extra information: ${e.toString()}"));
    }
  }

  static ResultError handleApiError(DioException dioError) {
    if (dioError.response != null) {
      final statusCode = dioError.response!.statusCode;

      final serverMessage = dioError.response!.data['detail'] ??
          "An error occurred, try again later.";

      if (statusCode != null) {
        if (statusCode == 400) {
          return BadRequestError(detail: serverMessage);
        } else if (statusCode == 401) {
          return UnauthorizedError();
        } else if (statusCode == 500) {
          return ServerError(message: "Internal server error!");
        } else if (statusCode == 404) {
          return NotFoundError();
        } else {
          return UnexpectedError(message: "An unexpected error happened!");
        }
      } else {
        return UnexpectedError(message: "An unexpected error happened!");
      }
    } else if (dioError.type == DioExceptionType.connectionError ||
        dioError.type == DioExceptionType.connectionTimeout ||
        dioError.type == DioExceptionType.receiveTimeout ||
        dioError.type == DioExceptionType.sendTimeout) {
      return ConnectionError();
    } else {
      return UnexpectedError(message: "An unexpected error happened!");
    }
  }

  Future<Result<T>> callStorage<T>(Future<T> Function() storageCall) async {
    try {
      return Success(data: await storageCall());
    } on Exception catch (e) {
      throw Error(error: handleStorageError(e));
    }
  }

  ResultError handleStorageError(Exception error) {
    return IOError(message: "An IOException encountered!");
  }

  Future<Result<T>> callDatabase<T>(Future<T> Function() databaseCall) async {
    try {
      return Success(data: await databaseCall());
    } on Exception catch (e) {
      throw Error(error: handleDatabaseError(e));
    }
  }

  ResultError handleDatabaseError(Exception error) {
    return IOError(message: "An IOException encountered!");
  }
}
