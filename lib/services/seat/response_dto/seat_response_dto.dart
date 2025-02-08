import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seat_response_dto.g.dart';

@JsonSerializable()
class SeatResponseDto implements BaseDto {
  @JsonKey(name: 'venue_id')
  final int venueId;
  @JsonKey(name: 'seat_number')
  final String seatNumber;
  @JsonKey(name: 'row_number')
  final String rowNumber;
  @JsonKey(name: 'seat_type')
  final String seatType;
  final int id;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  SeatResponseDto({
    required this.venueId,
    required this.seatNumber,
    required this.rowNumber,
    required this.seatType,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  @factoryMethod
  factory SeatResponseDto.fromJson(Map<String, dynamic> json) => _$SeatResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SeatResponseDtoToJson(this);
}