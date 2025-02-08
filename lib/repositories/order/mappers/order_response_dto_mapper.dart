import 'package:billit_now/repositories/order/mappers/order_status_dto_mapper.dart';
import 'package:injectable/injectable.dart';

import '../../../services/order/response_dto/order_response_dto.dart';
import '../../base/base_dto_mapper.dart';
import '../models/order_model.dart';

@injectable
class OrderResponseDtoMapper implements BaseDtoMapper<OrderResponseDto, OrderModel> {
  final OrderStatusDtoMapper orderStatusDtoMapper;
  const OrderResponseDtoMapper({
    required this.orderStatusDtoMapper,
  });

  @override
  OrderResponseDto toDto(OrderModel model) {
    return OrderResponseDto(
      userId: model.userId,
      totalAmount: model.totalAmount,
      status: orderStatusDtoMapper.toDto(model.status),
      id: model.id,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      tickets: model.tickets,
    );
  }

  @override
  OrderModel fromDto(OrderResponseDto dto) {
    return OrderModel(
      userId: dto.userId,
      totalAmount: dto.totalAmount,
      status: orderStatusDtoMapper.fromDto(dto.status),
      id: dto.id,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      tickets: dto.tickets,
    );
  }
}