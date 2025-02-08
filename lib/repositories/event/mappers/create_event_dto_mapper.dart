import 'package:injectable/injectable.dart';

import '../../../services/event/dto/create_event_dto.dart';
import '../../base/base_dto_mapper.dart';
import '../input_models/create_event_input_model.dart';

@injectable
class CreateEventDtoMapper implements BaseDtoMapper<CreateEventDto, CreateEventInputModel> {
  @override
  CreateEventDto toDto(CreateEventInputModel model) {
    return CreateEventDto(
      name: model.name,
      description: model.description,
      startTime: model.startTime,
      endTime: model.endTime,
      venueId: model.venueId,
      category: model.category,
      seatMap: model.seatMap,
    );
  }

  @override
  CreateEventInputModel fromDto(CreateEventDto dto) {
    return CreateEventInputModel(
      name: dto.name,
      description: dto.description,
      startTime: dto.startTime,
      endTime: dto.endTime,
      venueId: dto.venueId,
      category: dto.category,
      seatMap: dto.seatMap,
    );
  }
}