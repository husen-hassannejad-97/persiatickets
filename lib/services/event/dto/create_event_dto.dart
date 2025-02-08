import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';

part 'create_event_dto.g.dart';

@JsonSerializable()
class CreateEventDto implements BaseDto {
  final String name;
  final String description;
  @JsonKey(name: 'start_time')
  final DateTime startTime;
  @JsonKey(name: 'end_time')
  final DateTime endTime;
  @JsonKey(name: 'venue_id')
  final int venueId;
  final String category;
  @JsonKey(name: 'seat_map')
  final Map<String, dynamic> seatMap;

  CreateEventDto({
    required this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.venueId,
    required this.category,
    required this.seatMap,
  });

  @factoryMethod
  factory CreateEventDto.fromJson(Map<String, dynamic> json) => _$CreateEventDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateEventDtoToJson(this);
}