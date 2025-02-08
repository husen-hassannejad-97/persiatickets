import 'package:billit_now/services/base/base_dto.dart';
import 'package:billit_now/services/ticket/response_dto/ticket_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'purchase_tickets_response_dto.g.dart';

@JsonEnum(alwaysCreate: true)
enum PurchaseStatusDto implements BaseDto { pending, completed, cancelled }

@JsonSerializable()
class PurchaseTicketsResponseDto implements BaseDto {
  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'total_amount')
  final int totalAmount;

  final PurchaseStatusDto status;
  final int id;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  final List<TicketResponseDto> tickets;

  PurchaseTicketsResponseDto({
    required this.userId,
    required this.totalAmount,
    required this.status,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.tickets,
  });

  @factoryMethod
  factory PurchaseTicketsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PurchaseTicketsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseTicketsResponseDtoToJson(this);
}