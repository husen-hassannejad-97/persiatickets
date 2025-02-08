import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket_response_dto.g.dart';

@JsonEnum(alwaysCreate: true)
enum TicketStatusDto implements BaseDto { available, reserved, sold }

@JsonSerializable()
class TicketResponseDto implements BaseDto {
  @JsonKey(name: 'event_id')
  final int eventId;
  @JsonKey(name: 'seat_id')
  final int seatId;
  final int price;
  final TicketStatusDto status;
  final int id;
  @JsonKey(name: 'order_id')
  final int orderId;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  TicketResponseDto({
    required this.eventId,
    required this.seatId,
    required this.price,
    required this.status,
    required this.id,
    required this.orderId,
    required this.createdAt,
    required this.updatedAt,
  });

  @factoryMethod
  factory TicketResponseDto.fromJson(Map<String, dynamic> json) => _$TicketResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TicketResponseDtoToJson(this);
}