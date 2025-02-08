// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_report_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryReportResponseDto _$InventoryReportResponseDtoFromJson(
        Map<String, dynamic> json) =>
    InventoryReportResponseDto(
      eventId: (json['event_id'] as num).toInt(),
      eventName: json['event_name'] as String,
      totalTicketsAvailable: (json['total_tickets_available'] as num).toInt(),
      totalTicketsSold: (json['total_tickets_sold'] as num).toInt(),
      totalTicketsReserved: (json['total_tickets_reserved'] as num).toInt(),
      reportGeneratedAt: DateTime.parse(json['report_generated_at'] as String),
    );

Map<String, dynamic> _$InventoryReportResponseDtoToJson(
        InventoryReportResponseDto instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'event_name': instance.eventName,
      'total_tickets_available': instance.totalTicketsAvailable,
      'total_tickets_sold': instance.totalTicketsSold,
      'total_tickets_reserved': instance.totalTicketsReserved,
      'report_generated_at': instance.reportGeneratedAt.toIso8601String(),
    };
