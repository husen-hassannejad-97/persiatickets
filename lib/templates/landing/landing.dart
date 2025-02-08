
import 'package:billit_now/apps/helper/header_actions.dart';
import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/component/empty_modal.dart';
import 'package:billit_now/component/fab_ads.dart';
import 'package:billit_now/component/footer.dart';
import 'package:billit_now/component/header.dart';
import 'package:billit_now/component/nav_drawer.dart';
import 'package:billit_now/features/base/base_bloc.dart';
import 'package:billit_now/features/base/base_bloc_event.dart';
import 'package:billit_now/features/base/base_bloc_state.dart';
import 'package:billit_now/features/base/base_bloc_stateful_widget.dart';
import 'package:billit_now/features/base/base_stateless_page.dart';
import 'package:billit_now/repositories/ad/ad_repository.dart';
import 'package:billit_now/repositories/shared/errors.dart';
import 'package:billit_now/templates/landing/banner_ads.dart';
import 'package:billit_now/templates/landing/concert_hall.dart';
import 'package:billit_now/templates/landing/empty_screen.dart';
import 'package:billit_now/templates/landing/highlight_events.dart';
import 'package:billit_now/templates/landing/latest_concerts.dart';
import 'package:billit_now/templates/landing/latest_theaters.dart';
import 'package:billit_now/templates/landing/pop_movies.dart';
import 'package:billit_now/templates/landing/spotlight.dart';
import 'package:billit_now/templates/landing/top_picks.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../core/di/di_setup.dart';
import '../../core/localization/languages.dart';
import '../../repositories/ad/models/ad_model.dart';
import '../../repositories/event/models/event_range_model.dart';
import '../../repositories/shared/result.dart';
import '../shared/AdActionBloc.dart';

class LandingPageEvents extends BaseBlocEvent {}

class ChangeEventRangeEvent extends LandingPageEvents {
  EventRangeModel eventRangeModel;
  ChangeEventRangeEvent({
    required this.eventRangeModel,
  });
}

class LandingPage extends BaseStatelessPage {
  LandingPage({super.key});

  EventRangeModel _eventRangeModel = EventRangeModel.any_dates;
  @override
  List setProviders(BuildContext context) {
    return [
      BlocProvider(create: (context) => getIt<AdActionBloc>()),
      BlocProvider(create: (context) => getIt<HighLightEventsBloc>()),
      BlocProvider(create: (context) => getIt<LatestTheatersBloc>()),
      BlocProvider(create: (context) => getIt<LatestConcertsBloc>()),
      BlocProvider(create: (context) => getIt<PopMoviesBloc>()),
    ];
  }

  @override
  Widget body(BuildContext context) {
    return Landing();
  }

  @override
  void consumeEvent(BuildContext context, BaseBlocEvent event) {
    if (event is AdActionViewEvent || event is AdActionClickEvent) {
      context.read<AdActionBloc>().add(event);
    }
    if (event is ChangeEventRangeEvent) {
      if (_eventRangeModel != event.eventRangeModel) {
        _eventRangeModel = event.eventRangeModel;
        _refreshWholePage(context, _eventRangeModel);
      }
    }
    if (event is HighlightEventVisible) {
      _refreshHighlightEvents(context, _eventRangeModel);
    }
    if (event is LatestConcertsVisible) {
      _refreshLatestConcerts(context, _eventRangeModel);
    }
    if (event is LatestTheatersVisible) {
      _refreshLatestTheaters(context, _eventRangeModel);
    }
    if (event is PopMoviesVisible) {
      _refreshPopMovies(context, _eventRangeModel);
    }
  }

  @override
  void onLanguageChange(BuildContext context, Language language) {
    _refreshWholePage(context, _eventRangeModel);
  }

  void _refreshWholePage(
      BuildContext context, EventRangeModel eventRangeModel) {
    _refreshHighlightEvents(context, eventRangeModel);
    _refreshLatestConcerts(context, eventRangeModel);
    _refreshLatestTheaters(context, eventRangeModel);
    _refreshPopMovies(context, eventRangeModel);
  }

  void _refreshHighlightEvents(
      BuildContext context, EventRangeModel eventRangeModel) {
    context
        .read<HighLightEventsBloc>()
        .add(HighlightEventFetchData(
        eventRangeModel: eventRangeModel, language: getLanguage()));
  }

  void _refreshLatestConcerts(
      BuildContext context, EventRangeModel eventRangeModel) {
    context
        .read<LatestConcertsBloc>()
        .add(LatestConcertsFetchData(eventRangeModel, getLanguage()));
  }

  void _refreshLatestTheaters(
      BuildContext context, EventRangeModel eventRangeModel) {
    context
        .read<LatestTheatersBloc>()
        .add(LatestTheatersFetchData(eventRangeModel, getLanguage()));
  }

  void _refreshPopMovies(
      BuildContext context, EventRangeModel eventRangeModel) {
    context
        .read<PopMoviesBloc>()
        .add(PopMoviesFetchData(eventRangeModel, getLanguage()));
  }
}

