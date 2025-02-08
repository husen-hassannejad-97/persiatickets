// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatResponseDto _$SeatResponseDtoFromJson(Map<String, dynamic> json) =>
    SeatResponseDto(
      venueId: (json['venue_id'] as num).toInt(),
      seatNumber: json['seat_number'] as String,
      rowNumber: json['row_number'] as String,
      seatType: json['seat_type'] as String,
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$SeatResponseDtoToJson(SeatResponseDto instance) =>
    <String, dynamic>{
      'venue_id': instance.venueId,
      'seat_number': instance.seatNumber,
      'row_number': instance.rowNumber,
      'seat_type': instance.seatType,
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
