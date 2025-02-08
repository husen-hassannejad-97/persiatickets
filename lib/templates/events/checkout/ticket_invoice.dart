import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/empty_modal.dart';
import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:billit_now/repositories/event/models/why_persia_tickets_model.dart';
import 'package:billit_now/repositories/event_map/models/map_model.dart';
import 'package:billit_now/templates/events/widgets/checkout_timer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TicketInvoice extends BaseStatefulWidget {
  const TicketInvoice({
    super.key,
    required this.scrollController,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.whysList,
    required this.selectedSeats,
    required this.totalTickets,
    required this.totalAmount,
    required this.feePercent,
    required this.bookingFees,
    required this.currency,
    required this.removeSeat,
    required this.duration,
    required this.durationTime,
  });

  final ScrollController scrollController;
  final String title;
  final DateTime date;
  final String time;
  final String location;
  final List<WhyPersiaTicketsModel> whysList;
  final List<MapSeatModel> selectedSeats;
  final double totalTickets;
  final double feePercent;
  final double bookingFees;
  final double totalAmount;
  final String currency;
  final Function(int index) removeSeat;
  final Duration duration;
  final Function(Duration d) durationTime;

  @override
  State<TicketInvoice> createState() => _TicketInVoiceState();
}

class _TicketInVoiceState extends State<TicketInvoice> {
  List<MapSeatModel> selectedSeats = [];

  @override
  void initState() {
    super.initState();
    selectedSeats = widget.selectedSeats;
  }

  @override
  Widget build(BuildContext context) {
    bool isSmScreen = context.logicalWidth < 1100;
    return ListView(
      controller: isSmScreen ? widget.scrollController : null,
      children: [
        isSmScreen ? Container() : _timer(),
        __venueInfo(isSmScreen),
        _tickets(widget.totalTickets, widget.feePercent, widget.bookingFees,
            widget.totalAmount, widget.currency),
        _whyPerisaTickets(widget.whysList)
      ],
    );
  }

  Widget _timer() => Container(
      margin: EdgeInsets.only(top: 80.0, right: 32.0, left: 32.0),
      child: CheckoutTimer(
          duration: widget.duration,
          currentTime: (Duration d) {
            widget.durationTime(d);
          }));

