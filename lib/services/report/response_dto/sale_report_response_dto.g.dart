// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_report_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleReportResponseDto _$SaleReportResponseDtoFromJson(
        Map<String, dynamic> json) =>
    SaleReportResponseDto(
      eventId: (json['event_id'] as num).toInt(),
      eventName: json['event_name'] as String,
      totalTicketsSold: (json['total_tickets_sold'] as num).toInt(),
      totalRevenue: (json['total_revenue'] as num).toInt(),
      reportGeneratedAt: DateTime.parse(json['report_generated_at'] as String),
    );

Map<String, dynamic> _$SaleReportResponseDtoToJson(
        SaleReportResponseDto instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'event_name': instance.eventName,
      'total_tickets_sold': instance.totalTicketsSold,
      'total_revenue': instance.totalRevenue,
      'report_generated_at': instance.reportGeneratedAt.toIso8601String(),
    };
