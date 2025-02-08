import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_slider.dart';
import 'package:billit_now/component/dashed_line.dart';
import 'package:billit_now/component/nav_drawer.dart';
import 'package:billit_now/repositories/event/models/header_navigation_model.dart';
import 'package:billit_now/repositories/event/models/tickets_model.dart';
import 'package:billit_now/templates/events/widgets/header_navigation.dart';
import 'package:billit_now/templates/landing/utils.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Ticket(
      data: TicketsModel(pdfLink: 'https://persia.tickets/', tickets: [
        TicketModel(
            id: 'F4412332024',
            eventTitle: 'EBI live in Vienna',
            location: 'Wiener Stadthalle, Hall F, Vienna, Austria',
            date: DateTime(2025, 2, 25, 19, 00),
            block: 'Front Center',
            row: 13,
            seat: 24,
            qrCode: 'PersiaTickets EBI live in Vienna',
            sponsorsLogo: [
              'assets/images/redbullcom-logo_double-with-text.png',
              'assets/images/austrian-logo.png',
              'assets/images/swa-brandlogo-icon.png'
            ]),
        TicketModel(
            id: 'G4412332024',
            eventTitle: 'Googoosh live in Vienna',
            location: 'Wiener Stadthalle, Hall F, Vienna, Austria',
            date: DateTime(2025, 2, 25, 19, 00),
            block: 'Front Center',
            row: 23,
            seat: 45,
            qrCode: 'PersiaTickets Googoosh live in Vienna',
            sponsorsLogo: [
              'assets/images/redbullcom-logo_double-with-text.png',
              'assets/images/austrian-logo.png',
              'assets/images/swa-brandlogo-icon.png'
            ]),
      ]),
      onTapGoogleWallet: () {},
      onTapAppleWallet: () {},
    );
  }
}

class Ticket extends StatefulWidget {
  const Ticket(
      {super.key,
      required this.data,
      required this.onTapGoogleWallet,
      required this.onTapAppleWallet});

  final TicketsModel data;
  final Function() onTapGoogleWallet;
  final Function() onTapAppleWallet;

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  final ScrollController _scrollController = ScrollController();

  final CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  int sliderIndex = 1;

