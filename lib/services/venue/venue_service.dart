import 'package:billit_now/services/base/base_service.dart';
import 'package:billit_now/services/venue/response_dto/venue_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import 'dto/create_venue_dto.dart';
import 'dto/update_venue_dto.dart';

part 'venue_service.g.dart';

@RestApi()
@singleton
abstract class VenueService extends BaseService {

  @factoryMethod
  factory VenueService(Dio dio) = _VenueService;

  @GET('venues')
  Future<List<VenueResponseDto>> venues();

  @POST('venues')
  Future<VenueResponseDto> createVenue(@Body() CreateVenueDto createVenueDto);

  @PUT('venues/{venue_id}')
  Future<VenueResponseDto> updateVenue(@Path("venue_id") String venueId, @Body() UpdateVenueDto updateVenueDto);

  @DELETE('venues/{venue_id}')
  Future<VenueResponseDto> deleteVenue(@Path("venue_id") String venueId);

  @GET('venues/{venue_id}')
  Future<VenueResponseDto> venue(@Path("venue_id") String venueId);

}