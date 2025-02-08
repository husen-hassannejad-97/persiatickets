import 'package:billit_now/repositories/base/base_repository.dart';
import 'package:billit_now/repositories/report/mappers/inventory_report_response_dto_mapper.dart';
import 'package:billit_now/repositories/report/mappers/sale_report_response_dto_mapper.dart';
import 'package:billit_now/repositories/report/mappers/user_behavior_report_response_dto_mapper.dart';
import 'package:billit_now/repositories/report/models/inventory_report_model.dart';
import 'package:billit_now/repositories/report/models/sale_report_model.dart';
import 'package:billit_now/repositories/report/models/user_behavior_report_model.dart';
import 'package:billit_now/services/report/report_service.dart';
import 'package:billit_now/services/report/response_dto/inventory_report_response_dto.dart';
import 'package:billit_now/services/report/response_dto/sale_report_response_dto.dart';
import 'package:billit_now/services/report/response_dto/user_behavior_report_response_dto.dart';
import 'package:injectable/injectable.dart';

import '../shared/result.dart';

@singleton
class ReportRepository extends BaseRepository {

  final ReportService reportService;
  final InventoryReportResponseDtoMapper inventoryReportResponseDtoMapper;
  final SaleReportResponseDtoMapper saleReportResponseDtoMapper;
  final UserBehaviorReportResponseDtoMapper userBehaviorReportResponseDtoMapper;
  ReportRepository({
    required this.reportService,
    required this.inventoryReportResponseDtoMapper,
    required this.saleReportResponseDtoMapper,
    required this.userBehaviorReportResponseDtoMapper,
  });

  Future<Result<SaleReportModel>> getSaleReports(String eventId) {
    return callApi(() {
      return reportService.saleReports(eventId);
    }).map(
        (SaleReportResponseDto response) => saleReportResponseDtoMapper.fromDto(response)
    );
  }

  Future<Result<InventoryReportModel>> getInventoryReports(String eventId) {
    return callApi(() {
      return reportService.inventoryReports(eventId);
    }).map(
            (InventoryReportResponseDto response) => inventoryReportResponseDtoMapper.fromDto(response)
    );
  }

  Future<Result<UserBehaviorReportModel>> getUserBehaviorReports() {
    return callApi(() {
      return reportService.userBehaviorReports();
    }).map(
            (UserBehaviorReportResponseDto response) => userBehaviorReportResponseDtoMapper.fromDto(response)
    );
  }

}