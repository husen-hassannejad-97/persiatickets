// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_seat_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateSeatDto _$CreateSeatDtoFromJson(Map<String, dynamic> json) =>
    CreateSeatDto(
      venueId: (json['venue_id'] as num).toInt(),
      seatNumber: json['seat_number'] as String,
      rowNumber: json['row_number'] as String,
      seatType: json['seat_type'] as String,
    );

Map<String, dynamic> _$CreateSeatDtoToJson(CreateSeatDto instance) =>
    <String, dynamic>{
      'venue_id': instance.venueId,
      'seat_number': instance.seatNumber,
      'row_number': instance.rowNumber,
      'seat_type': instance.seatType,
    };
