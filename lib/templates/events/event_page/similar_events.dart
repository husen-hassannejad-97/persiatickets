import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_list_view.dart';
import 'package:billit_now/component/empty_modal.dart';
import 'package:billit_now/component/event_item.dart';
import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:billit_now/repositories/event/models/similar_events_model.dart';
import 'package:flutter/material.dart';

class SimilarEvents extends BaseStatefulWidget {
  const SimilarEvents({
    super.key,
    required this.data,
  });

  final List<SimilarEventsModel> data;

  @override
  State<SimilarEvents> createState() => _SimilarEventsState();
}

class _SimilarEventsState extends BaseWidgetState<SimilarEvents> {
  final ScrollController _scrollController = ScrollController();
  int scrollItemCount = 0;
  int currentItemIndex = 0;
  int eventListLength = 0;

  void _scrollToItem(int index) {
    double offset = index * 248; // each event item width is 248 fixed
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollNext(BuildContext context) {
    if (currentItemIndex < eventListLength - 1 &&
        currentItemIndex + scrollItemCount < eventListLength - 1) {
      _scrollToItem(currentItemIndex);
    } else {
      _scrollToItem(currentItemIndex);
    }
  }

  void _scrollBack(BuildContext context) {
    if (0 < currentItemIndex && 0 < currentItemIndex - scrollItemCount) {
      _scrollToItem(currentItemIndex - scrollItemCount);
    } else {
      _scrollToItem(currentItemIndex);
    }
  }

  @override
  Widget body(BuildContext context) {
    return _stateSuccess(context);
  }

  Widget _stateSuccess(BuildContext context) {
    return widget.data.isEmpty
        ? Container()
        : Container(
            padding: EdgeInsets.only(
                top: context.isRegularSmartphoneOrLess ? 24 : 48, bottom: 48),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Similar events',
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
                    Row(children: [
                      // view all Btn
                      context.isRegularSmartphoneOrLess
                          ? Container()
                          : AppButton.buttonTertiary(
                              context: context,
                              text: 'View all events',
                              textStyle: Theme.of(context)
                                  .appTexts
                                  .textMdSemiBold
                                  .copyWith(
                                      color: Theme.of(context)
                                          .appColors
                                          .buttonTeritoryFg),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return EmptyModal.show(context: context);
                                  },
                                );
                              }),
                      const SizedBox(width: 32),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        context: context,
                        onTap: () => _scrollNext(context),
                      ),
                      SizedBox(
                          width: context.isRegularSmartphoneOrLess ? 6 : 16),
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
                              color:
                                  Theme.of(context).appColors.borderSecondary),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          context: context,
                          onTap: () => _scrollBack(context),
                        ),
                      ),
                    ])
                  ],
                ),
                const SizedBox(height: 53),
                // slider
                AppListView.def(
                  controller: _scrollController,
                  items: widget.data.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return EventItem.def(
                            status: item.status,
                            image: item.image,
                            title: item.title,
                            date: item.date,
                            location: item.location,
                            price: item.price,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return EmptyModal.show(context: context);
                                },
                              );
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
                            text: 'View all events',
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
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return EmptyModal.show(context: context);
                                },
                              );
                            }),
                      )
                    : Container(),
              ],
            ),
          );
  }
}
