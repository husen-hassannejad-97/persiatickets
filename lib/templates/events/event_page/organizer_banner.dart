import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/empty_modal.dart';
import 'package:billit_now/core/constants/app_constants.dart';
import 'package:billit_now/templates/landing/utils.dart';
import 'package:flutter/material.dart';

import '../../../repositories/event/models/organizer_banner_model.dart';

class OrganizerBanner extends StatelessWidget {
  const OrganizerBanner({
    super.key,
    required this.data,
    required this.reserveTickets,
  });

  final OrganizerBannerModel data;
  final Function() reserveTickets;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).appColors.borderSecondary, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // top content: title, location, date, reserve btn
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Theme.of(context).appColors.borderSecondary,
                          width: 1),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .appTexts
                          .displayXsSemibold
                          .copyWith(
                              color:
                                  Theme.of(context).appColors.textPrimary900),
                    ),
                    SizedBox(height: 4),
                    Text(
                      formatFullDate(data.date), // TODO
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).appTexts.textMdRegular.copyWith(
                          color: Theme.of(context).appColors.textSecondary700),
                    ),
                    SizedBox(height: 4),
                    Text(
                      data.location,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).appTexts.textMdRegular.copyWith(
                          color: Theme.of(context).appColors.textSecondary700),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    AppButton.buttonPrimary(
                        context: context,
                        text: 'Reserve ticket',
                        padding: EdgeInsets.symmetric(vertical: 10),
                        onTap: reserveTickets)
                  ],
                ),
              ),
              // organizer profile
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      // Avatar
                      ClipOval(
                        child: data.organizerModel.organizerImage
                                .contains(AppConstants.assetImagesDefaultPath)
                            ? Image.asset(
                                data.organizerModel.organizerImage,
                                width: 48.0,
                                height: 48.0,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                data.organizerModel.organizerImage,
                                width: 48.0,
                                height: 48.0,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(width: 12),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Organizer Name
                            Text(data.organizerModel.name,
                                style: Theme.of(context)
                                    .appTexts
                                    .textMdSemiBold
                                    .copyWith(
                                        color: Theme.of(context)
                                            .appColors
                                            .textPrimary900)),
                            // Organizer Role
                            Text(data.role,
                                style: Theme.of(context)
                                    .appTexts
                                    .textSmMedium
                                    .copyWith(
                                        color: Theme.of(context)
                                            .appColors
                                            .bgQuaternary))
                          ])
                    ]),
                    // sponsors
                    Row(
                        children: List.generate(
                            data.sponsors.length,
                            (int index) => ClipOval(
                                  child: data.sponsors[index].contains(
                                          AppConstants.assetImagesDefaultPath)
                                      ? Image.asset(
                                          data.sponsors[index],
                                          width: 24.0,
                                          height: 24.0,
                                          fit: BoxFit.contain,
                                        )
                                      : Image.network(
                                          data.sponsors[index],
                                          width: 24.0,
                                          height: 24.0,
                                          fit: BoxFit.contain,
                                        ),
                                )))
                  ],
                ),
              )
            ],
          ),
        ),
        // Event and Venue Guidelines
        Padding(
          padding: const EdgeInsets.only(top: 26),
          child: AppButton.buttonIcon(AppIconName.ued08FileCheck02,
              text: 'Event and Venue Guidelines',
              iconSize: 20,
              bgColor: Colors.transparent,
              bgHoverColor: Colors.transparent,
              textColor: Theme.of(context).appColors.buttonTeritoryFg,
              context: context, onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return EmptyModal.show(context: context);
              },
            );
          }),
        )
      ],
    );
    // SliverPersistentHeader(
    //   pinned: true,
    //   floating: true,
    //   delegate: _SliverAppBarDelegate(
    //     minHeight: 200.0,
    //     maxHeight: 200.0,
    //     child: Container(
    //         color: Colors.lightBlue,
    //         child: Center(
    //             child: Container(
    //           width: 50,
    //           height: 50,
    //           color: Colors.red,
    //         ))),
    //   ),
    // );
  }
}

// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   _SliverAppBarDelegate({
//     required this.minHeight,
//     required this.maxHeight,
//     required this.child,
//   });
//   final double minHeight;
//   final double maxHeight;
//   final Widget child;
//   @override
//   double get minExtent => minHeight;
//   @override
//   double get maxExtent => math.max(maxHeight, minHeight);
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return SizedBox(child: child);
//   }

//   @override
//   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
//     return maxHeight != oldDelegate.maxHeight ||
//         minHeight != oldDelegate.minHeight ||
//         child != oldDelegate.child;
//   }
// }
