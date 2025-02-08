import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/core/constants/app_constants.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:billit_now/templates/landing/utils.dart';
import 'package:flutter/material.dart';

import '../../../repositories/event/models/about_organizer_model.dart';
import '../../../repositories/event/models/bread_ticket_model.dart';

class BreadTicket extends BaseStatelessWidget {
  BreadTicket({
    super.key,
    required this.data,
    required this.onTapReserveTickets,
    required this.onTapGuidLines,
  });

  final BreadTicketModel data;

  final Function() onTapReserveTickets;
  final Function() onTapGuidLines;

  @override
  Widget body(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.0),
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).appColors.borderSecondary, width: 1),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // top content: title, location, date, reserve btn
          Text(
            data.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .appTexts
                .textXlSemibold
                .copyWith(color: Theme.of(context).appColors.textPrimary900),
          ),
          SizedBox(height: 2),
          Text(
            formatFullDate(data.date), // TODO Check
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .appTexts
                .textMdRegular
                .copyWith(color: Theme.of(context).appColors.textSecondary700),
          ),
          SizedBox(height: 2),
          Text(
            data.location,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .appTexts
                .textMdRegular
                .copyWith(color: Theme.of(context).appColors.textSecondary700),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(
              color: Theme.of(context).appColors.borderSecondary,
              height: 1,
            ),
          ),
          // organizer profile
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  // Avatar
                  ClipOval(
                    child: data.organizerModel.organizerImage.contains(AppConstants.assetImagesDefaultPath) ?
                    Image.asset(
                      data.organizerModel.organizerImage,
                      width: 48.0,
                      height: 48.0,
                      fit: BoxFit.cover,
                    ) :
                    Image.network(
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
                              child: data.sponsors[index].contains(AppConstants.assetImagesDefaultPath) ?
                              Image.asset(
                                data.sponsors[index],
                                width: 24.0,
                                height: 24.0,
                                fit: BoxFit.contain,
                              ) :
                              Image.network(
                                data.sponsors[index],
                                width: 24.0,
                                height: 24.0,
                                fit: BoxFit.contain,
                              ),
                            )))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // GuidLines
              AppButton.buttonIcon(AppIconName.ued08FileCheck02,
                  iconSize: 20,
                  border: Border.all(
                      color: Theme.of(context).appColors.buttonSecondaryBorder),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  padding: EdgeInsets.all(12.0),
                  bgColor: Colors.transparent,
                  bgHoverColor: Colors.transparent,
                  textColor: Colors.transparent,
                  context: context,
                  onTap: onTapGuidLines),
              // Reserve ticket
              Expanded(
                child: AppButton.buttonPrimary(
                    context: context,
                    text: 'Reserve ticket',
                    padding: EdgeInsets.symmetric(vertical: 10),
                    onTap: onTapReserveTickets),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
