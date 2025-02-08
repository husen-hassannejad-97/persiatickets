import 'package:billit_now/repositories/ad/models/record_ad_action_model.dart';
import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/services/ad/response_dto/record_ad_action_response_dto.dart';
import 'package:injectable/injectable.dart';

@injectable
class RecordAdActionResponseDtoMapper
    extends BaseDtoMapper<RecordAdActionResponseDto, RecordAdActionModel> {
  @override
  RecordAdActionModel fromDto(RecordAdActionResponseDto dto) {
    return RecordAdActionModel(
        id: dto.id,
        adId: dto.adId,
        actionType: dto.actionType,
        timestamp: dto.timestamp);
  }

  @override
  RecordAdActionResponseDto toDto(RecordAdActionModel model) {
    // TODO: implement toDto
    throw UnimplementedError();
  }
}
