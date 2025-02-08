// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_program_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventProgramResponseDto _$EventProgramResponseDtoFromJson(
        Map<String, dynamic> json) =>
    EventProgramResponseDto(
      id: (json['id'] as num).toInt(),
      eventId: (json['event_id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      startDateTime: DateTime.parse(json['start_datetime'] as String),
      endDateTime: DateTime.parse(json['end_datetime'] as String),
      ticketsAvailable: (json['tickets_available'] as num).toInt(),
      ticketSaleStart: DateTime.parse(json['ticket_sale_start'] as String),
      minTicketPrice: (json['min_ticket_price'] as num).toInt(),
      maxTicketPrice: (json['max_ticket_price'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$EventProgramResponseDtoToJson(
        EventProgramResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'name': instance.name,
      'description': instance.description,
      'start_datetime': instance.startDateTime.toIso8601String(),
      'end_datetime': instance.endDateTime.toIso8601String(),
      'tickets_available': instance.ticketsAvailable,
      'ticket_sale_start': instance.ticketSaleStart.toIso8601String(),
      'min_ticket_price': instance.minTicketPrice,
      'max_ticket_price': instance.maxTicketPrice,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
