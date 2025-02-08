import 'package:billit_now/services/base/base_service.dart';
import 'package:billit_now/services/order/response_dto/order_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'order_service.g.dart';

@RestApi()
@singleton
abstract class OrderService extends BaseService {

  @factoryMethod
  factory OrderService(Dio dio) = _OrderService;

  @GET('orders')
  Future<List<OrderResponseDto>> orders();

  @GET('orders/{order_id}')
  Future<OrderResponseDto> order(@Path("order_id") String orderId);

  @DELETE('orders/{order_id}')
  Future<OrderResponseDto> cancelOrder(@Path("order_id") String orderId);

}