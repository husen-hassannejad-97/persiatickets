import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/repositories/event/models/about_artist_model.dart';
import 'package:billit_now/repositories/event/models/programs_model.dart';
import 'package:billit_now/repositories/event/models/programs_status.dart';
import 'package:billit_now/repositories/event/models/venue_facilities_model.dart';
import 'package:billit_now/services/event/response_dto/event_artist_response_dto.dart';
import 'package:billit_now/services/event/response_dto/event_faq_response_dto.dart';
import 'package:billit_now/services/event/response_dto/event_program_response_dto.dart';
import 'package:billit_now/services/event/response_dto/event_venue_facility_response_dto.dart';
import 'package:injectable/injectable.dart';

import '../models/info_faq_model.dart';

@injectable
class EventFaqResponseDtoMapper extends BaseDtoMapper<EventFaqResponseDto, FaqModel> {
  @override
  FaqModel fromDto(EventFaqResponseDto dto) {
    return FaqModel(
        title: dto.customQuestion ?? "",
        desc: dto.customAnswer ?? "",
    );
  }

  @override
  EventFaqResponseDto toDto(FaqModel model) {
    // TODO: implement toDto
    throw UnimplementedError();
  }

}