import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/repositories/event/models/about_artist_model.dart';
import 'package:billit_now/repositories/event/models/about_organizer_model.dart';
import 'package:billit_now/repositories/event/models/event_details_model.dart';
import 'package:billit_now/repositories/event/models/info_faq_model.dart';
import 'package:billit_now/repositories/event/models/organizer_banner_model.dart';
import 'package:billit_now/repositories/event/models/venue_facilities_model.dart';
import 'package:billit_now/repositories/event/models/venue_guidelines_model.dart';
import 'package:billit_now/services/event/response_dto/event_details_response_dto.dart';
import 'package:billit_now/services/event/response_dto/event_guideline_response_dto.dart';
import 'package:billit_now/services/event/response_dto/event_program_response_dto.dart';
import 'package:billit_now/services/event/response_dto/event_venue_facility_response_dto.dart';
import 'package:billit_now/services/shared_response_dto/sponsor_response_dto.dart';
import 'package:billit_now/templates/events/event_page/event_details_fake_data_generator.dart';
import 'package:injectable/injectable.dart';

import '../../../services/event/response_dto/event_faq_response_dto.dart';
import '../../../services/event/response_dto/event_venue_facility_item_response_dto.dart';
import '../../shared/mappers/organizer_response_dto_mapper.dart';
import 'event_artist_response_dto_mapper.dart';
import 'event_faq_response_dto_mapper.dart';
import 'event_guideline_response_dto_mapper.dart';
import 'event_program_response_dto_mapper.dart';
import 'event_venue_facility_item_response_dto_mapper.dart';
import 'event_venue_response_venue_location_dto_mapper.dart';

@injectable
class EventDetailsResponseDtoMapper extends BaseDtoMapper<EventDetailsResponseDto, EventDetailsModel> {
  final EventProgramResponseDtoMapper eventProgramResponseDtoMapper;
  final EventArtistResponseDtoMapper eventArtistResponseDtoMapper;
  final EventVenueFacilityItemResponseDtoMapper eventVenueFacilityItemResponseDtoMapper;
  final EventGuidelineResponseDtoMapper eventGuidelineResponseDtoMapper;
  final EventVenueResponseVenueLocationDtoMapper eventVenueResponseVenueLocationDtoMapper;
  final OrganizerResponseDtoMapper organizerResponseDtoMapper;
  final EventFaqResponseDtoMapper eventFaqResponseDtoMapper;
  EventDetailsResponseDtoMapper({
    required this.eventProgramResponseDtoMapper,
    required this.eventArtistResponseDtoMapper,
    required this.eventVenueFacilityItemResponseDtoMapper,
    required this.eventGuidelineResponseDtoMapper,
    required this.eventVenueResponseVenueLocationDtoMapper,
    required this.organizerResponseDtoMapper,
    required this.eventFaqResponseDtoMapper,
  });
  @override
  EventDetailsModel fromDto(EventDetailsResponseDto dto) {
    final AboutArtistModel? aboutArtistModel;
    if(dto.eventArtist == null) {
      aboutArtistModel = null;
    } else {
      aboutArtistModel = eventArtistResponseDtoMapper.fromDto(dto);
    }
    final OrganizerModel organizerModel;
    if(dto.organizerId == null) {
      organizerModel = fAboutOrganizerModel.organizerModel;
    } else {
      organizerModel = organizerResponseDtoMapper.fromDto(dto.organizer!);
    }
    return EventDetailsModel(
        whyList: fWhysList,
        programs: dto.programs?.map(
                (EventProgramResponseDto response) =>
                    eventProgramResponseDtoMapper.fromDto(response)
        ).toList() ?? List.empty(),
        aboutArtistModel: aboutArtistModel,
        venueFacilitiesModel: VenueFacilitiesModel(
            name: dto.venue.name,
            desc: dto.venue.description ?? "",
            facilities: List.generate(dto.eventVenueFacilities.length, (index) {
              return FacilitiesModel(
                title: dto.eventVenueFacilities[index].name,
                facilities: dto.eventVenueFacilities[index].items.map(
                    (EventVenueFacilityItemResponseDto response) =>
                    eventVenueFacilityItemResponseDtoMapper.fromDto(response)
                ).toList()
              );
            })),
        venueGuidelinesModel: VenueGuidelinesModel(
            guides: dto.eventGuidelines
                .map((EventGuidelineResponseDto response) =>
                    eventGuidelineResponseDtoMapper.fromDto(response))
                .toList()
        ),
        whatAttendeesSayModel: fWhatAttendeesSayModel, // TODO Data Missing from Server
        venueLocationModel: eventVenueResponseVenueLocationDtoMapper.fromDto(dto.venue),
        aboutOrganizerModel: AboutOrganizerModel(organizerModel: organizerModel),
        infoFaqModel: InfoFaqModel(
            desc: dto.eventArtist?.fullBio ?? dto.eventArtist?.shortBio ?? "",
            faqs: dto.eventFaqs != null ?
            dto.eventFaqs!.map(
                    (EventFaqResponseDto response) =>
                    eventFaqResponseDtoMapper.fromDto(response)
            ).toList()
                : List.empty()
        ),
        explorePricingModel: fExplorePricingModel,
        eventAdBannerModel: fEventAdBannerModel,
        similarEventsModel: fSimilarEventsModel,
        organizerBannerModel: OrganizerBannerModel(
            title: fOrganizerBannerModel.title,
            location: fOrganizerBannerModel.location,
            date: fOrganizerBannerModel.date,
            role: fOrganizerBannerModel.role,
            sponsors: dto.sponsors != null ?
            dto.sponsors!.map(
                    (SponsorResponseDto response) => response.logoUrl ?? ""
            ).takeWhile((String url) => url.isNotEmpty).toList() :
            List.empty(),
            organizerModel: organizerModel
        )
    );
  }

  @override
  EventDetailsResponseDto toDto(EventDetailsModel model) {
    // TODO: implement toDto
    throw UnimplementedError();
  }

}