import 'dart:async';
import 'dart:math';
import 'dart:core';

import 'package:billit_now/apps/event_data.dart';
import 'package:billit_now/apps/helper/router/router_extention/events_router_extention.dart';
import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_slider.dart';
import 'package:billit_now/component/empty_modal.dart';
import 'package:billit_now/component/event_item.dart';
import 'package:billit_now/features/base/base_bloc_stateful_widget.dart';
import 'package:billit_now/repositories/shared/errors.dart';
import 'package:billit_now/templates/landing/utils.dart';
import 'package:billit_now/templates/landing/widgets/circular_percent_indicator.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/localization/languages.dart';
import '../../features/base/base_bloc.dart';
import '../../features/base/base_bloc_event.dart';
import '../../features/base/base_bloc_state.dart';
import '../../repositories/event/event_repository.dart';
import '../../repositories/event/input_models/get_events_input_model.dart';
import '../../repositories/event/models/event_category_model.dart';
import '../../repositories/event/models/event_model.dart';
import '../../repositories/event/models/event_range_model.dart';
import '../../repositories/shared/result.dart';

class PopMoviesEvents extends BaseBlocEvent {}

class PopMoviesFetchData extends PopMoviesEvents {
  EventRangeModel eventRangeModel;
  Language language;
  PopMoviesFetchData(this.eventRangeModel, this.language);
}

class ChangeHighlightedEvent extends BaseBlocEvent {
  final int newHighlightedItemIndex;

  ChangeHighlightedEvent({
    required this.newHighlightedItemIndex,
  });
}

class PopMoviesVisible extends PopMoviesEvents {}

class PopMoviesStateSuccess extends BaseBlocState {
  final List<EventModel> result;
  final int highlightedEvent;
  PopMoviesStateSuccess({required this.result, required this.highlightedEvent});
}

