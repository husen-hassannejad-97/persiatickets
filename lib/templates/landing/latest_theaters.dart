import 'package:billit_now/apps/helper/router/router_extention/events_router_extention.dart';
import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_list_view.dart';
import 'package:billit_now/component/event_item.dart';
import 'package:billit_now/core/localization/languages.dart';
import 'package:billit_now/features/base/base_bloc_stateful_widget.dart';
import 'package:billit_now/repositories/shared/errors.dart';
import 'package:billit_now/templates/landing/utils.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';
import 'package:shimmer/shimmer.dart';

import '../../apps/event_data.dart';
import '../../core/localization/layout_direction.dart';
import '../../features/base/base_bloc.dart';
import '../../features/base/base_bloc_event.dart';
import '../../features/base/base_bloc_state.dart';
import '../../repositories/event/event_repository.dart';
import '../../repositories/event/input_models/get_events_input_model.dart';
import '../../repositories/event/models/event_category_model.dart';
import '../../repositories/event/models/event_model.dart';
import '../../repositories/event/models/event_range_model.dart';
import '../../repositories/shared/result.dart';

class LatestTheatersEvents extends BaseBlocEvent {}
class LatestTheatersFetchData extends LatestTheatersEvents {
  EventRangeModel eventRangeModel;
  Language language;
  LatestTheatersFetchData(this.eventRangeModel, this.language);
}
class ChangeCurrentItem extends BaseBlocEvent {
  final int newItemIndex;
  ChangeCurrentItem(this.newItemIndex);
}
class LatestTheatersVisible extends LatestTheatersEvents{}

class LatestTheatersStateSuccess extends BaseBlocState {
  final List<EventModel> result;
  final int currentItemIndex;
  LatestTheatersStateSuccess({
    required this.result,
    required this.currentItemIndex
  });
}


