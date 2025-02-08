import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_bloc_event.dart';

class EventBloc extends Bloc<BaseBlocEvent, BaseBlocEvent> {
  EventBloc() : super(EventInitial()) {
    on<BaseBlocEvent>((event, emit) {
      emit(event);
    });
  }
}
