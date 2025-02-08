// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_seat_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateSeatDto _$UpdateSeatDtoFromJson(Map<String, dynamic> json) =>
    UpdateSeatDto(
      seatNumber: json['seat_number'] as String,
      rowNumber: json['row_number'] as String,
      seatType: json['seat_type'] as String,
    );

Map<String, dynamic> _$UpdateSeatDtoToJson(UpdateSeatDto instance) =>
    <String, dynamic>{
      'seat_number': instance.seatNumber,
      'row_number': instance.rowNumber,
      'seat_type': instance.seatType,
    };
