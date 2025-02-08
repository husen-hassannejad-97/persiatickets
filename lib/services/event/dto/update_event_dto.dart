import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';

part 'update_event_dto.g.dart';

@JsonSerializable()
class UpdateEventDto implements BaseDto {
  final String name;
  final String description;
  @JsonKey(name: 'start_time')
  final DateTime startTime;
  @JsonKey(name: 'end_time')
  final DateTime endTime;
  final String category;
  @JsonKey(name: 'seat_map')
  final Map<String, dynamic> seatMap;

  UpdateEventDto({
    required this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.category,
    required this.seatMap,
  });

  @factoryMethod
  factory UpdateEventDto.fromJson(Map<String, dynamic> json) => _$UpdateEventDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateEventDtoToJson(this);
}