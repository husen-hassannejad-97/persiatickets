import 'package:billit_now/services/base/base_service.dart';
import 'package:billit_now/services/event/response_dto/event_details_response_dto.dart';
import 'package:billit_now/services/event/response_dto/event_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import 'dto/create_event_dto.dart';
import 'dto/update_event_dto.dart';

part 'event_service.g.dart';

const EventServiceVersion = "v1";

@RestApi()
@singleton
abstract class EventService extends BaseService {

  @factoryMethod
  factory EventService(Dio dio) = _EventService;

  @GET('api/$EventServiceVersion/events/')
  Future<List<EventResponseDto>> events(
      @Query("skip") int skip,
      @Query("limit") int limit,
      @Query("category") String category,
      @Query("venue_id") int? venueId,
      @Query("search") String? search,
      @Query("sort_by") String sortBy,
      @Query("order") String desc,
      @Query("time_range") String? timeRange,
      );

  @POST('api/$EventServiceVersion/events')
  Future<EventResponseDto> createEvent(@Body() CreateEventDto createEventDto);

  @PUT('api/$EventServiceVersion/events/{event_id}')
  Future<EventResponseDto> updateEvent(@Path("event_id") String eventId, @Body() UpdateEventDto updateEventDto);

  @DELETE('api/$EventServiceVersion/events/{event_id}')
  Future<EventResponseDto> deleteEvent(@Path("event_id") String eventId);

  @GET('api/$EventServiceVersion/events/{event_id}')
  Future<EventDetailsResponseDto> event(@Path("event_id") String eventId);

  @GET('api/$EventServiceVersion/events/{event_id}/seatmap')
  Future<EventResponseDto> eventSeatMap(@Path("event_id") String eventId);

}