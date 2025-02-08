import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/repositories/event/models/venue_guidelines_model.dart';
import 'package:billit_now/services/event/response_dto/event_guideline_response_dto.dart';
import 'package:injectable/injectable.dart';

import '../../../apps/helper/utils/app_icon_name.dart';

@injectable
class EventGuidelineResponseDtoMapper extends BaseDtoMapper<EventGuidelineResponseDto, GuidesModel> {
  @override
  GuidesModel fromDto(EventGuidelineResponseDto dto) {
    return GuidesModel(
        icon: AppIconName.filledCircleCheckDefault.name,
        desc: dto.customDescription ?? "",
    );
  }

  @override
  EventGuidelineResponseDto toDto(GuidesModel model) {
    // TODO: implement toDto
    throw UnimplementedError();
  }

}