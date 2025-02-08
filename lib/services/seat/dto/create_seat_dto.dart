import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_seat_dto.g.dart';

@JsonSerializable()
class CreateSeatDto implements BaseDto {
  @JsonKey(name: 'venue_id')
  final int venueId;
  @JsonKey(name: 'seat_number')
  final String seatNumber;
  @JsonKey(name: 'row_number')
  final String rowNumber;
  @JsonKey(name: 'seat_type')
  final String seatType;

  CreateSeatDto({
    required this.venueId,
    required this.seatNumber,
    required this.rowNumber,
    required this.seatType,
  });

  @factoryMethod
  factory CreateSeatDto.fromJson(Map<String, dynamic> json) => _$CreateSeatDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSeatDtoToJson(this);
}