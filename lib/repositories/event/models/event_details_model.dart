import 'package:billit_now/repositories/base/base_model.dart';
import 'package:billit_now/repositories/event/models/programs_model.dart';
import 'package:billit_now/repositories/event/models/similar_events_model.dart';
import 'package:billit_now/repositories/event/models/venue_facilities_model.dart';
import 'package:billit_now/repositories/event/models/venue_guidelines_model.dart';
import 'package:billit_now/repositories/event/models/venue_location_model.dart';
import 'package:billit_now/repositories/event/models/what_attendees_say_model.dart';
import 'package:billit_now/repositories/event/models/why_persia_tickets_model.dart';

import '../../../templates/events/event_page/event_details_fake_data_generator.dart';
import 'about_artist_model.dart';
import 'about_organizer_model.dart';
import 'cancellation_policy_model.dart';
import 'event_ad_banner_model.dart';
import 'explore_pricing_model.dart';
import 'info_faq_model.dart';
import 'organizer_banner_model.dart';

class EventDetailsModel implements BaseModel {
  final List<WhyPersiaTicketsModel> whyList;
  final List<ProgramsModel> programs;
  final AboutArtistModel? aboutArtistModel;
  final VenueFacilitiesModel venueFacilitiesModel;
  final VenueGuidelinesModel venueGuidelinesModel;
  final WhatAttendeesSayModel whatAttendeesSayModel;
  final VenueLocationModel venueLocationModel;
  final AboutOrganizerModel aboutOrganizerModel;
  final InfoFaqModel infoFaqModel;
  final ExplorePricingModel explorePricingModel;
  final EventAdBannerModel eventAdBannerModel;
  final List<SimilarEventsModel> similarEventsModel;
  final OrganizerBannerModel organizerBannerModel;
  EventDetailsModel({
    required this.whyList,
    required this.programs,
    required this.aboutArtistModel,
    required this.venueFacilitiesModel,
    required this.venueGuidelinesModel,
    required this.whatAttendeesSayModel,
    required this.venueLocationModel,
    required this.aboutOrganizerModel,
    required this.infoFaqModel,
    required this.explorePricingModel,
    required this.eventAdBannerModel,
    required this.similarEventsModel,
    required this.organizerBannerModel,
  });
}

EventDetailsModel fakeEventDetailsModel() => EventDetailsModel(
    whyList: fWhysList,
    programs: fPrograms,
    aboutArtistModel: fAboutArtistModel,
    venueFacilitiesModel: fVenueFacilitiesModel,
    venueGuidelinesModel: fVenueGuidelinesModel,
    aboutOrganizerModel: fAboutOrganizerModel,
    eventAdBannerModel: fEventAdBannerModel,
    explorePricingModel: fExplorePricingModel,
    infoFaqModel: fInfoFaqModel,
    organizerBannerModel: fOrganizerBannerModel,
    similarEventsModel: fSimilarEventsModel,
    venueLocationModel: fVenueLocationModel,
    whatAttendeesSayModel: fWhatAttendeesSayModel);
