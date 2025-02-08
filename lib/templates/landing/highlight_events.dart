import 'dart:async';
import 'package:billit_now/core/localization/layout_direction.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:billit_now/repositories/event/models/event_range_model.dart';
import 'package:billit_now/repositories/shared/errors.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/src/widgets/image.dart';

import 'package:billit_now/apps/event_data.dart';
import 'package:billit_now/apps/helper/router/router_extention/events_router_extention.dart';
import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/empty_modal.dart';
import 'package:billit_now/component/event_item.dart';
import 'package:billit_now/features/base/base_bloc.dart';
import 'package:billit_now/features/base/base_bloc_event.dart';
import 'package:billit_now/features/base/base_bloc_state.dart';
import 'package:billit_now/features/base/base_bloc_stateful_widget.dart';
import 'package:billit_now/repositories/event/event_repository.dart';
import 'package:billit_now/repositories/event/input_models/get_events_input_model.dart';
import 'package:billit_now/repositories/event/models/event_model.dart';
import 'package:billit_now/templates/landing/utils.dart';
import 'package:billit_now/templates/landing/widgets/circular_percent_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/localization/languages.dart';
import '../../repositories/event/models/event_category_model.dart';
import '../../repositories/shared/result.dart';

class HighlightEventsEvent extends BaseBlocEvent {}
class HighlightEventFetchData extends HighlightEventsEvent {
  EventRangeModel eventRangeModel;
  Language language;
  HighlightEventFetchData({
    required this.eventRangeModel,
    required this.language,
  });
}
class ChangeHighlightedEvent extends HighlightEventsEvent {
  final int newHighlightEventIndex;

  ChangeHighlightedEvent({
    required this.newHighlightEventIndex,
  });
}
class HighlightEventVisible extends HighlightEventsEvent {}

class HighlightEventsStateSuccess extends BaseBlocState {
  final List<EventModel> result;
  int highlightedEvent;

  HighlightEventsStateSuccess({
    required this.result,
    required this.highlightedEvent,
  });
}

const int _HIGHTLIGHTS_MAX_SIZE = 5;

@singleton
class HighLightEventsBloc extends BaseBloc<HighlightEventsEvent, BaseBlocState> {

  final EventRepository _eventRepo;
  late HighlightEventsEvent _lastEvent;

  HighLightEventsBloc(this._eventRepo) {
    on<HighlightEventFetchData>((event, emit) async {
      try {
        emit(StateLoading());
        final result = event.eventRangeModel == EventRangeModel.any_dates
            ? await _eventRepo.getEvents(GetEventsInputModel(
                eventCategoryModel: EventCategoryModel.concert,
                limit: _HIGHTLIGHTS_MAX_SIZE,
              ))
            : await _eventRepo.getEventsRange(
                GetEventsInputModel(
                  eventCategoryModel: EventCategoryModel.concert,
                  limit: _HIGHTLIGHTS_MAX_SIZE,
                ),
                event.eventRangeModel);
        if (result is Success<List<EventModel>>) {
          emit(HighlightEventsStateSuccess(
            result: result.data.take(_HIGHTLIGHTS_MAX_SIZE).toList(),
            highlightedEvent: 0,
          ));
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
      if(state is HighlightEventsStateSuccess) {
        final highlightEventsStateSuccess = state as HighlightEventsStateSuccess;
        emit(
            HighlightEventsStateSuccess(
                result: highlightEventsStateSuccess.result,
                highlightedEvent: event.newHighlightEventIndex
            )
        );
      }
    });
  }

  @override
  bool eventToDebounce(BaseBlocEvent currentEvent) {
    return currentEvent is HighlightEventFetchData;
  }

  @override
  Duration eventDebounceThreshold(BaseBlocEvent lastEvent, BaseBlocEvent event) {
    if(event is HighlightEventFetchData) {
      if(lastEvent is HighlightEventFetchData && (
          lastEvent.eventRangeModel != event.eventRangeModel ||
          lastEvent.language != event.language
      )) {
        return Duration.zero;
      }
      return Duration(minutes: 2);
    } else {
      return Duration.zero;
    }
  }

  int getEventListSize() {
    if(state is HighlightEventsStateSuccess) {
      return (state as HighlightEventsStateSuccess).result.length;
    } else {
      return -1;
    }
  }

  int getHighlightedEventIndex() {
    if(state is HighlightEventsStateSuccess) {
      return (state as HighlightEventsStateSuccess).highlightedEvent;
    } else {
      return -1;
    }
  }

}

class HighlightEvents extends BaseBlocStatefulWidget {
  const HighlightEvents({super.key});

  final int DEFAULT_SLIDER_INTERVAL = 5;

  @override
  State<HighlightEvents> createState() => _HighlightEventsState();
}

class _HighlightEventsState
    extends BaseBlocStateWidget<HighlightEvents, HighLightEventsBloc> {

  late HighLightEventsBloc bloc;
  late BuildContext _context;
  Timer? _timer;
  double _percent = 0.0;
  bool isActive = true;
  final paddingDesktop = 96.0;
  final paddingMobile = 18.0;

  @override
  void preConfigBloc(BuildContext context, HighLightEventsBloc bloc) {
    this._context = context;
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
      if(_percent == 1.0) {
        _onSlideChange(context);
        timer.cancel();
      }
    });
  }

