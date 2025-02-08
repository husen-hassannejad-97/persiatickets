import 'package:billit_now/repositories/base/base_repository.dart';
import 'package:billit_now/repositories/order/mappers/order_response_dto_mapper.dart';
import 'package:billit_now/repositories/order/models/order_model.dart';
import 'package:billit_now/services/order/order_service.dart';
import 'package:billit_now/services/order/response_dto/order_response_dto.dart';
import 'package:injectable/injectable.dart';

import '../shared/result.dart';

@singleton
class OrderRepository extends BaseRepository {

  final OrderService orderService;
  final OrderResponseDtoMapper orderResponseDtoMapper;
  OrderRepository({
    required this.orderService,
    required this.orderResponseDtoMapper,
  });

  Future<Result<List<OrderModel>>> getOrders() {
    return callApi(() {
      return orderService.orders();
    }).map(
        (List<OrderResponseDto> data) => data.map(
            (OrderResponseDto item) => orderResponseDtoMapper.fromDto(item)
        ).toList()
    );
  }

  Future<Result<OrderModel>> getOrder(String orderId) {
    return callApi(() {
      return orderService.order(orderId);
    }).map(
            (OrderResponseDto item) => orderResponseDtoMapper.fromDto(item)
    );
  }

  Future<Result<OrderModel>> cancelOrder(String orderId) {
    return callApi(() {
      return orderService.cancelOrder(orderId);
    }).map(
            (OrderResponseDto item) => orderResponseDtoMapper.fromDto(item)
    );
  }
}