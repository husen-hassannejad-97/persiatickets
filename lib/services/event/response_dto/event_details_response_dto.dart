import 'package:billit_now/services/event/response_dto/event_artist_response_dto.dart';
import 'package:billit_now/services/event/response_dto/event_faq_response_dto.dart';
import 'package:billit_now/services/event/response_dto/event_program_response_dto.dart';
import 'package:billit_now/services/venue/response_dto/venue_response_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../base/base_dto.dart';
import '../../shared_response_dto/organizer_response_dto.dart';
import '../../shared_response_dto/rate_comment_response_dto.dart';
import '../../shared_response_dto/sponsor_response_dto.dart';
import '../dto/event_category_dto.dart';
import 'event_details_music_response_dto.dart';
import 'event_guideline_response_dto.dart';
import 'event_specific_amenity_response_dto.dart';
import 'event_venue_facility_response_dto.dart';

part 'event_details_response_dto.g.dart';

@JsonSerializable()
class EventDetailsResponseDto implements BaseDto {
  final int id;
  final String name;
  final String? title;
  final String? description;
  final EventCategoryDto category;
  @JsonKey(name: 'venue_id')
  final int venueId;
  @JsonKey(name: 'organizer_id')
  final int? organizerId;
  @JsonKey(name: 'sponsor_ids')
  final List<int> sponsorIds;
  @JsonKey(name: 'start_time')
  final DateTime startTime;
  @JsonKey(name: 'end_time')
  final String? endTime;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'programs')
  final List<EventProgramResponseDto>? programs;
  final VenueResponseDto venue;
  @JsonKey(name: 'event_artist')
  final EventArtistResponseDto? eventArtist;
  @JsonKey(name: 'event_venue_facilities')
  final List<EventVenueFacilityResponseDto> eventVenueFacilities;
  @JsonKey(name: 'event_specific_amenities')
  final List<EventSpecificAmenityResponseDto> eventSpecificAmenities;
  @JsonKey(name: 'event_guidelines')
  final List<EventGuidelineResponseDto> eventGuidelines;
  @JsonKey(name: 'musics')
  final List<EventDetailsMusicResponseDto>? musics;
  // @JsonKey(name: 'rate_comments')
  // final List<RateCommentResponseDto> rateComments;
  @JsonKey(name: 'event_faqs')
  final List<EventFaqResponseDto>? eventFaqs;
  final List<SponsorResponseDto>? sponsors;
  final OrganizerResponseDto? organizer;

  EventDetailsResponseDto({
    required this.id,
    required this.name,
    required this.title,
    required this.description,
    required this.category,
    required this.venueId,
    required this.organizerId,
    required this.sponsorIds,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    required this.venue,
    required this.imageUrl,
    required this.programs,
    required this.eventArtist,
    required this.eventVenueFacilities,
    required this.eventSpecificAmenities,
    required this.eventGuidelines,
    required this.eventFaqs,
    required this.sponsors,
    required this.musics,
    required this.organizer,
  });

  factory EventDetailsResponseDto.fromJson(Map<String, dynamic> json) => _$EventDetailsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EventDetailsResponseDtoToJson(this);
}