import 'package:injectable/injectable.dart';

import '../../../services/seat/dto/update_seat_dto.dart';
import '../../base/base_dto_mapper.dart';
import '../input_models/update_seat_input_model.dart';

@injectable
class UpdateSeatDtoMapper implements BaseDtoMapper<UpdateSeatDto, UpdateSeatInputModel> {
  @override
  UpdateSeatDto toDto(UpdateSeatInputModel model) {
    return UpdateSeatDto(
      seatNumber: model.seatNumber,
      rowNumber: model.rowNumber,
      seatType: model.seatType,
    );
  }

  @override
  UpdateSeatInputModel fromDto(UpdateSeatDto dto) {
    return UpdateSeatInputModel(
      seatNumber: dto.seatNumber,
      rowNumber: dto.rowNumber,
      seatType: dto.seatType,
    );
  }
}
