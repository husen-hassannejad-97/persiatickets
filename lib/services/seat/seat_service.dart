import 'package:billit_now/services/base/base_service.dart';
import 'package:billit_now/services/seat/response_dto/seat_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import 'dto/create_seat_dto.dart';
import 'dto/update_seat_dto.dart';

part 'seat_service.g.dart';

@RestApi()
@singleton
abstract class SeatService extends BaseService {

  @factoryMethod
  factory SeatService(Dio dio) = _SeatService;

  @GET('seats/venue/{venue_id}')
  Future<List<SeatResponseDto>> seats(@Path("venue_id") String venueId);

  @POST('seats')
  Future<SeatResponseDto> createSeat(@Body() CreateSeatDto createSeatDto);

  @PUT('seats/{seat_id}')
  Future<SeatResponseDto> updateSeat(@Path("seat_id") String seatId, @Body() UpdateSeatDto updateSeatDto);

  @DELETE('seats/{seat_id}')
  Future<SeatResponseDto> deleteSeat(@Path("seat_id") String seatId);

}