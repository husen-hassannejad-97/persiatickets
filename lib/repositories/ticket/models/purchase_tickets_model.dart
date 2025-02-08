import 'package:billit_now/repositories/ticket/models/ticket_model.dart';

import '../../base/base_model.dart';
import 'purchase_status_model.dart';

class PurchaseTicketsModel implements BaseModel {
  final int userId;
  final int totalAmount;
  final PurchaseStatusModel status;
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<TicketModel> tickets;

  PurchaseTicketsModel({
    required this.userId,
    required this.totalAmount,
    required this.status,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.tickets,
  });
}