import 'package:billit_now/services/venue/response_dto/venue_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';
import '../dto/event_category_dto.dart';

part 'event_response_dto.g.dart';

@JsonSerializable()
class EventResponseDto implements BaseDto {
  final String name;
  final String description;
  @JsonKey(name: 'start_time')
  final String startTime;
  @JsonKey(name: 'end_time')
  final String endTime;
  @JsonKey(name: 'venue_id')
  final int venueId;
  final EventCategoryDto category;
  @JsonKey(name: 'seat_map')
  final Map<String, dynamic>? seatMap;
  final int id;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  final VenueResponseDto venue;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: "starting_price")
  final double? startingPrice;

  EventResponseDto({
    required this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.venueId,
    required this.category,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.venue,
    required this.startingPrice,
    this.imageUrl,
    this.seatMap,
  });

  factory EventResponseDto.fromJson(Map<String, dynamic> json) => _$EventResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EventResponseDtoToJson(this);
}