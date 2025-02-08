import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_behavior_report_response_dto.g.dart';

@JsonSerializable()
class UserBehaviorReportResponseDto implements BaseDto{
  @JsonKey(name: 'most_popular_events')
  final List<String> mostPopularEvents;
  @JsonKey(name: 'peak_booking_times')
  final List<String> peakBookingTimes;
  @JsonKey(name: 'report_generated_at')
  final DateTime reportGeneratedAt;

  UserBehaviorReportResponseDto({
    required this.mostPopularEvents,
    required this.peakBookingTimes,
    required this.reportGeneratedAt,
  });

  @factoryMethod
  factory UserBehaviorReportResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UserBehaviorReportResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserBehaviorReportResponseDtoToJson(this);
}