import 'package:injectable/injectable.dart';

import '../../../services/seat/dto/create_seat_dto.dart';
import '../../base/base_dto_mapper.dart';
import '../input_models/create_seat_input_model.dart';

@injectable
class CreateSeatDtoMapper implements BaseDtoMapper<CreateSeatDto, CreateSeatInputModel> {
  @override
  CreateSeatDto toDto(CreateSeatInputModel model) {
    return CreateSeatDto(
      venueId: model.venueId,
      seatNumber: model.seatNumber,
      rowNumber: model.rowNumber,
      seatType: model.seatType,
    );
  }

  @override
  CreateSeatInputModel fromDto(CreateSeatDto dto) {
    return CreateSeatInputModel(
      venueId: dto.venueId,
      seatNumber: dto.seatNumber,
      rowNumber: dto.rowNumber,
      seatType: dto.seatType,
    );
  }
}