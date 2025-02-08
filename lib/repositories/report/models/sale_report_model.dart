import '../../base/base_model.dart';

class SaleReportModel implements BaseModel {
  final int eventId;
  final String eventName;
  final int totalTicketsSold;
  final int totalRevenue;
  final DateTime reportGeneratedAt;

  SaleReportModel({
    required this.eventId,
    required this.eventName,
    required this.totalTicketsSold,
    required this.totalRevenue,
    required this.reportGeneratedAt,
  });
}