  @override
  Widget build(BuildContext context) {
    bool isSmScreen = context.logicalWidth < 1200;
    return Scaffold(
      endDrawer: isSmScreen ? const NavDrawer() : null,
      backgroundColor: Theme.of(context).appColors.bgPrimary,
      body: SafeArea(
          child: Stack(children: [
        SingleChildScrollView(
          padding: Theme.of(context)
              .appDimensions
              .horizontalRespoonsivePaddingLoginSingUp,
          child: Align(
            alignment: Alignment.center,
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: 700,
                    minWidth: 700,
                    minHeight: context.logicalHeight),
                child: Container(
                  margin: Theme.of(context)
                      .appDimensions
                      .topBottonMarginLoginSingUp,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Header
                      Container(
                        padding: const EdgeInsets.only(bottom: 32),
                        child: Column(children: [
                          // logo
                          AppIcon.logo(
                            appIconName: AppIconName.success,
                            context: context,
                            size: 48,
                          ),
                          const SizedBox(height: 24),
                          // title
                          Container(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Center(
                              child: Text(
                                'Your Ticket is Ready!',
                                style: Theme.of(context)
                                    .appTexts
                                    .displaySmSemiBold
                                    .copyWith(
                                        color: Theme.of(context)
                                            .appColors
                                            .textPrimary900),
                              ),
                            ),
                          ),
                          // subtitle
                          Center(
                            child: Text(
                              'Thank you for your purchase! Below, you\'ll find all the details about your ticket.',
                              style: Theme.of(context)
                                  .appTexts
                                  .textMdRegular
                                  .copyWith(
                                      color: Theme.of(context)
                                          .appColors
                                          .textTeritory600),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ]),
                      ),
                      // buttons

                      isSmScreen
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:
                                  _getButtons(context, widget.data.pdfLink))
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:
                                  _getButtons(context, widget.data.pdfLink)),

                      //Tickets slider
                      Container(
                          padding: EdgeInsets.only(top: 32.0, bottom: 24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppButton.buttonIcon(AppIconName.uea1fChevronLeft,
                                  iconSize: 24.0,
                                  bgColor: Colors.transparent,
                                  bgHoverColor: Colors.transparent,
                                  textColor: Colors.transparent,
                                  context: context, onTap: () {
                                buttonCarouselController.previousPage();
                              }),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  '$sliderIndex/${widget.data.tickets.length}',
                                  style: Theme.of(context)
                                      .appTexts
                                      .textMdMedium
                                      .copyWith(
                                          color: Theme.of(context)
                                              .appColors
                                              .textPrimary900),
                                ),
                              ),
                              AppButton.buttonIcon(
                                  AppIconName.uea21ChevronRight,
                                  iconSize: 24.0,
                                  bgColor: Colors.transparent,
                                  bgHoverColor: Colors.transparent,
                                  textColor: Colors.transparent,
                                  context: context, onTap: () {
                                buttonCarouselController.nextPage();
                              })
                            ],
                          )),
                      AppSlider.expanded(
                        items: widget.data.tickets
                            .asMap()
                            .entries
                            .map((MapEntry<int, TicketModel> item) {
                          return _ticket(
                              item.value, item.key == sliderIndex - 1);
                        }).toList(),
                        viewportFraction: context.logicalWidth < 600
                            ? 0.9
                            : context.logicalWidth < 1000
                                ? 0.7
                                : 0.6,
                        buttonCarouselController: buttonCarouselController,
                        enlargeCenterPage: false,
                        height: 490,
                        infinitScroll: true,
                        initialPage: 0,
                        onPageChanged: (int index, __) {
                          setState(() {
                            sliderIndex = index + 1;
                          });
                        },
                      ),
                    ],
                  ),
                )),
          ),
        ),
        _headerNavigation()
      ])),
    );
  }

  List<Widget> _getButtons(BuildContext context, String pdfLink) => [
        // Dl Tickets
        AppButton.buttonIcon(AppIconName.ueac6Download02,
            bgColor: Theme.of(context).appColors.bgBrand,
            bgHoverColor: Theme.of(context).appColors.bgBrand.withOpacity(0.9),
            textColor: Theme.of(context).appColors.textWhite,
            text: 'Download all tickets (PDF)',
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            context: context, onTap: () {
          launchUrl(Uri.parse(pdfLink), mode: LaunchMode.platformDefault);
        }),
        // google
        AppButton.buttonIcon(
            text: 'Add to Google Wallet',
            AppIconName.logoGoogle,
            iconSize: 24,
            textColor: Theme.of(context).appColors.textSecondary700,
            bgColor: Theme.of(context).appColors.bgPrimary,
            bgHoverColor: Theme.of(context).appColors.bgPrimaryHover,
            border: Theme.of(context).appDimensions.borderPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            context: context,
            onTap: widget.onTapGoogleWallet),
        // Apple
        AppButton.buttonIcon(
            text: 'Add to Apple Wallet',
            AppIconName.logoApple,
            iconSize: 24,
            textColor: Theme.of(context).appColors.textSecondary700,
            bgColor: Theme.of(context).appColors.bgPrimary,
            bgHoverColor: Theme.of(context).appColors.bgPrimaryHover,
            border: Theme.of(context).appDimensions.borderPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            context: context,
            onTap: widget.onTapAppleWallet)
      ];

  Widget _ticket(TicketModel ticket, bool isOnCenter) => Container(
        width: 360,
        height: 490,
        margin: EdgeInsets.all(6.0),
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: 24.0, vertical: 16.0),
        decoration: BoxDecoration(
            border:
                Border.all(color: Theme.of(context).appColors.borderSecondary),
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Stack(
          children: [
            Column(
              children: [
                // Logo and Ticket ID
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo
                    AppIcon.logo(
                      appIconName: AppIconName.logoFullLTR,
                      context: context,
                      size: 30,
                    ),
                    // Ticket ID
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ticket ID',
                            style: Theme.of(context)
                                .appTexts
                                .textXsMedium
                                .copyWith(
                                    color: Theme.of(context)
                                        .appColors
                                        .textTeritory600)),
                        Text(ticket.id,
                            style: Theme.of(context)
                                .appTexts
                                .textSmMedium
                                .copyWith(
                                    color: Theme.of(context)
                                        .appColors
                                        .textPrimary900))
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Divider(
                    color: Theme.of(context).appColors.borderSecondary,
                  ),
                ),
                // Event title
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(ticket.eventTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .appTexts
                          .displayXsSemibold
                          .copyWith(
                              color:
                                  Theme.of(context).appColors.textPrimary900)),
                ),
                // event info
                Container(
                    padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 24.0, vertical: 16.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context).appColors.bgSecondary,
                            Colors.transparent
                          ],
                        )),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //place
                          Text('Place',
                              style: Theme.of(context)
                                  .appTexts
                                  .textSmRegular
                                  .copyWith(
                                      color: Theme.of(context)
                                          .appColors
                                          .textQuaternary500)),
                          Text(ticket.location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .appTexts
                                  .textSmMedium
                                  .copyWith(
                                      color: Theme.of(context)
                                          .appColors
                                          .textPrimary900)),
                          SizedBox(height: 16.0),
                          // Date & Time
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Date
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Date',
                                      style: Theme.of(context)
                                          .appTexts
                                          .textSmRegular
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .appColors
                                                  .textQuaternary500)),
                                  Text(formatTimeWithoutYear(ticket.date),
                                      style: Theme.of(context)
                                          .appTexts
                                          .textSmMedium
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .appColors
                                                  .textPrimary900)),
                                ],
                              ),
                              // Time
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Time',
                                      style: Theme.of(context)
                                          .appTexts
                                          .textSmRegular
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .appColors
                                                  .textQuaternary500)),
                                  Text(formatTimeHourMinutes(ticket.date),
                                      style: Theme.of(context)
                                          .appTexts
                                          .textSmMedium
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .appColors
                                                  .textPrimary900)),
                                ],
                              ),
                            ],
                          ), // Block & Row & Seat
                          SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Block
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Block',
                                      style: Theme.of(context)
                                          .appTexts
                                          .textSmRegular
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .appColors
                                                  .textQuaternary500)),
                                  Text(ticket.block,
                                      style: Theme.of(context)
                                          .appTexts
                                          .textSmMedium
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .appColors
                                                  .textPrimary900)),
                                ],
                              ),
                              // Row
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Row',
                                      style: Theme.of(context)
                                          .appTexts
                                          .textSmRegular
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .appColors
                                                  .textQuaternary500)),
                                  Text(ticket.row.toString(),
                                      style: Theme.of(context)
                                          .appTexts
                                          .textSmMedium
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .appColors
                                                  .textPrimary900)),
                                ],
                              ),
                              // seat
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Seat',
                                      style: Theme.of(context)
                                          .appTexts
                                          .textSmRegular
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .appColors
                                                  .textQuaternary500)),
                                  Text(ticket.seat.toString(),
                                      style: Theme.of(context)
                                          .appTexts
                                          .textSmMedium
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .appColors
                                                  .textPrimary900)),
                                ],
                              ),
                            ],
                          )
                        ])),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child:
                      DashedLine.horizontal(width: double.infinity, height: 1),
                ),
                // QR & Sponsors
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // gq
                    QrImageView(
                      data: ticket.qrCode,
                      version: QrVersions.auto,
                      size: 96.0,
                      eyeStyle: QrEyeStyle(
                          color: Theme.of(context).appColors.textPrimary900,
                          eyeShape: QrEyeShape.square),
                      dataModuleStyle: QrDataModuleStyle(
                          color: Theme.of(context).appColors.textPrimary900),
                    ),
                    // sponsors
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(ticket.sponsorsLogo.length,
                            (int index) {
                          return ticket.sponsorsLogo[index].contains('assets')
                              ? Image.asset(
                                  ticket.sponsorsLogo[index],
                                  width: 110,
                                )
                              : Image.network(
                                  ticket.sponsorsLogo[index],
                                  width: 110,
                                );
                        }))
                  ],
                )
              ],
            ),
            isOnCenter
                ? Container()
                : Container(
                    color:
                        Theme.of(context).appColors.bgPrimary.withOpacity(0.9),
                  )
          ],
        ),
      );

  Widget _headerNavigation() =>
      HeaderNavigation(scrollController: _scrollController, steps: [
        HeaderNavigationModel(
            title: 'Select Date & Time', isDone: true, isHover: false),
        HeaderNavigationModel(
            title: 'Select Seats', isDone: true, isHover: false),
        HeaderNavigationModel(
            title: 'User Info & Invoice', isDone: true, isHover: false),
        HeaderNavigationModel(title: 'Payment', isDone: true, isHover: false),
        HeaderNavigationModel(title: 'Tickets', isDone: false, isHover: true)
      ]);
}
