import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sale_report_response_dto.g.dart';

@JsonSerializable()
class SaleReportResponseDto implements BaseDto{
  @JsonKey(name: 'event_id')
  final int eventId;
  @JsonKey(name: 'event_name')
  final String eventName;
  @JsonKey(name: 'total_tickets_sold')
  final int totalTicketsSold;
  @JsonKey(name: 'total_revenue')
  final int totalRevenue;
  @JsonKey(name: 'report_generated_at')
  final DateTime reportGeneratedAt;

  SaleReportResponseDto({
    required this.eventId,
    required this.eventName,
    required this.totalTicketsSold,
    required this.totalRevenue,
    required this.reportGeneratedAt,
  });

  @factoryMethod
  factory SaleReportResponseDto.fromJson(Map<String, dynamic> json) => _$SaleReportResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SaleReportResponseDtoToJson(this);
}