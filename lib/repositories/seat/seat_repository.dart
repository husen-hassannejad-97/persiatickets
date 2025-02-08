import 'package:billit_now/repositories/base/base_repository.dart';
import 'package:billit_now/repositories/seat/input_models/create_seat_input_model.dart';
import 'package:billit_now/repositories/seat/input_models/update_seat_input_model.dart';
import 'package:billit_now/repositories/seat/mappers/create_seat_dto_mapper.dart';
import 'package:billit_now/repositories/seat/mappers/seat_response_dto_mapper.dart';
import 'package:billit_now/repositories/seat/mappers/update_seat_dto_mapper.dart';
import 'package:billit_now/repositories/seat/models/seat_model.dart';
import 'package:billit_now/services/seat/response_dto/seat_response_dto.dart';
import 'package:billit_now/services/seat/seat_service.dart';
import 'package:injectable/injectable.dart';

import '../shared/result.dart';

@singleton
class SeatRepository extends BaseRepository {

  final SeatService seatService;
  final SeatResponseDtoMapper seatResponseDtoMapper;
  final CreateSeatDtoMapper createSeatDtoMapper;
  final UpdateSeatDtoMapper updateSeatDtoMapper;
  SeatRepository({
    required this.seatService,
    required this.seatResponseDtoMapper,
    required this.createSeatDtoMapper,
    required this.updateSeatDtoMapper,
  });

  Future<Result<List<SeatModel>>> getSeats(String venueId) {
    return callApi(() {
      return seatService.seats(venueId);
    }).map(
            (List<SeatResponseDto> data) => data.map(
                (SeatResponseDto item) => seatResponseDtoMapper.fromDto(item)
        ).toList()
    );
  }

  Future<Result<SeatModel>> createSeat(CreateSeatInputModel createSeatInputModel) {
    return callApi(() {
      return seatService.createSeat(
          createSeatDtoMapper.toDto(createSeatInputModel)
      );
    }).map(
            (SeatResponseDto response) => seatResponseDtoMapper.fromDto(response)
    );
  }

  Future<Result<SeatModel>> updateSeat(String seatId, UpdateSeatInputModel updateSeatInputModel) {
    return callApi(() {
      return seatService.updateSeat(
          seatId,
          updateSeatDtoMapper.toDto(updateSeatInputModel)
      );
    }).map(
            (SeatResponseDto response) => seatResponseDtoMapper.fromDto(response)
    );
  }

  Future<Result<SeatModel>> deleteSeat(String seatId) {
    return callApi(() {
      return seatService.deleteSeat(
        seatId,
      );
    }).map(
            (SeatResponseDto response) => seatResponseDtoMapper.fromDto(response)
    );
  }

}