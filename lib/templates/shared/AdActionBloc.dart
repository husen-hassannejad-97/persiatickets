import 'package:billit_now/features/base/base_bloc.dart';
import 'package:billit_now/features/base/base_bloc_event.dart';
import 'package:billit_now/features/base/base_bloc_state.dart';
import 'package:billit_now/repositories/ad/ad_repository.dart';
import 'package:billit_now/repositories/ad/input_models/record_ad_action_input_model.dart';
import 'package:billit_now/repositories/shared/errors.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../repositories/shared/result.dart';

class AdActionBlocEvent extends BaseBlocEvent {}
class AdActionViewEvent extends AdActionBlocEvent {
  final String adId;
  AdActionViewEvent({required this.adId});
}
class AdActionClickEvent extends AdActionBlocEvent {
  final String adId;
  AdActionClickEvent({required this.adId});
}

class AdActionBlocState extends BaseBlocState {}
class AdActionCompleted extends AdActionBlocState{}
class AdActionFailed extends AdActionBlocState{}

@injectable
class AdActionBloc extends BaseBloc<AdActionBlocEvent, AdActionBlocState> {
  final AdRepository adRepo;
  AdActionBloc({
    required this.adRepo
  }) {
    on<AdActionViewEvent>((event, emit) async {
      try {
        emit(StateLoading());
        final result = await adRepo.setRecordAdAction(event.adId,
            RecordAdActionInputModel(actionType: AdActionType.View));
        if (result is Success) {
          emit(AdActionCompleted());
        } else if (result is Error) {
          emit(AdActionFailed());
        } else {
          throw UnexpectedError(message: 'Unhandled Result type');
        }
      } catch (e, stackTrace) {
        emit(AdActionFailed());
        if (kDebugMode) {
          print('Error in ResultToStateConverter: $e\n$stackTrace');
        }
      }
    });
    on<AdActionClickEvent>((event, emit) async {
      try {
        emit(StateLoading());
        final result = await adRepo.setRecordAdAction(event.adId,
            RecordAdActionInputModel(actionType: AdActionType.Click));
        if (result is Success) {
          emit(AdActionCompleted());
        } else if (result is Error) {
          emit(AdActionFailed());
        } else {
          throw UnexpectedError(message: 'Unhandled Result type');
        }
      } catch (e, stackTrace) {
        emit(AdActionFailed());
        if (kDebugMode) {
          print('Error in ResultToStateConverter: $e\n$stackTrace');
        }
      }
    });
  }
}