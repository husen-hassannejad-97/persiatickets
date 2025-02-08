// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketResponseDto _$TicketResponseDtoFromJson(Map<String, dynamic> json) =>
    TicketResponseDto(
      eventId: (json['event_id'] as num).toInt(),
      seatId: (json['seat_id'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      status: $enumDecode(_$TicketStatusDtoEnumMap, json['status']),
      id: (json['id'] as num).toInt(),
      orderId: (json['order_id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$TicketResponseDtoToJson(TicketResponseDto instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'seat_id': instance.seatId,
      'price': instance.price,
      'status': _$TicketStatusDtoEnumMap[instance.status]!,
      'id': instance.id,
      'order_id': instance.orderId,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$TicketStatusDtoEnumMap = {
  TicketStatusDto.available: 'available',
  TicketStatusDto.reserved: 'reserved',
  TicketStatusDto.sold: 'sold',
};