@injectable
class LandingBloc extends BaseBloc<BaseBlocEvent, BaseBlocState> {
  final AdRepository adRepo;
  LandingBloc({required this.adRepo}) {
    on<EventInitial>((event, emit) async {
      try {
        emit(StateLoading());
        final result = await adRepo.getAds(
          "landing",
          100,
          0,
        );
        if (result is Success<List<AdModel>>) {
          emit(StateSuccessWithResult<List<AdModel>>(result: result.data));
        } else if (result is Error<List<AdModel>>) {
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
}

class Landing extends BaseBlocStatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends BaseBlocStateWidget<Landing, LandingBloc> {
  late ScrollController _scrollController;
  final double maxWidth = 1366;
  final topPicksData = 1;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  bool get visibilityDetection => true;

  @override
  void onVisible(BuildContext context) {
    addEvent(context, EventInitial());
  }

  @override
  void onLanguageChange(BuildContext context, Language language) {
    addEvent(context, EventInitial());
  }

  @override
  Widget body(BuildContext context, BaseBlocState state) {
    final spotlightBanners = (state is StateSuccessWithResult<List<AdModel>>)
        ? state.result.where((ad) => ad.adType == "Spotlight").toList()
        : List<AdModel>.empty();
    final middleBanners = (state is StateSuccessWithResult<List<AdModel>>)
        ? state.result.where((ad) => ad.adType == "middleBanner").toList()
        : List<AdModel>.empty();
    final fabBanner = (state is StateSuccessWithResult<List<AdModel>>)
        ? state.result.where((ad) => ad.adType == "fab").toList()
        : List<AdModel>.empty();
    return Scaffold(
      endDrawer: context.isSmallTabletOrLess ? const NavDrawer() : null,
      backgroundColor: Theme.of(context).appColors.bgPrimary,
      floatingActionButton: fabBanner.isEmpty
          ? Container()
          : FabAds(
              adId: fabBanner.first.id.toString(),
              video: fabBanner.first.mediaUrls.first,
              brandImage: fabBanner.first.logo,
              brandName: fabBanner.first.title,
              thumbnail: fabBanner.first.mediaThumbnail,
            ),
      body: SafeArea(
          child: Stack(
        children: [
          ListView(controller: _scrollController, children: [
            Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: ConcertHall(
                  title: getString("exclusive_iranian_access"),
                  tabs: [
                    {
                      'title': getString("concert"),
                      'video': 'assets/videos/concert.mov',
                      'thumbnail': 'assets/images/concert_hall_with_people_landscape.png'
                    },
                    {
                      'title': getString("theater"),
                      'video': 'assets/videos/theater.mov',
                      'thumbnail': 'assets/images/theater-thumbnail.png'
                    },
                    {
                      'title': getString("cinema"),
                      'video': 'assets/videos/cinema.mov',
                      'thumbnail': 'assets/images/cinema-thumbnail.png'
                    },
                    {
                      'title': getString("standup_comedy"),
                      'video': 'assets/videos/standup-comedy.mov',
                      'thumbnail': 'assets/images/standup-comedy-thumbnail.png'
                    },
                    {
                      'title': getString("party"),
                      'video': 'assets/videos/party.mov',
                      'thumbnail': 'assets/images/party-thumbnail.png'
                    },
                  ],
                ),
              ),
            ),
            Center(
                child: Container(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: TopPicks(
                        onTabChange: (eventRangeModel) {
                          addEvent(
                              context,
                              ChangeEventRangeEvent(
                                  eventRangeModel: eventRangeModel));
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return EmptyModal.show();
                          //   },
                          // );
                          // TODO: if u not receive any data, set topPicksData to null for display emprty screen, u can change type of topPicksData to any
                          // topPicksData = null;
                        }))),
            topPicksData == null
                ? Container()
                : Center(
                    child: Container(
                        constraints: BoxConstraints(maxWidth: maxWidth),
                        child: HighlightEvents())),
            topPicksData == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 48),
                    child: Divider(
                      color: Theme.of(context).appColors.borderSecondary,
                    ),
                  ),
            topPicksData == null
                ? Container()
                : Center(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: LatestConcerts(
                        title: getString("latest_concerts"),
                        viewAllBtnText: getString("view_all_concerts"),
                        beganColorGradient: Theme.of(context).appColors.bgBrand,
                        scrollCount: context.isRegularSmartphoneOrLess ? 1 : 4,
                      ),
                    ),
                  ),
            spotlightBanners.isNotEmpty
                ? Center(
                    child: Container(
                        constraints: BoxConstraints(maxWidth: maxWidth),
                        child: Spotlight(
                            title: getString("partner_spotlight"),
                            onWebsiteTap: () {
                              EmptyModal.show(context: context);
                            },
                            adItems: spotlightBanners)),
                  )
                : Container(),
            topPicksData == null
                ? Container()
                : Center(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: LatestTheaters(
                          title: getString("latest_theaters"),
                          viewAllBtnText: getString("view_all_theaters"),
                          beganColorGradient: const Color(0xFF460707),
                          scrollCount:
                              context.isRegularSmartphoneOrLess ? 1 : 4),
                    ),
                  ),
            middleBanners.isEmpty
                ? Container()
                : Center(
                    child: Container(
                        constraints: BoxConstraints(maxWidth: maxWidth),
                        child: BannerAds(
                          adId: middleBanners[0].id.toString(),
                          title: middleBanners[0].title,
                          description: middleBanners[0].description,
                          link: middleBanners[0].link,
                          videoUrl: middleBanners[0].mediaUrls[0],
                        ))),
            topPicksData == null
                ? Container()
                : Center(
                    child: Container(
                        constraints: BoxConstraints(maxWidth: maxWidth),
                        child: PopMovies())),
            topPicksData == null
                ? Center(
                    child: Container(
                        constraints: BoxConstraints(maxWidth: maxWidth),
                        child: EmptyScreen()))
                : Container(),
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
          ]),
          Header(
            scrollController: _scrollController,
            activeAction: HeaderActions.home,
          ),
        ],
      )),
    );
  }
}