  void _onSlideChange(BuildContext context) {
    final eventListSize = bloc.getEventListSize();
    final highlightedItemIndex = bloc.getHighlightedEventIndex();
    if(eventListSize != -1) {
      addEvent(context, ChangeHighlightedEvent(newHighlightEventIndex: (highlightedItemIndex + 1) % eventListSize));
    } else {
      addEvent(context, ChangeHighlightedEvent(newHighlightEventIndex: -1));
    }
  }

  _stopProgress() {
    _timer?.cancel();
  }

  @override
  void deactivate() {
    _stopProgress();
    super.deactivate();
  }

  @override
  void activate() {
    _startProgress(_context);
    super.activate();
  }

  @override
  void dispose() {
    _stopProgress();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  bool get visibilityDetection => true;
  @override
  Key get visibilityKey => Key("highlight_events");

  @override
  bool allowRTLDirectionality() => true;

  @override
  void onVisible(BuildContext context) {
    if (kDebugMode) {
      print("Highlight Events is Visible");
    }
    addEvent(context, HighlightEventVisible());
  }

  @override
  void onInvisible(BuildContext context) {
    if (kDebugMode) {
      print("Highlight Events is InVisible");
    }
  }

  @override
  Widget body(BuildContext context, BaseBlocState state) {
    if (state is StateLoading) {
      return _stateLoading(context);
    } else if (state is StateError) {
      return _stateError(context);
    } else if (state is HighlightEventsStateSuccess) {
      if (state.result.isEmpty) {
        return _stateEmpty(context);
      }
      return _stateSuccess(context, state.result, state.highlightedEvent);
    } else {
      return _stateInitial(context);
    }
  }

  // Widget _stateInitial(BuildContext context) {
  //   return EventSkeletonLoader(
  //     baseColor: Theme.of(context).appColors.bgPrimary,
  //     highlightColor: Theme.of(context).appColors.bgBrand,
  //   );
  // }

  Widget _stateInitial(BuildContext context) {
    return HighlightedEventSkeleton();
  }

  Widget _stateLoading(BuildContext context) {
    return _stateInitial(context);
  }

  Widget _stateError(BuildContext context) {
    return _stateInitial(context);
  }

  Widget _stateEmpty(BuildContext context) {
    return _stateInitial(context);
  }

  Widget _stateSuccess(BuildContext context, List<EventModel> eventList, int highlightedItemIndex) {
    final highlightedEvent = eventList[highlightedItemIndex];
    final leftPadding = getLayoutDirection() == LayoutDirection.ltr ? (context.isRegularSmartphoneOrLess ? paddingMobile : paddingDesktop) : null;
    final rightPadding = getLayoutDirection() == LayoutDirection.rtl ? (context.isRegularSmartphoneOrLess ? paddingMobile : paddingDesktop) : null;
    return eventList.isEmpty
        ? Container()
        : SizedBox(
            height: Theme.of(context).appDimensions.highlightHeightResponsive,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: context.logicalHeight,
                  child: Stack(
                    children: [
                      Image.network(
                        highlightedEvent.imageKey,
                        width: double.infinity,
                        height: context.logicalHeight,
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: context.logicalWidth,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Theme.of(context).appColors.bgPrimary,
                                Colors.transparent,
                              ],
                              stops: const [0.2, 1.0],
                            ),
                          ),
                        ),
                      ),
                      // left gradient
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: context.logicalWidth,
                          height: context.logicalHeight,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Theme.of(context).appColors.bgPrimary,
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.5],
                            ),
                          ),
                        ),
                      ),
                      // top gradient
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: context.logicalWidth,
                          height: context.logicalHeight,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Theme.of(context).appColors.bgPrimary,
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.6],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // event main info
                // date and time
                Positioned(
                  top: 40,
                  left: leftPadding,
                  right: rightPadding,
                  child: Row(
                    children: [
                      Text(
                        formatFullDate(highlightedEvent.startTime), // TODO
                        style: context.isRegularSmartphoneOrLess
                            ? Theme.of(context).appTexts.textMdRegular.copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textSecondary700)
                            : Theme.of(context).appTexts.textLgRegular.copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textSecondary700),
                      ),
                      Text(
                        '\t\t.\t\t',
                        style: context.isRegularSmartphoneOrLess
                            ? Theme.of(context).appTexts.textMdRegular.copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textSecondary700)
                            : Theme.of(context).appTexts.textLgRegular.copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textSecondary700),
                      ),
                      Text(
                        formatTime(highlightedEvent.startTime),
                        style: context.isRegularSmartphoneOrLess
                            ? Theme.of(context).appTexts.textMdRegular.copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textSecondary700)
                            : Theme.of(context).appTexts.textLgRegular.copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textSecondary700),
                      )
                    ],
                  ),
                ),
                // title
                Positioned(
                  top: 60,
                  left: leftPadding,
                  right: rightPadding,
                  child: SizedBox(
                    width: context.logicalWidth - 100,
                    child: Text(highlightedEvent.name ?? '',
                        maxLines: 1,
                        style: context.isRegularSmartphoneOrLess
                            ? Theme.of(context)
                                .appTexts
                                .displayMdSemibold
                                .copyWith(
                                    color: Theme.of(context)
                                        .appColors
                                        .textPrimary900)
                            : Theme.of(context)
                                .appTexts
                                .displayXlSemibold
                                .copyWith(
                                    color: Theme.of(context)
                                        .appColors
                                        .textPrimary900)),
                  ),
                ),
                // location
                Positioned(
                  top: context.isRegularSmartphoneOrLess ? 130 : -140,
                  left: leftPadding,
                  right: rightPadding,
                  child: Text(eventList.first.venue.name,
                      style: context.isRegularSmartphoneOrLess
                          ? Theme.of(context).appTexts.textMdSemiBold.copyWith(
                              color: Theme.of(context).appColors.textPrimary900)
                          : Theme.of(context).appTexts.textXlRegular.copyWith(
                              color:
                                  Theme.of(context).appColors.textPrimary900)),
                ),
                // buy btn
                Positioned(
                  top: context.isRegularSmartphoneOrLess ? 160 : 200,
                  left: leftPadding,
                  right: rightPadding,
                  child: AppButton.buttonTertiary(
                      context: context,
                      text: getString("buy_ticket"),
                      bgColor: Theme.of(context).appColors.bgSecondary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      border: Border.all(
                        color: Theme.of(context).appColors.borderPrimary,
                      ),
                      onTap: () {
                        EventData(
                          id: highlightedEvent.id.toString(),
                          eventImage: highlightedEvent.imageKey,
                          organizer: 'Alireza Zolghadri',
                          title: highlightedEvent.name,
                          subTitle: highlightedEvent.description,
                          startDate: highlightedEvent.startTime,
                          endDate: highlightedEvent.endTime,
                          location: highlightedEvent.venue.name,
                        ).saveOnStorage(() {
                          context.goEventPage();
                        });
                      }),
                ),
                // items
                eventList.length < 3
                    ? Container()
                    : Positioned(
                        bottom: context.isRegularSmartphoneOrLess ? 100 : 0,
                        right: context.isRegularSmartphoneOrLess ? paddingMobile : paddingDesktop,
                        left: context.isRegularSmartphoneOrLess ? paddingMobile : paddingDesktop,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  getString("highlight_events"),
                                  style: context.isRegularSmartphoneOrLess
                                      ? Theme.of(context)
                                          .appTexts
                                          .displayXsSemibold
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .appColors
                                                  .textPrimary900)
                                      : Theme.of(context)
                                          .appTexts
                                          .displaySmSemiBold
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .appColors
                                                  .textPrimary900),
                                ),
                                // timer circle
                                SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularPercentIndicator(
                                        percent: _percent)),
                              ],
                            ),
                            const SizedBox(height: 20),
                            context.isRegularSmartphoneOrLess
                                ? _highlightItemsGrid(eventList, highlightedItemIndex)
                                    : _highlightItemsRow(eventList, highlightedItemIndex)
                          ],
                        ),
                      )
              ],
            ),
          );
  }

  Widget _highlightItemsRow(List<EventModel> eventList, int highlightedItemIndex) => SizedBox(
      width: context.logicalWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(eventList.length - 1, (index) {
          int mappedIndex = indexLoopMapper(highlightedItemIndex + index + 1, eventList.length - 1);
          return Padding(
            padding: const EdgeInsets.only(left: 32),
            child: EventItem.def(
                status: eventList[mappedIndex].status,
                image: eventList[mappedIndex].imageKey,
                title: eventList[mappedIndex].name,
                date: formatDate(eventList[mappedIndex].startTime),
                location: eventList[mappedIndex].venue.name,
                price: eventList[mappedIndex].startingPrice.toString(),
                onTap: () {
                  EventData(
                    id: eventList[mappedIndex].id.toString(),
                    eventImage: eventList[mappedIndex].imageKey,
                    organizer: 'Alireza Zolghadri',
                    title: eventList[mappedIndex].name,
                    subTitle: eventList[mappedIndex].description,
                    startDate: eventList[mappedIndex].startTime,
                    endDate: eventList[mappedIndex].endTime,
                    location: eventList[mappedIndex].venue.name,
                  ).saveOnStorage(() {
                    context.goEventPage();
                  });
                },
                onTapLike: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return EmptyModal.show(context: context,);
                    },
                  );
                }),
          );
        }),
      ));

  Widget _highlightItemsGrid(List<EventModel> eventList, int highlightedItemIndex) => SizedBox(
        width: context.logicalWidth,
        child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: context.isRegularSmartphoneOrLess ?
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 8,
              childAspectRatio: 1.5,
            ) : const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 16,
              childAspectRatio: 1.5,
            )
            ,
            itemCount: eventList.length - 1,
            itemBuilder: (BuildContext context, int index) {
              final mappedIndex = indexLoopMapper(highlightedItemIndex + index + 1, eventList.length - 1);
              return EventItem.def(
                  status: eventList[mappedIndex].status,
                  image: eventList[mappedIndex].imageKey,
                  title: eventList[mappedIndex].name,
                  date: formatDate(eventList[mappedIndex].startTime),
                  location: eventList[mappedIndex].venue.name,
                  price: eventList[mappedIndex].startingPrice.toString(),
                  onTap: () {
                    EventData(
                      id: eventList[mappedIndex].id.toString(),
                      eventImage: eventList[mappedIndex].imageKey,
                      organizer: 'Alireza Zolghadri',
                      title: eventList[mappedIndex].name,
                      subTitle: eventList[mappedIndex].description,
                      startDate: eventList[mappedIndex].startTime,
                      endDate: eventList[mappedIndex].endTime,
                      location: eventList[mappedIndex].venue.name,
                    ).saveOnStorage(() {
                      context.goEventPage();
                    });
                  },
                  onTapLike: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EmptyModal.show(context: context);
                      },
                    );
                  });
            }),
      );

  @override
  void consumeState(BuildContext context, BaseBlocState state) {
    if (state is HighlightEventsStateSuccess) {
      _startProgress(context);
    } else {
      _stopProgress();
    }
  }
}

