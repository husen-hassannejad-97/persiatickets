import 'package:billit_now/repositories/ad/input_models/record_ad_action_input_model.dart';
import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/services/ad/dto/record_ad_action_dto.dart';
import 'package:injectable/injectable.dart';

@injectable
class RecordAdActionDtoMapper extends BaseDtoMapper<RecordAdActionDto, RecordAdActionInputModel> {
  @override
  RecordAdActionInputModel fromDto(RecordAdActionDto dto) {
    // TODO: implement fromDto
    throw UnimplementedError();
  }

  @override
  RecordAdActionDto toDto(RecordAdActionInputModel model) {
    return RecordAdActionDto(
        actionType: model.actionType == AdActionType.View ? "view" : "click"
    );
  }

}