  Widget __venueInfo(bool isSmScreen) => Container(
      margin: EdgeInsets.only(
          top: isSmScreen ? 130.0 : 20.0, right: 32.0, left: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title,
              style: Theme.of(context)
                  .appTexts
                  .displayXsSemibold
                  .copyWith(color: Theme.of(context).appColors.textPrimary900)),
          SizedBox(height: 4.0),
          Text(
              '${DateFormat('EEE, d. MMM').format(widget.date)} at ${widget.time} . ${widget.location}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).appTexts.textMdRegular.copyWith(
                  color: Theme.of(context).appColors.textTeritory600)),
          SizedBox(height: 24.0),
        ],
      ));

  Widget _tickets(double totalTickets, double feeAmount, double bookingFees,
          double totalAmount, String currency) =>
      Container(
        margin: EdgeInsets.only(right: 32.0, left: 32.0),
        padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 16.0),
        decoration: BoxDecoration(
            border:
                Border.all(color: Theme.of(context).appColors.borderSecondary),
            borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          children: [
            ...List.generate(
                selectedSeats.length,
                (int index) => Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Row
                                  RichText(
                                      text: TextSpan(
                                          text: 'Row: ',
                                          style: Theme.of(context)
                                              .appTexts
                                              .textMdRegular
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .appColors
                                                      .textTeritory600),
                                          children: [
                                        TextSpan(
                                          text: selectedSeats[index]
                                              .row
                                              .toString(),
                                          style: Theme.of(context)
                                              .appTexts
                                              .textMdMedium
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .appColors
                                                      .textPrimary900),
                                        ),
                                      ])),
                                  SizedBox(
                                    height: 20.0,
                                    child: VerticalDivider(
                                      color: Theme.of(context)
                                          .appColors
                                          .borderSecondary,
                                    ),
                                  ),
                                  // Seat
                                  RichText(
                                      text: TextSpan(
                                          text: 'Seat: ',
                                          style: Theme.of(context)
                                              .appTexts
                                              .textMdRegular
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .appColors
                                                      .textTeritory600),
                                          children: [
                                        TextSpan(
                                          text: selectedSeats[index]
                                              .seatNumber
                                              .toString(),
                                          style: Theme.of(context)
                                              .appTexts
                                              .textMdMedium
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .appColors
                                                      .textPrimary900),
                                        ),
                                      ])),
                                  SizedBox(
                                    height: 20.0,
                                    child: VerticalDivider(
                                      color: Theme.of(context)
                                          .appColors
                                          .borderSecondary,
                                    ),
                                  ),
                                  // Price
                                  RichText(
                                      text: TextSpan(
                                          text: 'Price: ',
                                          style: Theme.of(context)
                                              .appTexts
                                              .textMdRegular
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .appColors
                                                      .textTeritory600),
                                          children: [
                                        TextSpan(
                                          text: currency +
                                              selectedSeats[index]
                                                  .price
                                                  .toString(),
                                          style: Theme.of(context)
                                              .appTexts
                                              .textMdMedium
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .appColors
                                                      .textPrimary900),
                                        ),
                                      ])),
                                ],
                              ),
                              AppButton.buttonIcon(AppIconName.ueae5Trash03,
                                  iconSize: 20.0,
                                  bgColor: Colors.transparent,
                                  bgHoverColor: Colors.transparent,
                                  textColor: Colors.transparent,
                                  context: context,
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (context) => EmptyModal.value(
                                            icon: AppIconName.ueb5aAlertOctagon,
                                            title: 'Remove Ticket from Invoice',
                                            subTitle:
                                                'Are you sure you want to remove this ticket from your invoice? This action cannot be undone, and the total amount will be updated accordingly.',
                                            cancelBtnTitle: 'Cancel',
                                            cancelBtnBgColor:
                                                Colors.transparent,
                                            onTapCancelBtn: () {
                                              context.pop();
                                            },
                                            processBtnTitle: 'Yes, Remove',
                                            processBtnBgColor: Theme.of(context)
                                                .appColors
                                                .bgBrand,
                                            onTapProcessBtn: () {
                                              widget.removeSeat(index);
                                              if (selectedSeats.isEmpty) {
                                                context.pop();
                                              }
                                            },
                                          )))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Divider(
                              color:
                                  Theme.of(context).appColors.borderSecondary,
                            ),
                          ),
                        ],
                      ),
                    )),
            // total tickets
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total tickets',
                      style: Theme.of(context).appTexts.textMdSemiBold.copyWith(
                          color: Theme.of(context).appColors.textPrimary900)),
                  Text(currency + totalTickets.toString(),
                      style: Theme.of(context).appTexts.textMdMedium.copyWith(
                          color: Theme.of(context).appColors.textPrimary900))
                ],
              ),
            ),
            // booking fees
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Booking fees (${feeAmount.toString().split('.').last}%)',
                      style: Theme.of(context).appTexts.textMdRegular.copyWith(
                          color: Theme.of(context).appColors.textPrimary900)),
                  Text(currency + bookingFees.toString(),
                      style: Theme.of(context).appTexts.textMdMedium.copyWith(
                          color: Theme.of(context).appColors.textPrimary900))
                ],
              ),
            ),
            // total amount
            Container(
              margin: EdgeInsets.only(top: 6.0),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: Theme.of(context).appColors.borderSecondary,
                          width: 1))),
              child: Padding(
                padding: EdgeInsets.only(top: 12.0, right: 6.0, left: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total amount',
                        style: Theme.of(context)
                            .appTexts
                            .textLgSemiBold
                            .copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textPrimary900)),
                    Text(currency + totalAmount.toString(),
                        style: Theme.of(context)
                            .appTexts
                            .textLgSemiBold
                            .copyWith(
                                color:
                                    Theme.of(context).appColors.textPrimary900))
                  ],
                ),
              ),
            )
          ],
        ),
      );

  Widget _whyPerisaTickets(List<WhyPersiaTicketsModel> whysList) => Container(
        margin: EdgeInsets.only(right: 32.0, left: 32.0),
        child: Column(
            children: List.generate(
                whysList.length,
                (int index) => Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: LayoutBuilder(builder: (context, constraint) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppIcon.img(
                                image: whysList[index].icon,
                                color: Theme.of(context).appColors.fgQuinary400,
                                size: 24,
                                context: context),
                            SizedBox(width: 12.0),
                            SizedBox(
                              width: constraint.maxWidth - 40,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(whysList[index].title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .appTexts
                                          .textMdSemiBold
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .appColors
                                                  .textPrimary900)),
                                  SizedBox(height: 4.0),
                                  Text(whysList[index].desc,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .appTexts
                                          .textMdRegular
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .appColors
                                                  .textTeritory600))
                                ],
                              ),
                            )
                          ],
                        );
                      }),
                    ))),
      );
}