@singleton
class LatestTheatersBloc extends BaseBloc<BaseBlocEvent, BaseBlocState> {
  final EventRepository eventRepo;
  LatestTheatersBloc(this.eventRepo) {
    on<LatestTheatersFetchData>((event, emit) async {
      try {
        emit(StateLoading());
        final result = event.eventRangeModel == EventRangeModel.any_dates ?
        await eventRepo.getEvents(GetEventsInputModel(
          eventCategoryModel: EventCategoryModel.theater,
          limit: 10,
        )) :
        await eventRepo.getEventsRange(GetEventsInputModel(
          eventCategoryModel: EventCategoryModel.theater,
          limit: 10,
        ),
        event.eventRangeModel);
        if (result is Success<List<EventModel>>) {
          emit(LatestTheatersStateSuccess(result: result.data, currentItemIndex: 0));
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
    on<ChangeCurrentItem>((event, emit) {
      if(state is LatestTheatersStateSuccess) {
        emit(
            LatestTheatersStateSuccess(
              result: (state as LatestTheatersStateSuccess).result,
              currentItemIndex: event.newItemIndex,
            )
        );
      }
    });
  }

  int getEventListLength() {
    if(state is LatestTheatersStateSuccess) {
      return (state as LatestTheatersStateSuccess).result.length;
    } else {
      return -1;
    }
  }

  int getCurrentItemIndex() {
    if(state is LatestTheatersStateSuccess) {
      return (state as LatestTheatersStateSuccess).currentItemIndex;
    } else {
      return -1;
    }
  }

  @override
  bool eventToDebounce(BaseBlocEvent currentEvent) {
    return currentEvent is LatestTheatersFetchData;
  }

  @override
  Duration eventDebounceThreshold(BaseBlocEvent lastEvent, BaseBlocEvent event) {
    if(event is LatestTheatersFetchData) {
      if(lastEvent is LatestTheatersFetchData && (
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
}

class LatestTheaters extends BaseBlocStatefulWidget {
  const LatestTheaters({
    super.key,
    required this.title,
    required this.viewAllBtnText,
    required this.beganColorGradient,
    required this.scrollCount,
  });

  final String title;
  final String viewAllBtnText;
  final Color beganColorGradient;
  final int scrollCount;

  @override
  State<LatestTheaters> createState() => _LatestTheatersState();
}

class _LatestTheatersState
    extends BaseBlocStateWidget<LatestTheaters, LatestTheatersBloc> {
  late LatestTheatersBloc bloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void preConfigBloc(BuildContext context, LatestTheatersBloc bloc) {
    this.bloc = bloc;
  }

  void _scrollToItem(int index) {
    double offset = index * 248; // each event item width is 248 fixed
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollNext(BuildContext context) {
    int currentItemIndex = bloc.getCurrentItemIndex();
    int eventListLength = bloc.getEventListLength();
    if (currentItemIndex < eventListLength - 1 &&
        currentItemIndex + widget.scrollCount < eventListLength - 1) {
      _scrollToItem(currentItemIndex);
      addEvent(context, ChangeCurrentItem(currentItemIndex + widget.scrollCount));
    } else {
      _scrollToItem(currentItemIndex);
      addEvent(context, ChangeCurrentItem(eventListLength - 1));
    }
  }

  void _scrollBack(BuildContext context) {
    int currentItemIndex = bloc.getCurrentItemIndex();
    if (0 < currentItemIndex && 0 < currentItemIndex - widget.scrollCount) {
      _scrollToItem(currentItemIndex - widget.scrollCount);
      addEvent(context, ChangeCurrentItem(currentItemIndex - widget.scrollCount));
    } else {
      _scrollToItem(currentItemIndex);
      addEvent(context, ChangeCurrentItem(0));
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  bool get visibilityDetection => true;
  @override
  Key get visibilityKey => Key("latest");

  @override
  void onVisible(BuildContext context) {
    if (kDebugMode) {
      print("Latest is Visible");
    }
    addEvent(context, LatestTheatersVisible());
  }

  @override
  void onInvisible(BuildContext context) {
    if (kDebugMode) {
      print("Latest is InVisible");
    }
  }

  @override
  Widget body(BuildContext context, BaseBlocState state) {
    if (state is StateLoading) {
      return _stateLoading(context);
    } else if (state is StateError) {
      return _stateError(context);
    } else if (state is LatestTheatersStateSuccess) {
      if(state.result.isEmpty) {
        return _stateEmpty(context);
      }
      return _stateSuccess(context, state.result);
    } else {
      return _stateInitial(context);
    }
  }

  Widget _stateInitial(BuildContext context) {
    final buttonHeight = 40.0;
    final textHeight = 20.0;
    final buttonStroke = 2.0;
    final buttons = [
      context.isRegularSmartphoneOrLess
          ? Container()
          : Stack(
        alignment: Alignment.center,
        children: [
          Shimmer.fromColors(
              baseColor:
              Theme.of(context).appColors.bgPrimary,
              highlightColor:
              Theme.of(context).appColors.bgBrand,
              child: Container(
                width: buttonHeight * 4,
                height: buttonHeight,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        buttonHeight / 3),
                    color: Theme.of(context)
                        .appColors
                        .bgPrimary),
              )),
          Container(
            width: buttonHeight * 4 - 2 * buttonStroke,
            height: buttonHeight - 2 * buttonStroke,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    (buttonHeight - 2 * buttonStroke) / 3),
                color: Theme.of(context).appColors.bgPrimary),
          )
        ],
      ),
      const SizedBox(width: 32),
      Stack(
        alignment: Alignment.center,
        children: [
          Shimmer.fromColors(
              baseColor: Theme.of(context).appColors.bgPrimary,
              highlightColor: Theme.of(context).appColors.bgBrand,
              child: Container(
                width: buttonHeight,
                height: buttonHeight,
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(buttonHeight / 2),
                    color: Theme.of(context).appColors.bgPrimary),
              )),
          Container(
            width: buttonHeight - 2 * buttonStroke,
            height: buttonHeight - 2 * buttonStroke,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    (buttonHeight - 2 * buttonStroke) / 2),
                color: Theme.of(context).appColors.bgPrimary),
          )
        ],
      ),
      SizedBox(width: context.isRegularSmartphoneOrLess ? 6 : 16),
      Stack(
        alignment: Alignment.center,
        children: [
          Shimmer.fromColors(
              baseColor: Theme.of(context).appColors.bgPrimary,
              highlightColor: Theme.of(context).appColors.bgBrand,
              child: Container(
                width: buttonHeight,
                height: buttonHeight,
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(buttonHeight / 2),
                    color: Theme.of(context).appColors.bgPrimary),
              )),
          Container(
            width: buttonHeight - 2 * buttonStroke,
            height: buttonHeight - 2 * buttonStroke,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    (buttonHeight - 2 * buttonStroke) / 2),
                color: Theme.of(context).appColors.bgPrimary),
          )
        ],
      )
    ];
    final firstRow = [
      Shimmer.fromColors(
          baseColor: Theme.of(context).appColors.textPrimary900,
          highlightColor: Theme.of(context).appColors.bgBrand,
          child: Text(
            widget.title,
            style: context.isRegularSmartphoneOrLess
                ? Theme.of(context).appTexts.displayXsSemibold.copyWith(
                color: Theme.of(context).appColors.textPrimary900)
                : Theme.of(context).appTexts.displaySmSemiBold.copyWith(
                color: Theme.of(context).appColors.textPrimary900),
          )),
      Row(
        children: getLayoutDirection() == LayoutDirection.ltr ?
        buttons : buttons.reversed.toList(),
      )
    ];
    return Container(
      padding: EdgeInsets.only(
          left: context.isRegularSmartphoneOrLess ? 16 : 96,
          right: context.isRegularSmartphoneOrLess ? 0 : 96,
          top: context.isRegularSmartphoneOrLess ? 24 : 48,
          bottom: 48),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: getLayoutDirection() == LayoutDirection.ltr ?
            firstRow : firstRow.reversed.toList(),
          ),
          const SizedBox(height: 53),
          AppListView(
              controller: _scrollController,
              items: List.generate(10, (index) {
                return Builder(builder: (context) {
                  final itemHeight = 230.0;
                  final itemWidth = 248.0;
                  final imageHeight = 140.0;
                  final cardCornerRadius = 16.0;
                  final cardStroke = 2.0;
                  final cardInternalPadding = 12.0;
                  final itemMargin = 4.0;
                  return SizedBox(
                    width: itemWidth,
                    height: itemHeight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Shimmer.fromColors(
                                    baseColor:
                                    Theme.of(context).appColors.bgPrimary,
                                    highlightColor:
                                    Theme.of(context).appColors.bgBrand,
                                    child: Container(
                                      width: itemWidth,
                                      height: imageHeight,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            cardCornerRadius),
                                        color: Theme.of(context)
                                            .appColors
                                            .bgPrimary,
                                      ),
                                    )),
                                Container(
                                  width: itemWidth - 2 * cardStroke,
                                  height: imageHeight - 2 * cardStroke,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        cardCornerRadius - cardStroke),
                                    color:
                                    Theme.of(context).appColors.bgPrimary,
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Shimmer.fromColors(
                                      baseColor:
                                      Theme.of(context).appColors.bgPrimary,
                                      highlightColor:
                                      Theme.of(context).appColors.bgBrand,
                                      child: Container(
                                        width: textHeight * 4,
                                        height: textHeight,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                textHeight / 4),
                                            color: Theme.of(context)
                                                .appColors
                                                .bgPrimary),
                                      )),
                                  Shimmer.fromColors(
                                      baseColor:
                                      Theme.of(context).appColors.bgPrimary,
                                      highlightColor:
                                      Theme.of(context).appColors.bgBrand,
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
                                  borderRadius:
                                  BorderRadius.circular(textHeight / 4),
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
                                  borderRadius:
                                  BorderRadius.circular(textHeight / 4),
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
                                  borderRadius:
                                  BorderRadius.circular(textHeight / 4),
                                  color: Theme.of(context).appColors.bgPrimary),
                            ))
                      ],
                    ),
                  );
                });
              })),
          context.isRegularSmartphoneOrLess
              ? Container(
            width: 160,
            padding: EdgeInsets.only(
                top: context.isRegularSmartphoneOrLess ? 48 : 0),
            child: Container(
              height: 40,
            ),
          )
              : Container(),
        ],
      ),
    );
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

  Widget _stateSuccess(BuildContext context, List<EventModel> eventList) {
    final viewAllButtons = // view all Btn
    context.isRegularSmartphoneOrLess
        ? Container()
        : AppButton.buttonTertiary(
        context: context,
        text: widget.viewAllBtnText,
        textStyle: Theme.of(context)
            .appTexts
            .textMdSemiBold
            .copyWith(
            color: Theme.of(context)
                .appColors
                .buttonTeritoryFg),
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 8),
        onTap: () {});
    final chevronButtons = [
      // left arrow btn
      AppButton.buttonIcon(
        AppIconName.uea1fChevronLeft,
        bgColor: Colors.transparent,
        bgHoverColor: Colors.transparent,
        textColor: Colors.transparent,
        padding: const EdgeInsets.all(14),
        iconSize: context.isRegularSmartphoneOrLess ? 15 : 20,
        border: Border.all(
            color: Theme.of(context).appColors.borderSecondary),
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        context: context,
        onTap: () => getLayoutDirection() == LayoutDirection.ltr ?
        _scrollBack(context) : _scrollNext(context),
      ),
      SizedBox(width: context.isRegularSmartphoneOrLess ? 6 : 16),
      // right arrow btn
      Padding(
        padding: EdgeInsets.only(
            right: context.isRegularSmartphoneOrLess ? 16 : 0),
        child: AppButton.buttonIcon(
          AppIconName.uea21ChevronRight,
          bgColor: Colors.transparent,
          bgHoverColor: Colors.transparent,
          textColor: Colors.transparent,
          padding: const EdgeInsets.all(14),
          iconSize: context.isRegularSmartphoneOrLess ? 15 : 20,
          border: Border.all(
              color: Theme.of(context).appColors.borderSecondary),
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          context: context,
          onTap: () => getLayoutDirection() == LayoutDirection.ltr ?
          _scrollNext(context) : _scrollBack(context),
        ),
      ),
    ];
    final firstRow = [
      Text(
        widget.title,
        style: context.isRegularSmartphoneOrLess
            ? Theme.of(context).appTexts.displayXsSemibold.copyWith(
            color: Theme.of(context).appColors.textPrimary900)
            : Theme.of(context).appTexts.displaySmSemiBold.copyWith(
            color: Theme.of(context).appColors.textPrimary900),
      ),
      Row(children: getLayoutDirection() == LayoutDirection.ltr ?
      ([viewAllButtons] + [SizedBox(width: 32,)] + chevronButtons)
          :
      (chevronButtons + [SizedBox(width: 32,)] + [viewAllButtons])
      )
    ];
    return eventList.isEmpty
        ? Container()
        : Container(
            padding: EdgeInsets.only(
                left: context.isRegularSmartphoneOrLess ? 16 : 96,
                right: context.isRegularSmartphoneOrLess ? 0 : 96,
                top: context.isRegularSmartphoneOrLess ? 24 : 48,
                bottom: 48),
            decoration: BoxDecoration(
                gradient: RadialGradient(
              radius: 5,
              colors: [
                widget.beganColorGradient,
                Theme.of(context).appColors.bgPrimary,
              ],
              stops: [0.9, 1],
              center: Alignment(0.0, 10.5),
            )),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: getLayoutDirection() == LayoutDirection.ltr ?
                  firstRow : firstRow.reversed.toList(),
                ),
                const SizedBox(height: 53),
                // slider
                AppListView.def(
                  controller: _scrollController,
                  items: eventList.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return EventItem.def(
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
                            onTapLike: () {});
                      },
                    );
                  }).toList(),
                ),

                context.isRegularSmartphoneOrLess
                    ? Container(
                        width: 160,
                        padding: EdgeInsets.only(
                            top: context.isRegularSmartphoneOrLess ? 48 : 0),
                        child: AppButton.buttonTertiary(
                            context: context,
                            text: widget.viewAllBtnText,
                            textStyle: Theme.of(context)
                                .appTexts
                                .textMdSemiBold
                                .copyWith(
                                    color: Theme.of(context)
                                        .appColors
                                        .buttonTeritoryFg),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            bgColor: Theme.of(context).appColors.bgSecondary,
                            border: Border.all(
                                color:
                                    Theme.of(context).appColors.borderPrimary),
                            onTap: () {}),
                      )
                    : Container(),
              ],
            ),
          );
  }

  @override
  void consumeState(BuildContext context, BaseBlocState state) {
    if (state is LatestTheatersStateSuccess) {
    }
  }
}
