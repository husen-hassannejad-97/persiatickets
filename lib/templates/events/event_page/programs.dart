import 'package:billit_now/apps/helper/router/router_extention/events_router_extention.dart';
import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/dashed_line.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:billit_now/repositories/event/models/programs_model.dart';
import 'package:billit_now/repositories/event/models/programs_status.dart';
import 'package:billit_now/templates/events/widgets/app_collapse.dart';
import 'package:billit_now/templates/events/widgets/comming_soon_timer.dart';
import 'package:billit_now/templates/landing/utils.dart';
import 'package:flutter/material.dart';

class Programs extends BaseStatelessWidget {
  Programs({super.key, required this.data, required this.callback});

  final List<ProgramsModel> data;
  final Function(ProgramsModel) callback;

  @override
  Widget body(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
          width: constraint.maxWidth,
          padding: EdgeInsets.only(bottom: 40.0),
          child: AppCollapse(
            title: 'Programs',
            children: List.generate(
                data.length,
                (int index) =>
                    context.logicalWidth < context.logicalResponsive1200
                        ? _programsItemSm(
                            context,
                            data[index].date,
                            data[index].time,
                            data[index].status,
                            data[index].seatsCount,
                            data[index].priceRange,
                            callback)
                        : _programsItemLg(
                            context,
                            data[index].date,
                            data[index].time,
                            data[index].status,
                            data[index].seatsCount,
                            data[index].priceRange,
                            callback)),
          ));
    });
  }

  Widget _programsItemSm(
          BuildContext context,
          DateTime date,
          DateTime time,
          ProgramsStatus status,
          int seatsCount,
          String priceRange,
          Function(ProgramsModel) onTapReserveTicket) =>
      Container(
        margin: EdgeInsets.only(bottom: 16.0),
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
            border:
                Border.all(color: Theme.of(context).appColors.borderSecondary),
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date & Time & status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Date & Time
                Row(
                  children: [
                    Text(formatFullDate(date), // TODO Check
                        style: Theme.of(context)
                            .appTexts
                            .textMdSemiBold
                            .copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textPrimary900)),
                    SizedBox(width: 6),
                    Text('at',
                        style: Theme.of(context)
                            .appTexts
                            .textMdRegular
                            .copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textQuaternary500)),
                    SizedBox(width: 6),
                    Text(formatTime(time), // TODO Check
                        style: Theme.of(context)
                            .appTexts
                            .textMdSemiBold
                            .copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textPrimary900)),
                  ],
                ),
                // Status
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).appColors.borderSecondary),
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child: Text(status.en,
                      style: Theme.of(context).appTexts.textSmMedium.copyWith(
                          color: Theme.of(context).appColors.textSecondary700)),
                )
              ],
            ),
            // Seats & Price
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: 'Seats available:\t',
                      style: Theme.of(context).appTexts.textMdRegular.copyWith(
                          color: Theme.of(context).appColors.textTeritory600),
                      children: [
                        getSeatsString(context, seatsCount),
                        TextSpan(
                          text: '\nPrice range:\t',
                        ),
                        TextSpan(
                          text: priceRange,
                          style: Theme.of(context)
                              .appTexts
                              .textMdMedium
                              .copyWith(
                                  color: Theme.of(context)
                                      .appColors
                                      .textPrimary900),
                        )
                      ])),
            ),
            // Btn || Timer
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: DashedLine.horizontal(width: double.infinity, height: 1),
            ),
            status == ProgramsStatus.comingSoon
                ? CommingSoonTimer(
                    duration: // FIXME Hardcoded values, must get from constructor
                        Duration(days: 1, hours: 23, minutes: 13, seconds: 19),
                  )
                : AppButton.buttonPrimary(
                    context: context,
                    text: 'Reserve ticket',
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
                    onTap: () {
                      context.goEventMapPage();
                    }),
          ],
        ),
      );
  Widget _programsItemLg(
          BuildContext context,
          DateTime date,
          DateTime time,
          ProgramsStatus status,
          int seatsCount,
          String priceRange,
          Function(ProgramsModel) onTapReserveTicket) =>
      Container(
        margin: EdgeInsets.only(bottom: 16.0),
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
            border:
                Border.all(color: Theme.of(context).appColors.borderSecondary),
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date & Time
                Row(
                  children: [
                    Text(formatFullDate(date), // TODO Check
                        style: Theme.of(context)
                            .appTexts
                            .textMdSemiBold
                            .copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textPrimary900)),
                    SizedBox(width: 6),
                    Text('at',
                        style: Theme.of(context)
                            .appTexts
                            .textMdRegular
                            .copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textQuaternary500)),
                    SizedBox(width: 6),
                    Text(formatTime(time), // TODO Check
                        style: Theme.of(context)
                            .appTexts
                            .textMdSemiBold
                            .copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textPrimary900)),
                    SizedBox(width: 12.0),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  Theme.of(context).appColors.borderSecondary),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Text(status.en,
                          style: Theme.of(context)
                              .appTexts
                              .textSmMedium
                              .copyWith(
                                  color: Theme.of(context)
                                      .appColors
                                      .textSecondary700)),
                    )
                  ],
                ),
                // Seats & Price
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          text: 'Seats available:\t',
                          style: Theme.of(context)
                              .appTexts
                              .textMdRegular
                              .copyWith(
                                  color: Theme.of(context)
                                      .appColors
                                      .textTeritory600),
                          children: [
                            getSeatsString(context, seatsCount),
                            TextSpan(
                              text: '\t\t\t\t\t\tPrice range:\t',
                            ),
                            TextSpan(
                              text: priceRange,
                              style: Theme.of(context)
                                  .appTexts
                                  .textMdMedium
                                  .copyWith(
                                      color: Theme.of(context)
                                          .appColors
                                          .textPrimary900),
                            )
                          ])),
                )
              ],
            ),
            // Btn || Timer
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: DashedLine.vertical(width: 1, height: 60)),
                status == ProgramsStatus.comingSoon
                    ? CommingSoonTimer(
                        duration: Duration(
                            days: 1, hours: 23, minutes: 13, seconds: 19),
                      )
                    : AppButton.buttonPrimary(
                        context: context,
                        text: 'Reserve ticket',
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 14.0),
                        onTap: () {
                          context.goEventMapPage();
                        }),
              ],
            )
          ],
        ),
      );

  TextSpan getSeatsString(BuildContext context, int seats) {
    if (seats > 100) {
      return TextSpan(
          text: seats.toString(),
          style: Theme.of(context)
              .appTexts
              .textMdRegular
              .copyWith(color: Theme.of(context).appColors.textSuccessPrimary));
    } else if (seats < 10) {
      return TextSpan(
          text: 'Hurry! $seats seats remaining',
          style: Theme.of(context).appTexts.textMdRegular.copyWith(
              color: Theme.of(context).appColors.textErrorPrimary600));
    } else {
      return TextSpan(
          text: 'Only $seats seats left!',
          style: Theme.of(context).appTexts.textMdRegular.copyWith(
              color: Theme.of(context).appColors.textWarningPrimary600));
    }
  }
}
