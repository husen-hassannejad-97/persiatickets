import 'package:billit_now/repositories/ad/models/ad_action_stats_model.dart';
import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/services/ad/response_dto/ad_action_stats_response_dto.dart';
import 'package:injectable/injectable.dart';

@injectable
class AdActionStatsResponseDtoMapper
    extends BaseDtoMapper<AdActionStatsResponseDto, AdActionStatsModel> {
  @override
  AdActionStatsModel fromDto(AdActionStatsResponseDto dto) {
    return AdActionStatsModel(
        adId: dto.adId,
        totalViews: dto.totalViews,
        totalClicks: dto.totalClicks);
  }

  @override
  AdActionStatsResponseDto toDto(AdActionStatsModel model) {
    // TODO: implement toDto
    throw UnimplementedError();
  }
}
