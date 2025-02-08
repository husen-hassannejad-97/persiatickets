// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_tickets_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseTicketsResponseDto _$PurchaseTicketsResponseDtoFromJson(
        Map<String, dynamic> json) =>
    PurchaseTicketsResponseDto(
      userId: (json['user_id'] as num).toInt(),
      totalAmount: (json['total_amount'] as num).toInt(),
      status: $enumDecode(_$PurchaseStatusDtoEnumMap, json['status']),
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      tickets: (json['tickets'] as List<dynamic>)
          .map((e) => TicketResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PurchaseTicketsResponseDtoToJson(
        PurchaseTicketsResponseDto instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'total_amount': instance.totalAmount,
      'status': _$PurchaseStatusDtoEnumMap[instance.status]!,
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'tickets': instance.tickets,
    };

const _$PurchaseStatusDtoEnumMap = {
  PurchaseStatusDto.pending: 'pending',
  PurchaseStatusDto.completed: 'completed',
  PurchaseStatusDto.cancelled: 'cancelled',
};
