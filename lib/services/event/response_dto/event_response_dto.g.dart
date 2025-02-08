// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventResponseDto _$EventResponseDtoFromJson(Map<String, dynamic> json) =>
    EventResponseDto(
      name: json['name'] as String,
      description: json['description'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      venueId: (json['venue_id'] as num).toInt(),
      category: $enumDecode(_$EventCategoryDtoEnumMap, json['category']),
      id: (json['id'] as num).toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      venue: VenueResponseDto.fromJson(json['venue'] as Map<String, dynamic>),
      startingPrice: (json['starting_price'] as num?)?.toDouble(),
      imageUrl: json['image_url'] as String?,
      seatMap: json['seat_map'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$EventResponseDtoToJson(EventResponseDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'venue_id': instance.venueId,
      'category': _$EventCategoryDtoEnumMap[instance.category]!,
      'seat_map': instance.seatMap,
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'venue': instance.venue,
      'image_url': instance.imageUrl,
      'starting_price': instance.startingPrice,
    };

const _$EventCategoryDtoEnumMap = {
  EventCategoryDto.theater: 'theater',
  EventCategoryDto.concert: 'concert',
  EventCategoryDto.cinema: 'cinema',
};
