

import 'package:billit_now/repositories/shared/errors.dart';

abstract class Result<T> {}

class Error<T> extends Result<T> {
  ResultError error;
  Error({required this.error});
}

class Success<T> extends Result<T> {
  T data;
  Success({required this.data});
}

extension ResultExtension<T> on Result<T> {
  Result<C> map<C>(C Function(T data) mapper) {
    if (this is Success<T>) {
      final success = this as Success<T>;
      return Success<C>(data: mapper(success.data));
    } else if (this is Error<T>) {
      final error = this as Error<T>;
      return Error<C>(error: error.error);
    } else {
      return Error<C>(error: UnexpectedError(message: "An unexpected error happened!"));
    }
  }
}

extension FutureResultExtension<T> on Future<Result<T>> {
  Future<Result<C>> map<C>(C Function(T data) mapper) {
    return then((result) {
      if (result is Success<T>) {
        return Success<C>(data: mapper(result.data));
      } else if (result is Error<T>) {
        return Error<C>(error: result.error);
      } else {
        return Error<C>(error: UnexpectedError(message: "An unexpected error happened!"));
      }
    });
  }
}