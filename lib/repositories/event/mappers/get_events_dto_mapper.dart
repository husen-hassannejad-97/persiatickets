import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/repositories/event/input_models/get_events_input_model.dart';
import 'package:billit_now/repositories/event/mappers/event_category_dto_mapper.dart';
import 'package:injectable/injectable.dart';

import '../../../services/event/dto/get_events_dto.dart';

@injectable
class GetEventsDtoMapper extends BaseDtoMapper<GetEventsDto, GetEventsInputModel> {
  final EventCategoryDtoMapper eventCategoryDtoMapper;
  GetEventsDtoMapper({required this.eventCategoryDtoMapper});

  @override
  GetEventsInputModel fromDto(GetEventsDto dto) {
    // TODO: implement fromDto
    throw UnimplementedError();
  }

  @override
  GetEventsDto toDto(GetEventsInputModel model) {
    return GetEventsDto(
        eventCategoryDto: eventCategoryDtoMapper.toDto(model.eventCategoryModel),
        limit: model.limit
    );
  }

}