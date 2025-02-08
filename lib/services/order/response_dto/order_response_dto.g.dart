// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponseDto _$OrderResponseDtoFromJson(Map<String, dynamic> json) =>
    OrderResponseDto(
      userId: (json['user_id'] as num).toInt(),
      totalAmount: (json['total_amount'] as num).toInt(),
      status: $enumDecode(_$OrderStatusDtoEnumMap, json['status']),
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      tickets: (json['tickets'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$OrderResponseDtoToJson(OrderResponseDto instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'total_amount': instance.totalAmount,
      'status': _$OrderStatusDtoEnumMap[instance.status]!,
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'tickets': instance.tickets,
    };

const _$OrderStatusDtoEnumMap = {
  OrderStatusDto.pending: 'pending',
  OrderStatusDto.completed: 'completed',
  OrderStatusDto.cancelled: 'cancelled',
};
