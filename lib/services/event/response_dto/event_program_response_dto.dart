import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_program_response_dto.g.dart';

@JsonSerializable()
class EventProgramResponseDto implements BaseDto {
  final int id;
  @JsonKey(name: 'event_id')
  final int eventId;
  final String name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'start_datetime')
  final DateTime startDateTime;
  @JsonKey(name: 'end_datetime')
  final DateTime endDateTime;
  @JsonKey(name: 'tickets_available')
  final int ticketsAvailable;
  @JsonKey(name: 'ticket_sale_start')
  final DateTime ticketSaleStart;
  @JsonKey(name: 'min_ticket_price')
  final int minTicketPrice;
  @JsonKey(name: 'max_ticket_price')
  final int maxTicketPrice;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  EventProgramResponseDto({
    required this.id,
    required this.eventId,
    required this.name,
    required this.description,
    required this.startDateTime,
    required this.endDateTime,
    required this.ticketsAvailable,
    required this.ticketSaleStart,
    required this.minTicketPrice,
    required this.maxTicketPrice,
    required this.createdAt,
    required this.updatedAt
  });

  @factoryMethod
  factory EventProgramResponseDto.fromJson(Map<String, dynamic> json) => _$EventProgramResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EventProgramResponseDtoToJson(this);
}