import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/repositories/event/models/event_category_model.dart';
import 'package:billit_now/services/event/dto/event_category_dto.dart';
import 'package:injectable/injectable.dart';

@injectable
class EventCategoryDtoMapper extends BaseDtoMapper<EventCategoryDto, EventCategoryModel> {
  @override
  EventCategoryModel fromDto(EventCategoryDto dto) {
    if(dto == EventCategoryDto.cinema) {
      return EventCategoryModel.cinema;
    } else if(dto == EventCategoryDto.theater) {
      return EventCategoryModel.theater;
    } else if(dto == EventCategoryDto.concert) {
      return EventCategoryModel.concert;
    }
    throw UnimplementedError();
  }

  @override
  EventCategoryDto toDto(EventCategoryModel model) {
    if(model == EventCategoryModel.cinema) {
      return EventCategoryDto.cinema;
    } else if(model == EventCategoryModel.theater) {
      return EventCategoryDto.theater;
    } else if(model == EventCategoryModel.concert) {
      return EventCategoryDto.concert;
    }
    throw UnimplementedError();
  }

}