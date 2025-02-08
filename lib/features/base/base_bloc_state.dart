import 'package:billit_now/repositories/shared/errors.dart';

abstract class BaseBlocState {}

final class StateInitial extends BaseBlocState {}

final class StateLoading extends BaseBlocState {}

final class StateError extends BaseBlocState {
  ResultError error;
  StateError({required this.error});
}

final class StateSuccess extends BaseBlocState {}

final class StateSuccessWithResult<T> extends StateSuccess {
  T result;
  StateSuccessWithResult({required this.result});
}

final class StateSuccessNullableResult<T> extends StateSuccess {
  T? result;
  StateSuccessNullableResult({required this.result});
}
