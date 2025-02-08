import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/repositories/event/models/venue_facilities_model.dart';
import 'package:injectable/injectable.dart';
import '../../../services/event/response_dto/event_venue_facility_item_response_dto.dart';

@injectable
class EventVenueFacilityItemResponseDtoMapper extends BaseDtoMapper<EventVenueFacilityItemResponseDto, FacilityModel> {
  @override
  FacilityModel fromDto(EventVenueFacilityItemResponseDto dto) {
    return FacilityModel(
      icon: dto.icon,
      title: dto.title,
      desc: dto.description,
    );
  }

  @override
  EventVenueFacilityItemResponseDto toDto(FacilityModel model) {
    // TODO: implement toDto
    throw UnimplementedError();
  }

}