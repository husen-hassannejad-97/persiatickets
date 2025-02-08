import 'dart:math';

import 'package:billit_now/repositories/venue/mappers/venue_response_dto_mapper.dart';
import 'package:injectable/injectable.dart';

import '../../../apps/helper/event_status.dart';
import '../../../services/event/response_dto/event_response_dto.dart';
import '../../base/base_dto_mapper.dart';
import '../models/event_model.dart';
import 'event_category_dto_mapper.dart';

@injectable
class EventResponseDtoMapper implements BaseDtoMapper<EventResponseDto, EventModel> {
  final EventCategoryDtoMapper eventCategoryDtoMapper;
  final VenueResponseDtoMapper venueResponseDtoMapper;
  EventResponseDtoMapper({
    required this.eventCategoryDtoMapper,
    required this.venueResponseDtoMapper,
  });

  @override
  EventResponseDto toDto(EventModel model) {
    return EventResponseDto(
      name: model.name,
      description: model.description,
      startTime: model.startTime.toIso8601String(),
      endTime: model.endTime.toIso8601String(),
      venueId: model.venueId,
      category: eventCategoryDtoMapper.toDto(model.category),
      seatMap: model.seatMap,
      imageUrl: model.imageKey,
      id: model.id,
      createdAt: model.createdAt.toIso8601String(),
      updatedAt: model.updatedAt.toIso8601String(),
      venue: venueResponseDtoMapper.toDto(model.venue),
      startingPrice: model.startingPrice,
    );
  }

  @override
  EventModel fromDto(EventResponseDto dto) {
    return EventModel(
      name: dto.name,
      description: dto.description,
      startTime: DateTime.parse(dto.startTime),
      endTime: DateTime.parse(dto.endTime),
      venueId: dto.venueId,
      category: eventCategoryDtoMapper.fromDto(dto.category),
      seatMap: dto.seatMap ?? Map<String, dynamic>(),
      imageKey: dto.imageUrl ?? "",
      id: dto.id,
      createdAt: DateTime.parse(dto.createdAt),
      updatedAt: DateTime.parse(dto.updatedAt),
      venue: venueResponseDtoMapper.fromDto(dto.venue),
      startingPrice: dto.startingPrice ?? 0,
      status: EventStatus.values[Random().nextInt(EventStatus.values.length)],
    );
  }
}