import 'package:injectable/injectable.dart';

import '../../../services/report/response_dto/inventory_report_response_dto.dart';
import '../../base/base_dto_mapper.dart';
import '../models/inventory_report_model.dart';

@injectable
class InventoryReportResponseDtoMapper implements BaseDtoMapper<InventoryReportResponseDto, InventoryReportModel> {
  @override
  InventoryReportResponseDto toDto(InventoryReportModel model) {
    return InventoryReportResponseDto(
      eventId: model.eventId,
      eventName: model.eventName,
      totalTicketsAvailable: model.totalTicketsAvailable,
      totalTicketsSold: model.totalTicketsSold,
      totalTicketsReserved: model.totalTicketsReserved,
      reportGeneratedAt: model.reportGeneratedAt,
    );
  }

  @override
  InventoryReportModel fromDto(InventoryReportResponseDto dto) {
    return InventoryReportModel(
      eventId: dto.eventId,
      eventName: dto.eventName,
      totalTicketsAvailable: dto.totalTicketsAvailable,
      totalTicketsSold: dto.totalTicketsSold,
      totalTicketsReserved: dto.totalTicketsReserved,
      reportGeneratedAt: dto.reportGeneratedAt,
    );
  }
}