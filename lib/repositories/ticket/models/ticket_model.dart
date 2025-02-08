import '../../base/base_model.dart';
import 'ticket_status_model.dart';

class TicketModel implements BaseModel {
  final int eventId;
  final int seatId;
  final int price;
  final TicketStatusModel status;
  final int id;
  final int orderId;
  final DateTime createdAt;
  final DateTime updatedAt;

  TicketModel({
    required this.eventId,
    required this.seatId,
    required this.price,
    required this.status,
    required this.id,
    required this.orderId,
    required this.createdAt,
    required this.updatedAt,
  });
}