@singleton
class PopMoviesBloc extends BaseBloc<PopMoviesEvents, BaseBlocState> {
  final EventRepository eventRepo;
  PopMoviesBloc(this.eventRepo) {
    on<PopMoviesFetchData>((event, emit) async {
      try {
        emit(StateLoading());
        final result = event.eventRangeModel == EventRangeModel.any_dates
            ? await eventRepo.getEvents(GetEventsInputModel(
                eventCategoryModel: EventCategoryModel.cinema,
                limit: 5,
              ))
            : await eventRepo.getEventsRange(
                GetEventsInputModel(
                  eventCategoryModel: EventCategoryModel.cinema,
                  limit: 5,
                ),
                event.eventRangeModel);
        if (result is Success<List<EventModel>>) {
          emit(PopMoviesStateSuccess(result: result.data, highlightedEvent: 0));
        } else if (result is Error<List<EventModel>>) {
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
    }, transformer: restartable());
    on<ChangeHighlightedEvent>((event, emit) {
      if (state is PopMoviesStateSuccess) {
        final popMoviesStateSuccess = state as PopMoviesStateSuccess;
        emit(PopMoviesStateSuccess(
          result: popMoviesStateSuccess.result,
          highlightedEvent: event.newHighlightedItemIndex,
        ));
      }
    });
  }

  @override
  bool eventToDebounce(BaseBlocEvent currentEvent) {
    return currentEvent is PopMoviesFetchData;
  }

  @override
  Duration eventDebounceThreshold(
      BaseBlocEvent lastEvent, BaseBlocEvent event) {
    if (event is PopMoviesFetchData) {
      if (lastEvent is PopMoviesFetchData &&
          (
              lastEvent.eventRangeModel != event.eventRangeModel ||
              lastEvent.language != event.language
          )
      ) {
        return Duration.zero;
      }
      return Duration(minutes: 10);
    } else {
      return Duration.zero;
    }
  }

  int getEventListSize() {
    if (state is PopMoviesStateSuccess) {
      return (state as PopMoviesStateSuccess).result.length;
    } else {
      return -1;
    }
  }

  int getHighlightedEventIndex() {
    if (state is PopMoviesStateSuccess) {
      return (state as PopMoviesStateSuccess).highlightedEvent;
    } else {
      return -1;
    }
  }
}

class PopMovies extends BaseBlocStatefulWidget {
  const PopMovies({super.key});

  final int DEFAULT_SLIDER_INTERVAL = 5;

  @override
  State<PopMovies> createState() => _PopMoviesState();
}

class _PopMoviesState extends BaseBlocStateWidget<PopMovies, PopMoviesBloc> {
  final CarouselSliderController buttonCarouselController =
      CarouselSliderController();
  final ScrollController controller = ScrollController();
  late PopMoviesBloc bloc;
  Timer? _timer;
  double _percent = 0.0;

  @override
  void preConfigBloc(BuildContext context, PopMoviesBloc bloc) {
    this.bloc = bloc;
  }

  void _startProgress(BuildContext context) {
    _timer?.cancel();
    setState(() {
      _percent = 0.0;
    });
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _percent += (50 / (widget.DEFAULT_SLIDER_INTERVAL * 1000));
        if (_percent >= 1.0) {
          _percent = 1.0;
        }
      });
      if (_percent == 1.0) {
        _onSlideChange(context);
        timer.cancel();
      }
    });
  }

  void _onSlideChange(context) {
    final eventListSize = bloc.getEventListSize();
    final highlightedItemIndex = bloc.getHighlightedEventIndex();
    if (eventListSize != -1) {
      addEvent(
          context,
          ChangeHighlightedEvent(
              newHighlightedItemIndex:
                  indexLoopMapper(highlightedItemIndex + 1, eventListSize)));
    } else {
      addEvent(context, ChangeHighlightedEvent(newHighlightedItemIndex: -1));
    }
    buttonCarouselController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  _cancelTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  bool get visibilityDetection => true;
  @override
  Key get visibilityKey => Key("pop_movies");

  @override
  void onVisible(BuildContext context) {
    if (kDebugMode) {
      print("Pop Movies is Visible");
    }
    addEvent(context, PopMoviesVisible());
  }

  @override
  void onInvisible(BuildContext context) {
    if (kDebugMode) {
      print("Pop Movies is InVisible");
    }
  }

  @override
  Widget body(BuildContext context, BaseBlocState state) {
    if (state is StateLoading) {
      return _stateLoading(context);
    } else if (state is StateError) {
      return _stateError();
    } else if (state is PopMoviesStateSuccess) {
      return _stateSuccess(context, state.result);
    } else {
      return _stateInitial(context);
    }
  }

  Widget _stateInitial(BuildContext context) {
    final cards = context.isRegularSmartphoneOrLess
        ? 1
        : (context.isSmallTabletOrLess || context.logicalWidth < 1200)
            ? 3
            : 5;
    final cardsMiddle = cards ~/ 2;
    final itemHeight = 462.0;
    final itemWidth = 248.0;
    final imageHeight = 372.0;
    final cardScales = 0.75;
    final cardCornerRadius = 16.0;
    final cardStroke = 2.0;
    final cardInternalPadding = 12.0;
    final itemMargin = 4.0;
    final textHeight = 16.0;
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 96, bottom: 48),
              child: Shimmer.fromColors(
                baseColor: Theme.of(context).appColors.textPrimary900,
                highlightColor: Theme.of(context).appColors.bgBrand,
                child: Text(getString("popular_movies"),
                    style: Theme.of(context)
                        .appTexts
                        .displaySmSemiBold
                        .copyWith(
                            color: Theme.of(context).appColors.textPrimary900)),
              )),
          SizedBox(
            height: itemHeight,
            child: ListView.separated(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: cards,
                itemBuilder: (context, index) {
                  final sizeMultiplier = (cardsMiddle == index)
                      ? 1
                      : pow(
                          cardScales,
                          index > cardsMiddle
                              ? index - cardsMiddle
                              : cardsMiddle - index);
                  return Center(
                    child: createSkeletonCardWidget(
                        itemHeight * sizeMultiplier,
                        itemWidth * sizeMultiplier,
                        imageHeight * sizeMultiplier,
                        cardCornerRadius * sizeMultiplier,
                        cardStroke * sizeMultiplier,
                        cardInternalPadding * sizeMultiplier,
                        itemMargin * sizeMultiplier,
                        textHeight * sizeMultiplier),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 32)),
          )
        ],
      ),
    );
  }

  Widget _stateLoading(BuildContext context) {
    return _stateInitial(context);
  }

  Widget _stateError() {
    return SizedBox(
      height: 400,
      child: Text(""),
    );
  }

  Widget _stateEmpty() {
    return SizedBox(
      height: 400,
      child: Text(""),
    );
  }

  Widget _stateSuccess(BuildContext context, List<EventModel> eventList) {
    return eventList.isEmpty
        ? Container()
        : Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: RadialGradient(
              radius: 5,
              colors: [
                Theme.of(context).appColors.vanilla900,
                Theme.of(context).appColors.bgPrimary,
              ],
              stops: [0.9, 1],
              center: Alignment(0.0, 10.5),
            )),
            padding: EdgeInsets.symmetric(
                horizontal: context.isRegularSmartphoneOrLess ? 0 : 96),
            child: Column(
              children: [
                // title
                Padding(
                  padding: const EdgeInsets.only(top: 96, bottom: 48),
                  child: Text(getString("popular_movies"),
                      style: Theme.of(context)
                          .appTexts
                          .displaySmSemiBold
                          .copyWith(
                              color:
                                  Theme.of(context).appColors.textPrimary900)),
                ),
                // slider
                SizedBox(
                  height: 462,
                  child: LayoutBuilder(builder: (context, constraint) {
                    return Stack(
                      children: [
                        // slider
                        AppSlider.expanded(
                          items: eventList.map((item) {
                            return Builder(
                              builder: (BuildContext context) {
                                return EventItem.expanded(
                                    status: item.status,
                                    image: item.imageKey,
                                    title: item.name,
                                    date: formatDate(item.startTime),
                                    location: item.venue.address,
                                    price: item.startingPrice.toString(),
                                    onTap: () {
                                      EventData(
                                        id: item.id.toString(),
                                        eventImage: item.imageKey,
                                        organizer: 'Alireza Zolghadri',
                                        title: item.name,
                                        subTitle: item.description,
                                        startDate: item.startTime,
                                        endDate: item.endTime,
                                        location: item.venue.address,
                                      ).saveOnStorage(() {
                                        context.goEventPage();
                                      });
                                    },
                                    onTapLike: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return EmptyModal.show(
                                              context: context);
                                        },
                                      );
                                    });
                              },
                            );
                          }).toList(),
                          viewportFraction: context.logicalWidth < 800
                              ? 0.5
                              : context.logicalWidth < 1000
                                  ? 0.4
                                  : context.logicalWidth < 1100
                                      ? 0.3
                                      : 0.21,
                          buttonCarouselController: buttonCarouselController,
                          initialPage: bloc.getHighlightedEventIndex(),
                          onPageChanged: (int index, __) {},
                        ),
                        // left gradient
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: constraint.maxWidth / 3,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Theme.of(context).appColors.bgPrimary,
                                  Theme.of(context)
                                      .appColors
                                      .bgPrimary
                                      .withOpacity(0.8),
                                  Colors.transparent,
                                ],
                                stops: const [0.0, 0.7, 1.0],
                              ),
                            ),
                          ),
                        ),
                        // left btn
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: context.isRegularSmartphoneOrLess
                                    ? 30
                                    : 136),
                            width: 58,
                            height: 58,
                            child: AppButton.buttonIcon(
                              AppIconName.uea1fChevronLeft,
                              bgColor: Theme.of(context).appColors.bgTertiary,
                              bgHoverColor: Colors.transparent,
                              textColor: Colors.transparent,
                              padding: const EdgeInsets.all(14),
                              iconSize: 20,
                              border: Border.all(
                                  color: Theme.of(context)
                                      .appColors
                                      .borderSecondary),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              context: context,
                              onTap: () {
                                addEvent(
                                    context,
                                    ChangeHighlightedEvent(
                                        newHighlightedItemIndex: indexLoopMapper(
                                            bloc.getHighlightedEventIndex() - 1,
                                            bloc.getEventListSize())));
                                buttonCarouselController
                                    .previousPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.linear)
                                    .then((_) {
                                  _startProgress(context);
                                });
                              },
                            ),
                          ),
                        ),
                        // right gradient
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: constraint.maxWidth / 3,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  Theme.of(context).appColors.bgPrimary,
                                  Theme.of(context)
                                      .appColors
                                      .bgPrimary
                                      .withOpacity(0.8),
                                  Colors.transparent,
                                ],
                                stops: const [0.0, 0.7, 1.0],
                              ),
                            ),
                          ),
                        ),
                        // right btn
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: EdgeInsets.only(
                                right: context.isRegularSmartphoneOrLess
                                    ? 30
                                    : 136),
                            width: 58,
                            height: 58,
                            child: AppButton.buttonIcon(
                                AppIconName.uea21ChevronRight,
                                bgColor: Theme.of(context).appColors.bgTertiary,
                                bgHoverColor: Colors.transparent,
                                textColor: Colors.transparent,
                                padding: const EdgeInsets.all(14),
                                iconSize: 20,
                                border: Border.all(
                                    color: Theme.of(context)
                                        .appColors
                                        .borderSecondary),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                                context: context, onTap: () {
                              addEvent(
                                  context,
                                  ChangeHighlightedEvent(
                                      newHighlightedItemIndex: indexLoopMapper(
                                          bloc.getHighlightedEventIndex() + 1,
                                          bloc.getEventListSize())));
                              buttonCarouselController
                                  .nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.linear)
                                  .then((_) {
                                _cancelTimer();
                              });
                            }),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                // timer circle
                Container(
                    width: 24,
                    height: 24,
                    margin: const EdgeInsets.only(top: 24),
                    child: CircularPercentIndicator(percent: _percent)),
                // View all cinema movies Btn
                Container(
                  width: 220,
                  padding: const EdgeInsets.only(top: 46, bottom: 96),
                  child: AppButton.buttonTertiary(
                      context: context,
                      text: getString("view_all_cinema_movies"),
                      textStyle: Theme.of(context)
                          .appTexts
                          .textMdSemiBold
                          .copyWith(
                            color:
                                Theme.of(context).appColors.buttonSecondaryFg,
                          ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      border: Border.all(
                          color: Theme.of(context)
                              .appColors
                              .buttonSecondaryBorder),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return EmptyModal.show(context: context);
                          },
                        );
                      }),
                )
              ],
            ));
  }

  Widget createSkeletonCardWidget(
    double itemHeight,
    double itemWidth,
    double imageHeight,
    double cardCornerRadius,
    double cardStroke,
    double cardInternalPadding,
    double itemMargin,
    double textHeight,
  ) {
    return SizedBox(
      width: itemWidth,
      height: itemHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Shimmer.fromColors(
                      baseColor: Theme.of(context).appColors.bgPrimary,
                      highlightColor: Theme.of(context).appColors.bgBrand,
                      child: Container(
                        width: itemWidth,
                        height: imageHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(cardCornerRadius),
                          color: Theme.of(context).appColors.bgPrimary,
                        ),
                      )),
                  Container(
                    width: itemWidth - 2 * cardStroke,
                    height: imageHeight - 2 * cardStroke,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(cardCornerRadius - cardStroke),
                      color: Theme.of(context).appColors.bgPrimary,
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                    left: cardInternalPadding,
                    top: cardInternalPadding,
                    right: cardInternalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                        baseColor: Theme.of(context).appColors.bgPrimary,
                        highlightColor: Theme.of(context).appColors.bgBrand,
                        child: Container(
                          width: textHeight * 4,
                          height: textHeight,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(textHeight / 4),
                              color: Theme.of(context).appColors.bgPrimary),
                        )),
                    Shimmer.fromColors(
                        baseColor: Theme.of(context).appColors.bgPrimary,
                        highlightColor: Theme.of(context).appColors.bgBrand,
                        child: SvgPicture.asset(
                          AppIconName.ueb3aHeart.name,
                          width: textHeight,
                          height: textHeight,
                        ))
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: itemMargin),
          Shimmer.fromColors(
              baseColor: Theme.of(context).appColors.bgPrimary,
              highlightColor: Theme.of(context).appColors.bgBrand,
              child: Container(
                width: textHeight * 6,
                height: textHeight / 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(textHeight / 4),
                    color: Theme.of(context).appColors.bgPrimary),
              )),
          SizedBox(height: itemMargin),
          Shimmer.fromColors(
              baseColor: Theme.of(context).appColors.bgPrimary,
              highlightColor: Theme.of(context).appColors.bgBrand,
              child: Container(
                width: textHeight * 10,
                height: textHeight / 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(textHeight / 4),
                    color: Theme.of(context).appColors.bgPrimary),
              )),
          SizedBox(height: itemMargin),
          Shimmer.fromColors(
              baseColor: Theme.of(context).appColors.bgPrimary,
              highlightColor: Theme.of(context).appColors.bgBrand,
              child: Container(
                width: textHeight * 3,
                height: textHeight / 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(textHeight / 4),
                    color: Theme.of(context).appColors.bgPrimary),
              ))
        ],
      ),
    );
  }

  @override
  void consumeState(BuildContext context, BaseBlocState state) {
    if (state is PopMoviesStateSuccess) {
      _startProgress(context);
    }
  }
}
