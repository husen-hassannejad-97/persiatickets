import 'package:injectable/injectable.dart';

import '../../../services/seat/response_dto/seat_response_dto.dart';
import '../../base/base_dto_mapper.dart';
import '../models/seat_model.dart';

@injectable
class SeatResponseDtoMapper implements BaseDtoMapper<SeatResponseDto, SeatModel> {
  @override
  SeatResponseDto toDto(SeatModel model) {
    return SeatResponseDto(
      venueId: model.venueId,
      seatNumber: model.seatNumber,
      rowNumber: model.rowNumber,
      seatType: model.seatType,
      id: model.id,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  @override
  SeatModel fromDto(SeatResponseDto dto) {
    return SeatModel(
      venueId: dto.venueId,
      seatNumber: dto.seatNumber,
      rowNumber: dto.rowNumber,
      seatType: dto.seatType,
      id: dto.id,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }
}
