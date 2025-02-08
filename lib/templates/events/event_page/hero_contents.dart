import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/empty_modal.dart';
import 'package:billit_now/core/constants/app_constants.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:billit_now/templates/landing/utils.dart';
import 'package:flutter/material.dart';

class HeroContents extends BaseStatelessWidget {
  HeroContents(
      {super.key,
      required this.eventImage,
      required this.organizer,
      required this.title,
      required this.subTitle,
      required this.startDate,
      required this.endDate,
      required this.location});

  final String eventImage;
  final String organizer;
  final String title;
  final String subTitle;
  final DateTime startDate;
  final DateTime endDate;
  final String location;

  @override
  Widget body(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
            height: context.logicalHeight,
            width: context.logicalWidth,
            child: eventImage.contains(AppConstants.assetImagesDefaultPath)
                ? Image.asset(
                    eventImage,
                    width: context.logicalWidth,
                    height: context.logicalHeight,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    eventImage,
                    width: context.logicalWidth,
                    height: context.logicalHeight,
                    fit: BoxFit.cover,
                  )),
        ...context.isSmallTabletOrLess ? _smScreen(context) : _lgScreen(context)
      ],
    );
  }

  List<Widget> _smScreen(BuildContext context) => [
        // top gradient
        Positioned(
          right: 0,
          left: 0,
          top: 0,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).appColors.bgPrimary,
                  Theme.of(context).appColors.bgPrimary.withOpacity(0.8),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          ),
        ),
        // botton gradient
        Positioned(
          right: 0,
          left: 0,
          bottom: 0,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Theme.of(context).appColors.bgPrimary,
                  Theme.of(context).appColors.bgPrimary.withOpacity(0.9),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.6, 1.0],
              ),
            ),
          ),
        ),
        // top contents
        Positioned(
            top: 100,
            right: 16,
            left: 16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Organized by',
                    style: Theme.of(context).appTexts.textSmRegular.copyWith(
                        color: Theme.of(context)
                            .appColors
                            .textPrimary900
                            .withOpacity(0.7))),
                Text(organizer,
                    style: Theme.of(context).appTexts.textMdSemiBold.copyWith(
                        color: Theme.of(context).appColors.textPrimary900)),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .appTexts
                          .displayMdSemibold
                          .copyWith(
                              color:
                                  Theme.of(context).appColors.textPrimary900)),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  constraints: BoxConstraints(maxWidth: 500),
                  child: Text(subTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).appTexts.textMdRegular.copyWith(
                          color: Theme.of(context).appColors.textPrimary900)),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  constraints: BoxConstraints(maxWidth: 210),
                  child: AppButton.buttonPrimary(
                      context: context,
                      text: 'Reserve your seat today',
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
            )),
      ];

  List<Widget> _lgScreen(BuildContext context) => [
        // right gradient
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: Container(
            height: context.logicalHeight,
            width: context.logicalWidth,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Theme.of(context).appColors.bgPrimary.withOpacity(0.9),
                  Theme.of(context).appColors.bgPrimary.withOpacity(0.6),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.2, 0.5],
              ),
            ),
          ),
        ),
        // top gradient
        Positioned(
          right: 0,
          left: 0,
          top: 0,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).appColors.bgPrimary,
                  Theme.of(context).appColors.bgPrimary.withOpacity(0.6),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 0.8],
              ),
            ),
          ),
        ),
        // botton gradient
        Positioned(
          right: 0,
          left: 0,
          bottom: 0,
          child: Container(
            height: context.logicalHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Theme.of(context).appColors.bgPrimary.withOpacity(0.9),
                  Theme.of(context).appColors.bgPrimary.withOpacity(0.6),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.2, 0.4],
              ),
            ),
          ),
        ),
        // Left contents
        Positioned(
            left: 48,
            bottom: 24,
            child: SizedBox(
              width: context.logicalWidth / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(formatFullDate(startDate),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .appTexts
                          .displayMdSemibold
                          .copyWith(
                              color:
                                  Theme.of(context).appColors.textPrimary900)),
                  Text(formatFullDate(endDate),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .appTexts
                          .displayMdSemibold
                          .copyWith(
                              color:
                                  Theme.of(context).appColors.textPrimary900)),
                  Text(location,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).appTexts.textLgRegular.copyWith(
                          color: Theme.of(context).appColors.textSecondary700))
                ],
              ),
            )),
        // Right contents
        Positioned(
            right: 48,
            bottom: 64,
            top: 100,
            child: SizedBox(
              width: context.logicalWidth / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Organized by',
                      style: Theme.of(context).appTexts.textMdRegular.copyWith(
                          color: Theme.of(context)
                              .appColors
                              .textPrimary900
                              .withOpacity(0.7))),
                  Text(organizer,
                      style: Theme.of(context).appTexts.textLgSemiBold.copyWith(
                          color: Theme.of(context).appColors.textPrimary900)),
                  Padding(
                    padding: const EdgeInsets.only(top: 48),
                    child: Text(title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .appTexts
                            .displayLgSemibold
                            .copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textPrimary900)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 64),
                    child: Text(subTitle,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .appTexts
                            .textLgRegular
                            .copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textPrimary900)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: AppButton.buttonPrimary(
                        context: context,
                        text: 'Reserve your seat today',
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
              ),
            )),
      ];
}
