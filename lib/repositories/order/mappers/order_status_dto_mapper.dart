import 'package:billit_now/services/order/response_dto/order_response_dto.dart';
import 'package:injectable/injectable.dart';

import '../../base/base_dto_mapper.dart';
import '../models/order_status_model.dart';

@injectable
class OrderStatusDtoMapper implements BaseDtoMapper<OrderStatusDto, OrderStatusModel> {
  @override
  OrderStatusDto toDto(OrderStatusModel model) {
    switch (model) {
      case OrderStatusModel.pending:
        return OrderStatusDto.pending;
      case OrderStatusModel.completed:
        return OrderStatusDto.completed;
      case OrderStatusModel.cancelled:
        return OrderStatusDto.cancelled;
    }
  }

  @override
  OrderStatusModel fromDto(OrderStatusDto dto) {
    switch (dto) {
      case OrderStatusDto.pending:
        return OrderStatusModel.pending;
      case OrderStatusDto.completed:
        return OrderStatusModel.completed;
      case OrderStatusDto.cancelled:
        return OrderStatusModel.cancelled;
    }
  }
}