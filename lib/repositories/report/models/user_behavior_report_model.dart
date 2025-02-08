import '../../base/base_model.dart';

class UserBehaviorReportModel implements BaseModel {
  final List<String> mostPopularEvents;
  final List<String> peakBookingTimes;
  final DateTime reportGeneratedAt;

  UserBehaviorReportModel({
    required this.mostPopularEvents,
    required this.peakBookingTimes,
    required this.reportGeneratedAt,
  });
}