class HighlightedEventSkeleton extends BaseStatelessWidget {

  final paddingDesktop = 96.0;
  final paddingMobile = 16.0;

  @override
  bool allowRTLDirectionality() => true;

  @override
  Widget body(BuildContext context) {
    final leftPadding = getLayoutDirection() == LayoutDirection.ltr ? (context.isRegularSmartphoneOrLess ? paddingMobile : paddingDesktop) : null;
    final rightPadding = getLayoutDirection() == LayoutDirection.rtl ? (context.isRegularSmartphoneOrLess ? paddingMobile : paddingDesktop) : null;
    return SizedBox(
      height: Theme.of(context).appDimensions.highlightHeightResponsive,
      child: Stack(
        children: [
          // Background shimmer
          SizedBox(
            width: double.infinity,
            height: context.logicalHeight,
            child: Stack(
              children: [
                Shimmer.fromColors(
                  baseColor: Theme.of(context).appColors.bgPrimary!,
                  highlightColor: Theme.of(context).appColors.bgBrandSolid!,
                  child: Container(
                    width: double.infinity,
                    height: context.logicalHeight,
                    color: Theme.of(context).appColors.bgPrimary,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: context.logicalWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Theme.of(context).appColors.bgPrimary,
                          Colors.transparent,
                        ],
                        stops: const [0.2, 1.0],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: context.logicalWidth,
                    height: context.logicalHeight,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Theme.of(context).appColors.bgPrimary,
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: context.logicalWidth,
                    height: context.logicalHeight,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).appColors.bgPrimary,
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.6],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Skeleton for date and time
          Positioned(
            top: 40,
            left: leftPadding,
            right: rightPadding,
            child: Row(
              children: [
                _buildShimmerBox(context, width: 80, height: 16),
                SizedBox(width: 8),
                _buildShimmerBox(context, width: 50, height: 16),
              ],
            ),
          ),

          // Skeleton for title
          Positioned(
            top: 60,
            left: leftPadding,
            right: rightPadding,
            child: _buildShimmerBox(context, width: context.logicalWidth - 100, height: 20),
          ),

          // Skeleton for location
          Positioned(
            top: context.isRegularSmartphoneOrLess ? 130 : -140,
            left: leftPadding,
            right: rightPadding,
            child: _buildShimmerBox(context, width: 150, height: 16),
          ),

          // Skeleton for "Buy Ticket" button
          Positioned(
            top: context.isRegularSmartphoneOrLess ? 160 : 200,
            left: leftPadding,
            right: rightPadding,
            child: _buildShimmerBox(context, width: 120, height: 40),
          ),

          // Highlight items shimmer skeleton
          Positioned(
            bottom: context.isRegularSmartphoneOrLess ? 100 : 0,
            right: rightPadding,
            left: leftPadding,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildShimmerBox(context, width: 120, height: 20), // Highlight Events text
                    _buildShimmerBox(context, width: 24, height: 24), // Circular indicator
                  ],
                ),
                const SizedBox(height: 20),
                context.isRegularSmartphoneOrLess
                    ? _buildSkeletonGrid(context)
                    : _buildSkeletonRow(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create a shimmer box
  Widget _buildShimmerBox(BuildContext context, {double width = 100, double height = 20}) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).appColors.bgPrimary!,
      highlightColor: Theme.of(context).appColors.bgBrandSolid!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).appColors.bgPrimary,
            borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  // Helper method to create a skeleton grid
  Widget _buildSkeletonGrid(BuildContext context) {
    return GridView.builder(
    padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: context.isRegularSmartphoneOrLess
          ? const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 8,
        childAspectRatio: 1.5,
      )
          : const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      itemCount: 4, // Placeholder item count
      itemBuilder: (BuildContext context, int index) {
        return _buildEventCardSkeleton(context);
      },
    );
  }

  // Helper method to create a skeleton row
  Widget _buildSkeletonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        4,
            (index) => Padding(
          padding: const EdgeInsets.only(left: 32),
          child: _buildEventCardSkeleton(context),
        ),
      ),
    );
  }

  // Helper method for card skeleton
  Widget _buildEventCardSkeleton(BuildContext context) {
    return Container(
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16), // Add corner radius here
    ),
      child: Card(
        color: Theme.of(context).appColors.bgPrimary!,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              _buildShimmerBox(context, width: 100, height: 20), // Title
              const SizedBox(height: 8),
              _buildShimmerBox(context, width: 150, height: 12), // Subtitle
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
