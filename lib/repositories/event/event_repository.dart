

import 'package:billit_now/repositories/event/input_models/create_event_input_model.dart';
import 'package:billit_now/repositories/event/input_models/update_event_input_model.dart';
import 'package:billit_now/repositories/event/mappers/create_event_dto_mapper.dart';
import 'package:billit_now/repositories/event/mappers/update_event_dto_mapper.dart';
import 'package:billit_now/repositories/event/models/event_details_model.dart';
import 'package:billit_now/repositories/event/models/event_range_model.dart';
import 'package:billit_now/services/event/dto/event_category_dto.dart';
import 'package:billit_now/services/event/response_dto/event_details_response_dto.dart';
import 'package:billit_now/templates/events/event_page/event_details_fake_data_generator.dart';
import 'package:injectable/injectable.dart';

import '../../services/event/event_service.dart';
import '../../services/event/response_dto/event_response_dto.dart';
import '../base/base_repository.dart';
import '../shared/result.dart';
import 'input_models/get_events_input_model.dart';
import 'mappers/event_details_response_dto_mapper.dart';
import 'mappers/event_response_dto_mapper.dart';
import 'mappers/get_events_dto_mapper.dart';
import 'models/event_model.dart';

@singleton
class EventRepository extends BaseRepository {

  final EventService eventService;
  final EventResponseDtoMapper eventResponseDtoMapper;
  final CreateEventDtoMapper createEventDtoMapper;
  final UpdateEventDtoMapper updateEventDtoMapper;
  final GetEventsDtoMapper getEventsDtoMapper;
  final EventDetailsResponseDtoMapper eventDetailsResponseDtoMapper;
  EventRepository({
    required this.eventService,
    required this.eventResponseDtoMapper,
    required this.createEventDtoMapper,
    required this.updateEventDtoMapper,
    required this.getEventsDtoMapper,
    required this.eventDetailsResponseDtoMapper,
  });

  Future<Result<List<EventModel>>> getEvents(GetEventsInputModel getEventsInputModel) async {
    return callApi(() {
      final dto = getEventsDtoMapper.toDto(getEventsInputModel);
      return eventService.events(
        0,
        dto.limit,
        dto.eventCategoryDto.value,
        null,
        null,
        "created_at",
        "desc",
        null,
      );
    }).map(
        (List<EventResponseDto> data) => data.map(
            (EventResponseDto item) => eventResponseDtoMapper.fromDto(item)
        ).toList()
    );
  }

  Future<Result<List<EventModel>>> getEventsRange(
      GetEventsInputModel getEventsInputModel,
      EventRangeModel? eventRangeModel
      ) async {
    return callApi(() {
      final dto = getEventsDtoMapper.toDto(getEventsInputModel);
      return eventService.events(
        0,
        dto.limit,
        dto.eventCategoryDto.value,
        null,
        null,
        "created_at",
        "desc",
        eventRangeModel.toString().split('.').last
      );
    }).map(
            (List<EventResponseDto> data) => data.map(
                (EventResponseDto item) => eventResponseDtoMapper.fromDto(item)
        ).toList()
    );
  }

  Future<Result<EventModel>> createEvent(CreateEventInputModel createEventInputModel) async {
    return callApi(() {
      return eventService.createEvent(
        createEventDtoMapper.toDto(createEventInputModel)
      );
    }).map(
        (EventResponseDto response) => eventResponseDtoMapper.fromDto(response)
    );
  }

  Future<Result<EventModel>> updateEvent(String eventId, UpdateEventInputModel updateEventInputModel) async {
    return callApi(() {
      return eventService.updateEvent(
          eventId,
          updateEventDtoMapper.toDto(updateEventInputModel)
      );
    }).map(
            (EventResponseDto response) => eventResponseDtoMapper.fromDto(response)
    );
  }

  Future<Result<EventModel>> deleteEvent(String eventId) async {
    return callApi(() {
      return eventService.deleteEvent(
          eventId,
      );
    }).map(
            (EventResponseDto response) => eventResponseDtoMapper.fromDto(response)
    );
  }


  Future<Result<EventDetailsModel>> getEventDetails(String eventId) async {
    try {
      return callApi(() {
        return eventService.event(
          eventId,
        );
      }).map(
              (EventDetailsResponseDto response) => eventDetailsResponseDtoMapper.fromDto(response)
      );
    } catch(e) {
      return Future.value(getEventDetailsFake(eventId));
    }
  }


  Future<Result<EventModel>> getEventSeatMap(String eventId) async {
    return callApi(() {
      return eventService.eventSeatMap(
        eventId,
      );
    }).map(
            (EventResponseDto response) => eventResponseDtoMapper.fromDto(response)
    );
  }

  Future<Result<EventDetailsModel>> getEventDetailsFake(String eventId) async {
    await Future.delayed(Duration(seconds: 1));
    return Future.value(
        Success<EventDetailsModel>(
            data: fakeEventDetailsModel()
        )
    );
  }

}