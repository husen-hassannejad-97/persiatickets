import 'dart:async';
import 'dart:collection';

import 'package:billit_now/repositories/shared/errors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/shared/result.dart';
import 'base_bloc_event.dart';
import 'base_bloc_state.dart';

class BaseBloc<Event extends BaseBlocEvent, State extends BaseBlocState>
    extends Bloc<BaseBlocEvent, BaseBlocState> {
  BaseBloc({BaseBlocState? initialState})
      : super(initialState ?? StateInitial()) {
    startRetry();
  }

  Future<void> silentCallRepo({
    required Emitter<BaseBlocState> emit,
    required Future<Result<void>> repoFunc,
    bool handleError = false,
  }) async {
    try {
      final result = await repoFunc;
      if (result is Success) {
        emit(StateSuccess());
      } else if (result is Error && handleError) {
        emit(StateError(error: result.error));
      } else {
        throw UnexpectedError(message: 'Unhandled Result type');
      }
    } catch (e, stackTrace) {
      if (handleError) {
        emit(StateError(
            error: UnexpectedError(message: "An unexpected error happened!")));
      }
      // Log stack trace for debugging
      if (kDebugMode) {
        print('Error in ResultToStateConverter: $e\n$stackTrace');
      }
    }
  }

  Future<void> callRepo({
    required Emitter<BaseBlocState> emit,
    required Result<void> repoFunc,
  }) async {
    try {
      // Emit loading state
      emit(StateLoading());

      // Call the repository function
      final result = repoFunc;

      // Handle result
      if (result is Success) {
        emit(StateSuccess());
      } else if (result is Error) {
        emit(StateError(error: result.error));
      } else {
        throw UnexpectedError(message: 'Unhandled Result type');
      }
    } catch (e, stackTrace) {
      // Handle any unexpected errors
      emit(StateError(
          error: UnexpectedError(message: "An unexpected error happened!")));
      // Log stack trace for debugging
      if (kDebugMode) {
        print('Error in ResultToStateConverter: $e\n$stackTrace');
      }
    }
  }

  Future<void> silentCallRepoWithResult<T>({
    required Emitter<BaseBlocState> emit,
    required Future<Result<T>> repoFunc,
    bool handleError = false,
  }) async {
    try {
      final result = await repoFunc;
      if (result is Success<T>) {
        emit(StateSuccessWithResult<T>(result: result.data));
      } else if (result is Error<T> && handleError) {
        emit(StateError(error: result.error));
      } else {
        throw UnexpectedError(message: 'Unhandled Result type');
      }
    } catch (e, stackTrace) {
      if (handleError) {
        emit(StateError(
            error: UnexpectedError(message: "An unexpected error happened!")));
      }
      if (kDebugMode) {
        print('Error in ResultToStateConverter: $e\n$stackTrace');
      }
    }
  }

  Future<void> callRepoWithResult<T>({
    required Emitter<BaseBlocState> emit,
    required Result<T> repoFunc,
  }) async {
    try {
      emit(StateLoading());
      final result = repoFunc;
      if (result is Success<T>) {
        emit(StateSuccessWithResult<T>(result: result.data));
      } else if (result is Error<T>) {
        emit(StateError(error: result.error));
      } else {
        throw UnexpectedError(message: 'Unhandled Result type');
      }
    } catch (e, stackTrace) {
      emit(StateError(
          error: UnexpectedError(message: "An unexpected error happened!")));
      if (kDebugMode) {
        print('Error in ResultToStateConverter: $e\n$stackTrace');
      }
    }
  }

  Future<void> silentCallRepoWithNullableResult<T>({
    required Emitter<BaseBlocState> emit,
    required Future<Result<T>> repoFunc,
    bool handleError = false,
  }) async {
    try {
      final result = await repoFunc;
      if (result is Success<T>) {
        emit(StateSuccessNullableResult<T>(result: result.data));
      } else if (result is Error<T> && handleError) {
        emit(StateError(error: result.error));
      } else {
        throw UnexpectedError(message: 'Unhandled Result type');
      }
    } catch (e, stackTrace) {
      if (handleError) {
        emit(StateError(
            error: UnexpectedError(message: "An unexpected error happened!")));
      }
      if (kDebugMode) {
        print('Error in ResultToStateConverter: $e\n$stackTrace');
      }
    }
  }

  Future<void> callRepoWithNullableResult<T>({
    required Emitter<BaseBlocState> emit,
    required Future<Result<T>> repoFunc,
  }) async {
    try {
      emit(StateLoading());
      final result = await repoFunc;
      if (result is Success<T>) {
        emit(StateSuccessNullableResult<T>(result: result.data));
      } else if (result is Error<T>) {
        emit(StateError(error: result.error));
      } else {
        throw UnexpectedError(message: 'Unhandled Result type');
      }
    } catch (e, stackTrace) {
      emit(StateError(
          error: UnexpectedError(message: "An unexpected error happened!")));
      if (kDebugMode) {
        print('Error in ResultToStateConverter: $e\n$stackTrace');
      }
    }
  }

  bool _alreadyLoaded = false;

  bool isAlreadyLoaded() {
    return _alreadyLoaded;
  }

  BaseBlocEvent? _lastEvent;
  DateTime? _lastEventTimestamp;
  final Queue<BaseBlocEvent> _cachedEvents = Queue<BaseBlocEvent>();

  int cachedEventsQueueSize() => 10;

  void _cacheEvent(BaseBlocEvent event) {
    int queueSize = cachedEventsQueueSize();
    if (queueSize < 0) queueSize = 0;
    if (_cachedEvents.length >= queueSize) {
      final itemsToRemove = _cachedEvents.length - queueSize + 1;
      for (int i = 0; i < itemsToRemove; i++) {
        _cachedEvents.removeFirst();
      }
    }
    _cachedEvents.add(event);
  }

  List<BaseBlocEvent> getCachedEvents() => _cachedEvents.toList();

  bool eventToDebounce(BaseBlocEvent currentEvent) => true;

  Duration eventDebounceThreshold(
          BaseBlocEvent lastEvent, BaseBlocEvent event) =>
      Duration.zero;

  Duration retryDuration() => Duration.zero;

  @override
  void add(BaseBlocEvent event) {
    _cacheEvent(event);
    if (!eventToDebounce(event)) {
      super.add(event);
      return;
    }
    final now = DateTime.now();

    if (_lastEvent == null ||
        event.runtimeType != _lastEvent.runtimeType ||
        _lastEventTimestamp == null ||
        now.difference(_lastEventTimestamp!) >=
            eventDebounceThreshold(_lastEvent!, event)) {
      _lastEvent = event;
      _lastEventTimestamp = now;
      super.add(event);
    } else {
      if (kDebugMode) {
        print("Duplicated events");
      }
    }
  }

  @override
  void onChange(Change<BaseBlocState> change) {
    if (change is StateSuccess) {
      _alreadyLoaded = true;
    }
    super.onChange(change);
  }

  void onRetry() {}

  void startRetry() {
    if (retryDuration() > Duration.zero) {
      _retryTimer = Timer.periodic(retryDuration(), (timer) {
        onRetry();
      });
    }
  }

  void stopRetry() {
    _retryTimer?.cancel();
  }

  Timer? _retryTimer;

  @override
  Future<void> close() {
    _retryTimer?.cancel();
    return super.close();
  }
}
