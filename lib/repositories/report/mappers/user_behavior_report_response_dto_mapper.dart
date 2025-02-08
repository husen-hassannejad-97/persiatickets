import 'package:injectable/injectable.dart';

import '../../../services/report/response_dto/user_behavior_report_response_dto.dart';
import '../../base/base_dto_mapper.dart';
import '../models/user_behavior_report_model.dart';

@injectable
class UserBehaviorReportResponseDtoMapper implements BaseDtoMapper<UserBehaviorReportResponseDto, UserBehaviorReportModel> {
  @override
  UserBehaviorReportResponseDto toDto(UserBehaviorReportModel model) {
    return UserBehaviorReportResponseDto(
      mostPopularEvents: model.mostPopularEvents,
      peakBookingTimes: model.peakBookingTimes,
      reportGeneratedAt: model.reportGeneratedAt,
    );
  }

  @override
  UserBehaviorReportModel fromDto(UserBehaviorReportResponseDto dto) {
    return UserBehaviorReportModel(
      mostPopularEvents: dto.mostPopularEvents,
      peakBookingTimes: dto.peakBookingTimes,
      reportGeneratedAt: dto.reportGeneratedAt,
    );
  }
}