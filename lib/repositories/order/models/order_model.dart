import '../../base/base_model.dart';
import 'order_status_model.dart';

class OrderModel implements BaseModel {
  final int userId;
  final int totalAmount;
  final OrderStatusModel status;
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<int> tickets;

  OrderModel({
    required this.userId,
    required this.totalAmount,
    required this.status,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.tickets,
  });
}