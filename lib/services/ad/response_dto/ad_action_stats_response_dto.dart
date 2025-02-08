import 'package:billit_now/services/base/base_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ad_action_stats_response_dto.g.dart';

@JsonSerializable()
class AdActionStatsResponseDto implements BaseDto {
  @JsonKey(name: 'ad_id')
  final int adId;
  @JsonKey(name: 'total_views')
  final int totalViews;
  @JsonKey(name: 'total_clicks')
  final int totalClicks;

  AdActionStatsResponseDto({
    required this.adId,
    required this.totalViews,
    required this.totalClicks,
  });

  factory AdActionStatsResponseDto.fromJson(Map<String, dynamic> json) => _$AdActionStatsResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AdActionStatsResponseDtoToJson(this);
}