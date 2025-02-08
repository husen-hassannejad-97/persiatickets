// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_action_stats_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdActionStatsResponseDto _$AdActionStatsResponseDtoFromJson(
        Map<String, dynamic> json) =>
    AdActionStatsResponseDto(
      adId: (json['ad_id'] as num).toInt(),
      totalViews: (json['total_views'] as num).toInt(),
      totalClicks: (json['total_clicks'] as num).toInt(),
    );

Map<String, dynamic> _$AdActionStatsResponseDtoToJson(
        AdActionStatsResponseDto instance) =>
    <String, dynamic>{
      'ad_id': instance.adId,
      'total_views': instance.totalViews,
      'total_clicks': instance.totalClicks,
    };
