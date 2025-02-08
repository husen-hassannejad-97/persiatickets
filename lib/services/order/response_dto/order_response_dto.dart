import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_response_dto.g.dart';

@JsonEnum(alwaysCreate: true)
enum OrderStatusDto implements BaseDto { pending, completed, cancelled }

@JsonSerializable()
class OrderResponseDto implements BaseDto {
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'total_amount')
  final int totalAmount;
  final OrderStatusDto status;
  final int id;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  final List<int> tickets;

  OrderResponseDto({
    required this.userId,
    required this.totalAmount,
    required this.status,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.tickets,
  });

  @factoryMethod
  factory OrderResponseDto.fromJson(Map<String, dynamic> json) => _$OrderResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseDtoToJson(this);
}