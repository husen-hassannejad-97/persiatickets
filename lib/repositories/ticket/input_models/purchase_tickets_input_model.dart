import '../../base/base_model.dart';

class PurchaseTicketsInputModel implements BaseModel {
  final List<int> ticketIds;

  PurchaseTicketsInputModel({
    required this.ticketIds,
  });
}