import 'package:injectable/injectable.dart';

import '../../../services/event/dto/update_event_dto.dart';
import '../../base/base_dto_mapper.dart';
import '../input_models/update_event_input_model.dart';

@injectable
class UpdateEventDtoMapper implements BaseDtoMapper<UpdateEventDto, UpdateEventInputModel> {
  @override
  UpdateEventDto toDto(UpdateEventInputModel model) {
    return UpdateEventDto(
      name: model.name,
      description: model.description,
      startTime: model.startTime,
      endTime: model.endTime,
      category: model.category,
      seatMap: model.seatMap,
    );
  }

  @override
  UpdateEventInputModel fromDto(UpdateEventDto dto) {
    return UpdateEventInputModel(
      name: dto.name,
      description: dto.description,
      startTime: dto.startTime,
      endTime: dto.endTime,
      category: dto.category,
      seatMap: dto.seatMap,
    );
  }
}