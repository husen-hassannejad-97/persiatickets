import 'package:billit_now/services/base/base_dto.dart';
import 'package:billit_now/services/event/dto/event_category_dto.dart';

class GetEventsDto implements BaseDto {
  final EventCategoryDto eventCategoryDto;
  final int limit;
  GetEventsDto({
    required this.eventCategoryDto,
    required this.limit,
  });
}