import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:billit_now/templates/events/widgets/accessibility_modal.dart';
import 'package:billit_now/templates/events/widgets/price_modal.dart';
import 'package:billit_now/templates/landing/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HeaderSelectionSection extends BaseStatefulWidget {
  HeaderSelectionSection(
      {super.key,
      required this.title,
      required this.isLiked,
      required this.date,
      required this.location,
      required this.startPrice,
      required this.endPrice,
      required this.currency,
      required this.onTapLike,
      required this.accessibilityIsApplyed,
      required this.onApplyAccessibility,
      required this.minPrice,
      required this.maxPrice,
      required this.onMinMaxPriceChanged,
      required this.onClearMinMaxPrice,
      required this.isFeesCalculateOn,
      required this.onFeesCalculateChanged});

  final String title;
  final DateTime date;
  final String location;
  final double startPrice;
  final double endPrice;
  final String currency;
  final bool isLiked;
  final Function(bool islike) onTapLike;
  final bool accessibilityIsApplyed;
  final Function(bool isApplied) onApplyAccessibility;
  final double minPrice;
  final double maxPrice;
  final Function(double min, double max) onMinMaxPriceChanged;
  final Function() onClearMinMaxPrice;
  final bool isFeesCalculateOn;
  final Function(bool value) onFeesCalculateChanged;

  @override
  State<HeaderSelectionSection> createState() => _MapList();
}

class _MapList extends BaseWidgetState<HeaderSelectionSection> {
  @override
  Widget body(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: context.logicalWidth < 1100 ? 10.0 : 70.0,
          right: 32.0,
          left: 32.0,
          bottom: 24.0),
      color: Theme.of(context).appColors.bgPrimary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back to event page Btn
          context.logicalWidth < 1100
              ? Container()
              : SizedBox(
                  width: 168,
                  child: AppButton.buttonIcon(AppIconName.uea1fChevronLeft,
                      text: 'Back to event page',
                      bgColor: Colors.transparent,
                      bgHoverColor: Colors.transparent,
                      textColor: Theme.of(context).appColors.buttonTeritoryFg,
                      context: context, onTap: () {
                    context.pop();
                  }),
                ),
          // Title and Heart
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    context.logicalWidth < 1100
                        ? AppButton.buttonIcon(AppIconName.uea1fChevronLeft,
                            iconSize: 20,
                            bgColor: Colors.transparent,
                            bgHoverColor: Colors.transparent,
                            textColor: Colors.transparent,
                            context: context, onTap: () {
                            context.pop();
                          })
                        : Container(),
                    Text(widget.title,
                        style: Theme.of(context)
                            .appTexts
                            .displayXsSemibold
                            .copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textPrimary900)),
                  ],
                ),
                AppButton.buttonIcon(
                    widget.isLiked
                        ? AppIconName.ueb3aHeartRed
                        : AppIconName.ueb3aHeart,
                    bgColor: Colors.transparent,
                    bgHoverColor: Colors.transparent,
                    textColor: Theme.of(context).appColors.fgPrimary900,
                    iconSize: 24,
                    context: context, onTap: () {
                  widget.onTapLike(!widget.isLiked);
                })
              ],
            ),
          ),
          // Date, time, Location
          Text(
              '${formatTimeWithoutYear(widget.date)} at ${formatTimeHourMinutes(widget.date)} . ${widget.location}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).appTexts.textMdRegular.copyWith(
                  color: Theme.of(context).appColors.textTeritory600)),
          // Prices
          context.logicalWidth < 1100
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                      'From ${widget.currency}${formatPrice(widget.startPrice)} to ${widget.currency}${formatPrice(widget.endPrice)}',
                      style: Theme.of(context).appTexts.textMdSemiBold.copyWith(
                          color: Theme.of(context).appColors.textPrimary900)),
                ),
          // filters
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(children: [
              PriceModal(
                  controller: OverlayPortalController(),
                  offset: Offset(0, 30),
                  isFeesOn: true,
                  onFeesChanged: (bool isFeesOn) {},
                  minValue: widget.minPrice,
                  maxValue: widget.maxPrice,
                  onMinMaxValueChanged: widget.onMinMaxPriceChanged,
                  onClearMinMaxPrice: widget.onClearMinMaxPrice,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            color: Theme.of(context).appColors.borderPrimary)),
                    child: Text('Price (Incl. fees)',
                        style: Theme.of(context)
                            .appTexts
                            .textSmSemiBord
                            .copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .buttonSecondaryFg)),
                  )),
              SizedBox(width: 8.0),
              AccessibilityModal(
                  controller: OverlayPortalController(),
                  offset: context.logicalWidth < 500
                      ? Offset(-135, 30)
                      : Offset(0, 30),
                  isApplyed: widget.accessibilityIsApplyed,
                  onApply: widget.onApplyAccessibility,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            color: Theme.of(context).appColors.borderPrimary)),
                    child: Text('Accessibility',
                        style: Theme.of(context)
                            .appTexts
                            .textSmSemiBord
                            .copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .buttonSecondaryFg)),
                  ))
            ]),
          )
        ],
      ),
    );
  }
}
