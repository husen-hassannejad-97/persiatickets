import 'package:billit_now/services/base/base_service.dart';
import 'package:billit_now/services/report/response_dto/inventory_report_response_dto.dart';
import 'package:billit_now/services/report/response_dto/sale_report_response_dto.dart';
import 'package:billit_now/services/report/response_dto/user_behavior_report_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'report_service.g.dart';

@RestApi()
@singleton
abstract class ReportService extends BaseService {

  @factoryMethod
  factory ReportService(Dio dio) = _ReportService;

  @GET('reports/sales/{event_id}')
  Future<SaleReportResponseDto> saleReports(@Path("event_id") String eventId);

  @GET('reports/inventory/{event_id}')
  Future<InventoryReportResponseDto> inventoryReports(@Path("event_id") String eventId);

  @GET('reports/user-behavior')
  Future<UserBehaviorReportResponseDto> userBehaviorReports();

}