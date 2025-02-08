import 'package:billit_now/apps/event_data.dart';
import 'package:billit_now/apps/helper/header_actions.dart';
import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/component/footer.dart';
import 'package:billit_now/component/header.dart';
import 'package:billit_now/component/nav_drawer.dart';
import 'package:billit_now/features/base/base_bloc.dart';
import 'package:billit_now/features/base/base_bloc_event.dart';
import 'package:billit_now/features/base/base_bloc_state.dart';
import 'package:billit_now/features/base/base_bloc_stateful_widget.dart';
import 'package:billit_now/features/base/base_stateful_page.dart';
import 'package:billit_now/repositories/event/event_repository.dart';
import 'package:billit_now/repositories/event/models/event_details_model.dart';
import 'package:billit_now/repositories/shared/errors.dart';
import 'package:billit_now/templates/events/event_page/event_details_fake_data_generator.dart';
import 'package:billit_now/templates/events/event_page/hero_contents.dart';
import 'package:billit_now/templates/events/event_page/programs.dart';
import 'package:billit_now/templates/events/event_page/similar_events.dart';
import 'package:billit_now/templates/events/event_page/venue_facilities.dart';
import 'package:billit_now/templates/events/event_page/venue_guidLines.dart';
import 'package:billit_now/templates/events/event_page/venue_location.dart';
import 'package:billit_now/templates/events/event_page/why_persia_tickets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../repositories/shared/result.dart';
import 'about_artist.dart';
import 'about_organizer.dart';
import 'event_banner_ad.dart';
import 'explore_pricing.dart';
import 'info_faq.dart';
import 'organizer_banner.dart';

class EventDetailsEvent extends BaseBlocEvent{}
class EventDetailsFetchData extends EventDetailsEvent{
  final String id;
  EventDetailsFetchData({required this.id});
}

class EventDetailsPage extends BaseStatefulPage {
  const EventDetailsPage({super.key});

  @override
  State<StatefulWidget> createState() => _EventDetailsPageState();

}

class _EventDetailsPageState extends BasePageState<EventDetailsPage> {

  EventData? _eventData;

  @override
  void initState() {
    super.initState();
    _loadEventData();
  }

  void _loadEventData() async {
    final eventData = await EventData.retrieveFromStorage();
    setState(() {
      _eventData = eventData;
    });
  }

  @override
  Widget body(BuildContext context) {
    if(_eventData != null) {
      return EventDetails(data: _eventData!);
    } else {
      return Container();
    }
  }

}

@singleton
class EventDetailsBloc extends BaseBloc<EventDetailsEvent, BaseBlocState> {

  final EventRepository eventRepo;

  EventDetailsBloc(this.eventRepo) {
    on<EventDetailsFetchData>((event, emit) async {
      try {
        emit(StateLoading());
        final result = await eventRepo.getEventDetails(event.id);
        if (result is Success<EventDetailsModel>) {
          emit(StateSuccessWithResult<EventDetailsModel>(result: result.data));
        } else if (result is Error<EventDetailsModel>) {
          emit(StateError(error: result.error));
        } else {
          throw UnexpectedError(message: 'Unhandled Result type');
        }
      } catch (e, stackTrace) {
        emit(StateError(
            error: UnexpectedError(
                message: "An unexpected error happened!")));
        if (kDebugMode) {
          print('Error in ResultToStateConverter: $e\n$stackTrace');
        }
      }
    });
  }

  @override
  bool eventToDebounce(BaseBlocEvent currentEvent) => false;

}

class EventDetails extends BaseBlocStatefulWidget {

