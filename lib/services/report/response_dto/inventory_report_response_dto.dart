import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inventory_report_response_dto.g.dart';

@JsonSerializable()
class InventoryReportResponseDto implements BaseDto {
  @JsonKey(name: 'event_id')
  final int eventId;
  @JsonKey(name: 'event_name')
  final String eventName;
  @JsonKey(name: 'total_tickets_available')
  final int totalTicketsAvailable;
  @JsonKey(name: 'total_tickets_sold')
  final int totalTicketsSold;
  @JsonKey(name: 'total_tickets_reserved')
  final int totalTicketsReserved;
  @JsonKey(name: 'report_generated_at')
  final DateTime reportGeneratedAt;

  InventoryReportResponseDto({
    required this.eventId,
    required this.eventName,
    required this.totalTicketsAvailable,
    required this.totalTicketsSold,
    required this.totalTicketsReserved,
    required this.reportGeneratedAt,
  });

  @factoryMethod
  factory InventoryReportResponseDto.fromJson(Map<String, dynamic> json) => _$InventoryReportResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryReportResponseDtoToJson(this);
}