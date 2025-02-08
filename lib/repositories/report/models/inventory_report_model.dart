import '../../base/base_model.dart';

class InventoryReportModel implements BaseModel {
  final int eventId;
  final String eventName;
  final int totalTicketsAvailable;
  final int totalTicketsSold;
  final int totalTicketsReserved;
  final DateTime reportGeneratedAt;

  InventoryReportModel({
    required this.eventId,
    required this.eventName,
    required this.totalTicketsAvailable,
    required this.totalTicketsSold,
    required this.totalTicketsReserved,
    required this.reportGeneratedAt,
  });
}