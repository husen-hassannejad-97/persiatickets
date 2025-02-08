import 'package:billit_now/apps/helper/router/router_extention/landing_router_extention.dart';
import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/empty_modal.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:billit_now/repositories/event/models/breadcrumb_model.dart';
import 'package:billit_now/templates/events/widgets/login_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Breadcrumb extends BaseStatelessWidget {
  Breadcrumb({super.key, required this.data});

  final BreadcrumbModel data;

  @override
  Widget body(BuildContext context) {
    return Container(
      width: context.logicalWidth,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 48),
      decoration: BoxDecoration(
          color: Theme.of(context).appColors.bgPrimary,
          border: Border(
              bottom: BorderSide(
                  width: 1,
                  color: Theme.of(context).appColors.borderSecondary))),
      child: Row(
        mainAxisAlignment: context.isRegularSmartphoneOrLess
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          context.isRegularSmartphoneOrLess
              ? Container()
              : Row(children: [
                  // Home Icon
                  AppButton.buttonIcon(AppIconName.ueb4bHomeLine,
                      bgColor: Colors.transparent,
                      bgHoverColor: Colors.transparent,
                      textColor: Theme.of(context).appColors.breadcrumbFg,
                      iconColor: Theme.of(context).appColors.breadcrumbFg,
                      iconSize: 20,
                      context: context,
                      onTap: () => context.goLanding()),
                  // / spacer
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text('/',
                        style: Theme.of(context)
                            .appTexts
                            .textSmSemiBord
                            .copyWith(
                                color:
                                    Theme.of(context).appColors.breadcrumbFg)),
                  ),
                  // Concert Tickets
                  AppButton.buttonTertiary(
                      context: context,
                      text: 'Concert Tickets',
                      bgHoverColor: Colors.transparent,
                      textStyle: Theme.of(context)
                          .appTexts
                          .textSmSemiBord
                          .copyWith(
                              color: Theme.of(context).appColors.breadcrumbFg),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return EmptyModal.show(context: context);
                          },
                        );
                      }),
                  // / spacer
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text('/',
                        style: Theme.of(context)
                            .appTexts
                            .textSmSemiBord
                            .copyWith(
                                color:
                                    Theme.of(context).appColors.breadcrumbFg)),
                  ),
                  // Ebi live in Vienna
                  Text('Ebi live in Vienna',
                      style: Theme.of(context).appTexts.textSmSemiBord.copyWith(
                          color: Theme.of(context)
                              .appColors
                              .breadcrumbBrandFgHover)),
                ]),
          Row(
            children: [
              // Share event btn
              AppButton.buttonIcon(AppIconName.ueb26Share02,
                  text: 'Share event',
                  bgColor: Colors.transparent,
                  bgHoverColor: Colors.transparent,
                  textColor: Theme.of(context).appColors.buttonTeritoryFg,
                  iconColor: Theme.of(context).appColors.buttonTeritoryFg,
                  iconSize: 20,
                  context: context, onTap: () async {
                Clipboard.setData(
                    ClipboardData(text: 'https://persia.tickets'));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Copied to clipboard!')),
                );
              }),
              SizedBox(width: 32),
              // Add to track list btn
              AppButton.buttonIcon(AppIconName.ueb3aHeart,
                  text: 'Add to track list',
                  bgColor: Colors.transparent,
                  bgHoverColor: Colors.transparent,
                  textColor: Theme.of(context).appColors.buttonTeritoryFg,
                  iconColor: Theme.of(context).appColors.buttonTeritoryFg,
                  iconSize: 20,
                  context: context, onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return LoginModal.show();
                  },
                );
              })
            ],
          )
        ],
      ),
    );
  }
}
