// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_tickets_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseTicketsDto _$PurchaseTicketsDtoFromJson(Map<String, dynamic> json) =>
    PurchaseTicketsDto(
      ticketIds: (json['ticketIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$PurchaseTicketsDtoToJson(PurchaseTicketsDto instance) =>
    <String, dynamic>{
      'ticketIds': instance.ticketIds,
    };