  final EventData data;
  const EventDetails({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _EventDetailsState();
}

class _EventDetailsState extends BaseBlocStateWidget<EventDetails, EventDetailsBloc> {

  final ScrollController _scrollController = ScrollController();

  final List<Map<String, String>> footerBtns = [
    {'title': 'Events', 'link': ''},
    {'title': 'Artists', 'link': ''},
    {'title': 'Venues', 'link': ''},
    {'title': 'Help center', 'link': ''},
    {'title': 'About', 'link': ''},
    {'title': 'Contacts', 'link': ''},
    {'title': 'Privacy policy', 'link': ''}
  ];
  final double maxWidth = 1366;

  @override
  bool get wantKeepAlive => true;

  @override
  bool get visibilityDetection => true;

  @override
  Key get visibilityKey => Key("event details");

  @override
  void onVisible(BuildContext context) {
    super.onVisible(context);
    addEvent(context, EventDetailsFetchData(id: widget.data.id.toString()));
  }

  @override
  Widget body(BuildContext context, BaseBlocState state) {
    if(state is StateInitial) {
      return _stateInitial();
    } else if(state is StateLoading) {
      return _stateLoading();
    } else if(state is StateError) {
      return _stateError();
    } else if(state is StateSuccessWithResult<EventDetailsModel>){
      return _stateSuccess(context, state.result);
    } else {
      return _stateEmpty();
    }
  }

  Widget _stateSuccess(BuildContext context, EventDetailsModel eventDetailsModel) {
    return Scaffold(
      endDrawer: context.isSmallTabletOrLess ? const NavDrawer() : null,
      backgroundColor: Theme.of(context).appColors.bgPrimary,
      body: SafeArea(
          child: Stack(
        children: [
          ListView(
            controller: _scrollController,
            children: [
              Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: HeroContents(
                      eventImage: widget.data.eventImage,
                      organizer: 'Alireza Zolghadri', // TODO
                      title: widget.data.title,
                      subTitle: widget.data.subTitle,
                      startDate: widget.data.startDate,
                      endDate: widget.data.endDate,
                      location: widget.data.location
                  ),
                ),
              ),
              Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).appColors.mallard100.withOpacity(0.1),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.5],
                    ),
                  ),
                  child: SizedBox(
                      width: context.logicalWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Main Content
                          Expanded(
                            child: Container(
                              // width: ,//context.logicalWidth * 0.7,
                              padding: EdgeInsets.only(top: 40, right: 32, left: 48),
                              child: Column(
                                children: [
                                  fWhysList.isEmpty ? Container() :
                                  Column(
                                    children: [
                                      WhyPersiaTickets(whysList: eventDetailsModel.whyList),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                                        child: Divider(
                                          color: Theme.of(context).appColors.borderPrimary,
                                          thickness: 1.0,
                                        ),
                                      )
                                    ],
                                  ),
                                  // Programs
                                  eventDetailsModel.programs.isNotEmpty ?
                                  Programs(
                                    data: eventDetailsModel.programs,
                                    callback: (programsModel) {

                                    },
                                  )
                                  : Container(), // About
                                  eventDetailsModel.programs.isNotEmpty ? Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                                    child: Divider(
                                      color: Theme.of(context).appColors.borderPrimary,
                                      thickness: 1.0,
                                    ),
                                  ) : Container(),
                                  // About
                                  eventDetailsModel.aboutArtistModel != null ?
                                  AboutArtist(data: eventDetailsModel.aboutArtistModel!)
                                  :
                                  Container(),
                                  eventDetailsModel.aboutArtistModel != null ? Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                                    child: Divider(
                                      color: Theme.of(context).appColors.borderPrimary,
                                      thickness: 1.0,
                                    ),
                                  ) : Container(),
                                  // Venue Facilities
                                  VenueFacilities(data: eventDetailsModel.venueFacilitiesModel),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                                    child: Divider(
                                      color: Theme.of(context).appColors.borderPrimary,
                                      thickness: 1.0,
                                    ),
                                  ),
                                  // GuideLines
                                  eventDetailsModel.venueGuidelinesModel.guides.isNotEmpty ?
                                  VenueGuidelines(data: eventDetailsModel.venueGuidelinesModel)
                                  : Container(),
                                  eventDetailsModel.venueGuidelinesModel.guides.isNotEmpty ? Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                                    child: Divider(
                                      color: Theme.of(context).appColors.borderPrimary,
                                      thickness: 1.0,
                                    ),
                                  ) : Container(),
                                  // What Attendees Are Saying
                                  // WhatAttendeesSay(
                                  //   data: eventDetailsModel.whatAttendeesSayModel,
                                  //   writeReview: () {
                                  //     // TODO
                                  //   },
                                  //   showAllReviews: () {
                                  //     // TODO
                                  //   },
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(vertical: 20.0),
                                  //   child: Divider(
                                  //     color: Theme.of(context).appColors.borderPrimary,
                                  //     thickness: 1.0,
                                  //   ),
                                  // ),
                                  // Location
                                  VenueLocation(data: eventDetailsModel.venueLocationModel,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                                    child: Divider(
                                      color: Theme.of(context).appColors.borderPrimary,
                                      thickness: 1.0,
                                    ),
                                  ),
                                  // About Organizer
                                  AboutOrganizer(data: eventDetailsModel.aboutOrganizerModel),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                                    child: Divider(
                                      color: Theme.of(context).appColors.borderPrimary,
                                      thickness: 1.0,
                                    ),
                                  ),
                                  // Info FAQ
                                  eventDetailsModel.infoFaqModel.faqs.isNotEmpty ?
                                  InfoFAQ(data: eventDetailsModel.infoFaqModel)
                                  : Container(),
                                  eventDetailsModel.infoFaqModel.faqs.isNotEmpty ? Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                                    child: Divider(
                                      color: Theme.of(context).appColors.borderPrimary,
                                      thickness: 1.0,
                                    ),
                                  ): Container(),
                                  // Explore Pricing
                                  ExplorePricing(data: eventDetailsModel.explorePricingModel),
                                  // Ad Banner
                                  EventAdBanner(data: eventDetailsModel.eventAdBannerModel),
                                  // Similars
                                  SimilarEvents(data: eventDetailsModel.similarEventsModel)
                                ],
                              ),
                            ),
                          ),
                          // Organizer
                          context.isSmallTabletOrLess
                              ? Container()
                              : Container(
                              width: 376,
                              padding: EdgeInsets.only(top: 40, right: 48, left: 16),
                              child: OrganizerBanner(
                                data: eventDetailsModel.organizerBannerModel,
                                reserveTickets: () {
                                  // TODO
                                },
                              ))
                        ],
                      )),
                ),
              ),
              Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Footer(
                    buttons: [
                      {'title': getString("events"), 'link': ''},
                      {'title': getString("artists"), 'link': ''},
                      {'title': getString("venues"), 'link': ''},
                      {'title': getString("help_center"), 'link': ''},
                      {'title': getString("about"), 'link': ''},
                      {'title': getString("contacts"), 'link': ''},
                      {'title': getString("privacy_policy"), 'link': ''}
                    ],
                  ),
                ),
              )
            ],
          ),
          Header(
            scrollController: _scrollController,
            activeAction: HeaderActions.events,
          ),
        ],
      )),
    );
  }

  Widget _stateInitial() {
    return _stateLoading();
  }

  Widget _stateLoading() {
    return Scaffold(
      endDrawer: context.isSmallTabletOrLess ? const NavDrawer() : null,
      backgroundColor: Theme.of(context).appColors.bgPrimary,
      body: SafeArea(
          child: Stack(
        children: [
          ListView(
            controller: ScrollController(),
            children: [
              Center(
                  child: Container(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: HeroContents(
                    eventImage: widget.data.eventImage,
                    organizer: 'Alireza Zolghadri', // TODO
                    title: widget.data.title,
                    subTitle: widget.data.subTitle,
                    startDate: widget.data.startDate,
                    endDate: widget.data.endDate,
                    location: widget.data.location
                ),
              )),
            ],
          ),
          Header(
            scrollController: _scrollController,
            activeAction: HeaderActions.events,
          )
        ],
      )),
    );
  }

  Widget _stateError() {
    return _stateLoading();
  }

  Widget _stateEmpty() {
    return Container();
  }

  @override
  void consumeState(BuildContext context, BaseBlocState state) {
    // if(state is StateInitial) {
    //   addEvent(context, EventDetailsFetchData());
    // }
  }
}
