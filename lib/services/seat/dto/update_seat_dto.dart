import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_seat_dto.g.dart';

@JsonSerializable()
class UpdateSeatDto implements BaseDto {
  @JsonKey(name: 'seat_number')
  final String seatNumber;
  @JsonKey(name: 'row_number')
  final String rowNumber;
  @JsonKey(name: 'seat_type')
  final String seatType;

  UpdateSeatDto({
    required this.seatNumber,
    required this.rowNumber,
    required this.seatType,
  });

  @factoryMethod
  factory UpdateSeatDto.fromJson(Map<String, dynamic> json) => _$UpdateSeatDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateSeatDtoToJson(this);
}