// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_details_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDetailsResponseDto _$EventDetailsResponseDtoFromJson(
        Map<String, dynamic> json) =>
    EventDetailsResponseDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      title: json['title'] as String?,
      description: json['description'] as String?,
      category: $enumDecode(_$EventCategoryDtoEnumMap, json['category']),
      venueId: (json['venue_id'] as num).toInt(),
      organizerId: (json['organizer_id'] as num?)?.toInt(),
      sponsorIds: (json['sponsor_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: json['end_time'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      venue: VenueResponseDto.fromJson(json['venue'] as Map<String, dynamic>),
      imageUrl: json['image_url'] as String?,
      programs: (json['programs'] as List<dynamic>?)
          ?.map((e) =>
              EventProgramResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      eventArtist: json['event_artist'] == null
          ? null
          : EventArtistResponseDto.fromJson(
              json['event_artist'] as Map<String, dynamic>),
      eventVenueFacilities: (json['event_venue_facilities'] as List<dynamic>)
          .map((e) =>
              EventVenueFacilityResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      eventSpecificAmenities:
          (json['event_specific_amenities'] as List<dynamic>)
              .map((e) => EventSpecificAmenityResponseDto.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
      eventGuidelines: (json['event_guidelines'] as List<dynamic>)
          .map((e) =>
              EventGuidelineResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      eventFaqs: (json['event_faqs'] as List<dynamic>?)
          ?.map((e) => EventFaqResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      sponsors: (json['sponsors'] as List<dynamic>?)
          ?.map((e) => SponsorResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      musics: (json['musics'] as List<dynamic>?)
          ?.map((e) =>
              EventDetailsMusicResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      organizer: json['organizer'] == null
          ? null
          : OrganizerResponseDto.fromJson(
              json['organizer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventDetailsResponseDtoToJson(
        EventDetailsResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'description': instance.description,
      'category': _$EventCategoryDtoEnumMap[instance.category]!,
      'venue_id': instance.venueId,
      'organizer_id': instance.organizerId,
      'sponsor_ids': instance.sponsorIds,
      'start_time': instance.startTime.toIso8601String(),
      'end_time': instance.endTime,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'image_url': instance.imageUrl,
      'programs': instance.programs,
      'venue': instance.venue,
      'event_artist': instance.eventArtist,
      'event_venue_facilities': instance.eventVenueFacilities,
      'event_specific_amenities': instance.eventSpecificAmenities,
      'event_guidelines': instance.eventGuidelines,
      'musics': instance.musics,
      'event_faqs': instance.eventFaqs,
      'sponsors': instance.sponsors,
      'organizer': instance.organizer,
    };

const _$EventCategoryDtoEnumMap = {
  EventCategoryDto.theater: 'theater',
  EventCategoryDto.concert: 'concert',
  EventCategoryDto.cinema: 'cinema',
};
