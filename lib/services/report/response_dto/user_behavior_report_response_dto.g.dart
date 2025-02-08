// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_behavior_report_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBehaviorReportResponseDto _$UserBehaviorReportResponseDtoFromJson(
        Map<String, dynamic> json) =>
    UserBehaviorReportResponseDto(
      mostPopularEvents: (json['most_popular_events'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      peakBookingTimes: (json['peak_booking_times'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      reportGeneratedAt: DateTime.parse(json['report_generated_at'] as String),
    );

Map<String, dynamic> _$UserBehaviorReportResponseDtoToJson(
        UserBehaviorReportResponseDto instance) =>
    <String, dynamic>{
      'most_popular_events': instance.mostPopularEvents,
      'peak_booking_times': instance.peakBookingTimes,
      'report_generated_at': instance.reportGeneratedAt.toIso8601String(),
    };
