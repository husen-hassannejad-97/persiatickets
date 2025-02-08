import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/seat_section_item.dart';
import 'package:billit_now/repositories/event_map/models/map_model.dart';
import 'package:billit_now/repositories/event_map/models/sort_filter.dart';
import 'package:billit_now/templates/events/widgets/sorting_modal.dart';
import 'package:flutter/material.dart';

class SelectSection extends StatefulWidget {
  const SelectSection(
      {super.key,
      required this.onApplySortFilter,
      required this.currency,
      required this.seats,
      required this.onSelectSeat});

  final Function(SortFilter value) onApplySortFilter;
  final String currency;
  final List<MapSeatModel> seats;
  final Function(MapSeatModel seat) onSelectSeat;

  @override
  State<SelectSection> createState() => _SelectSectionState();
}

class _SelectSectionState extends State<SelectSection> {
  SortFilter initFilterValue = SortFilter.lowestPrice;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
      color: Theme.of(context).appColors.bgPrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select Your Section',
              style: Theme.of(context)
                  .appTexts
                  .textXlSemibold
                  .copyWith(color: Theme.of(context).appColors.textPrimary900)),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${widget.seats.length} Sections',
                      style: Theme.of(context).appTexts.textMdRegular.copyWith(
                          color: Theme.of(context).appColors.textPrimary900)),
                  SortingModal(
                      controller: OverlayPortalController(),
                      offset: Offset(0, 30),
                      initValue: initFilterValue,
                      sortList: SortFilter.values,
                      onApply: (SortFilter filter) {
                        widget.onApplySortFilter(filter);

                        setState(() {
                          initFilterValue = filter;
                        });
                      },
                      child: SizedBox(
                        width: 170.0,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(initFilterValue.title,
                                  style: Theme.of(context)
                                      .appTexts
                                      .textMdSemiBold
                                      .copyWith(
                                          color: Theme.of(context)
                                              .appColors
                                              .buttonTeritoryFg)),
                              SizedBox(width: 6.0),
                              AppIcon.button(
                                  appIconName:
                                      AppIconName.uea24ChevronSelectorVertical,
                                  color: Theme.of(context)
                                      .appColors
                                      .buttonTeritoryFg,
                                  context: context)
                            ]),
                      ))
                ]),
          ),
          Container(
            constraints: BoxConstraints(minHeight: context.logicalHeightSA),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.seats.length,
                itemBuilder: (BuildContext context, int index) {
                  return SeatSectionItem(
                    image: widget.seats[index].image ?? '',
                    score: widget.seats[index].dealScore ?? 0,
                    price: widget.seats[index].price.toString(),
                    currency: widget.currency,
                    row: widget.seats[index].row.toString(),
                    seatNumber: widget.seats[index].seatNumber ?? 0,
                    onTap: () => widget.onSelectSeat(widget.seats[index]),
                  );
                }),
          )
        ],
      ),
    );
  }
}
