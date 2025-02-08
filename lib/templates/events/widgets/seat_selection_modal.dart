import 'package:billit_now/apps/helper/router/router_extention/events_router_extention.dart';
import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/repositories/event_map/models/map_model.dart';
import 'package:billit_now/templates/events/widgets/app_collapse.dart';
import 'package:flutter/material.dart';

class SeatSelectionModal extends StatelessWidget {
  const SeatSelectionModal(
      {super.key,
      required this.currency,
      required this.selectedSeats,
      required this.onRemoveSeat});

  final String currency;
  final List<MapSeatModel> selectedSeats;
  final Function(int index) onRemoveSeat;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // selected seats collapse
        Container(
          width: context.logicalWidth > 700 ? 400.0 : context.logicalWidthSA,
          padding: context.logicalWidth > 700
              ? const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0)
              : null,
          margin: context.logicalWidth > 700
              ? const EdgeInsets.only(right: 24.0)
              : null,
          decoration: BoxDecoration(
              color: Theme.of(context).appColors.bgPrimary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              )),
          child: AppCollapse(
              title:
                  '${selectedSeats.length} Selected seat${selectedSeats.length == 1 ? '' : 's'}',
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    constraints: BoxConstraints(
                      maxHeight: 200.0, // Set your desired max height here
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).appColors.borderSecondary,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: ListView(
                        shrinkWrap: true,
                        children: List.generate(selectedSeats.length, (index) {
                          return Container(
                            decoration: BoxDecoration(
                                border: index == 0
                                    ? null
                                    : Border(
                                        top: BorderSide(
                                            color: Theme.of(context)
                                                .appColors
                                                .borderSecondary,
                                            width: 1.0))),
                            child: Container(
                              padding: EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                top: index == 0 ? 0.0 : 12.0,
                                bottom: index == 0 ? 12.0 : 0.0,
                              ),
                              child: _item(
                                  context,
                                  selectedSeats[index].sectionName ?? '',
                                  selectedSeats[index].seatNumber.toString(),
                                  currency,
                                  selectedSeats[index].price.toString(), () {
                                onRemoveSeat(index);
                              }),
                            ),
                          );
                        })))
              ]),
        ),
        // total
        Container(
            width: context.logicalWidth > 700 ? 400.0 : context.logicalWidthSA,
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            margin: context.logicalWidth > 700
                ? const EdgeInsets.only(right: 24.0)
                : null,
            color: Theme.of(context).appColors.bgPrimary,
            child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total amount (Incl. fees)',
                        style: Theme.of(context)
                            .appTexts
                            .textLgSemiBold
                            .copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textPrimary900)),
                    Text(
                        '$currency${selectedSeats.map((e) => e.price).reduce((a, b) => a! + b!)}',
                        style: Theme.of(context)
                            .appTexts
                            .textLgSemiBold
                            .copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textPrimary900)),
                  ],
                ))),
        // botton Btns
        Container(
            width: context.logicalWidth > 700 ? 400.0 : context.logicalWidthSA,
            padding:
                const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
            margin: context.logicalWidth > 700
                ? const EdgeInsets.only(bottom: 24.0, right: 24.0)
                : null,
            decoration: BoxDecoration(
                color: Theme.of(context).appColors.bgPrimary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                )),
            child: SizedBox(
              width: double.infinity,
              child: AppButton.buttonPrimary(
                  context: context,
                  text: 'Continue',
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  onTap: () {
                    context.goEventCheckout();
                  }),
            ))
      ],
    );
  }

  _item(BuildContext context, String section, String seatNumber,
          String currency, String price, Function() onRemove) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(section,
                  style: Theme.of(context).appTexts.textMdRegular.copyWith(
                      color: Theme.of(context).appColors.textTeritory600)),
              AppButton.buttonTertiary(
                  context: context,
                  text: 'Remove',
                  bgHoverColor: Colors.transparent,
                  textColor: Theme.of(context).appColors.buttonTeritoryColorFg,
                  onTap: onRemove)
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Seat $seatNumber',
                  style: Theme.of(context).appTexts.textMdMedium.copyWith(
                      color: Theme.of(context).appColors.textPrimary900)),
              Text('$currency$price',
                  style: Theme.of(context).appTexts.textMdMedium.copyWith(
                      color: Theme.of(context).appColors.textPrimary900)),
            ],
          )
        ],
      );
}
