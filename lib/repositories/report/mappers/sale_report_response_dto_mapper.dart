import 'package:injectable/injectable.dart';

import '../../../services/report/response_dto/sale_report_response_dto.dart';
import '../../base/base_dto_mapper.dart';
import '../models/sale_report_model.dart';

@injectable
class SaleReportResponseDtoMapper implements BaseDtoMapper<SaleReportResponseDto, SaleReportModel> {
  @override
  SaleReportResponseDto toDto(SaleReportModel model) {
    return SaleReportResponseDto(
      eventId: model.eventId,
      eventName: model.eventName,
      totalTicketsSold: model.totalTicketsSold,
      totalRevenue: model.totalRevenue,
      reportGeneratedAt: model.reportGeneratedAt,
    );
  }

  @override
  SaleReportModel fromDto(SaleReportResponseDto dto) {
    return SaleReportModel(
      eventId: dto.eventId,
      eventName: dto.eventName,
      totalTicketsSold: dto.totalTicketsSold,
      totalRevenue: dto.totalRevenue,
      reportGeneratedAt: dto.reportGeneratedAt,
    );
  }
}