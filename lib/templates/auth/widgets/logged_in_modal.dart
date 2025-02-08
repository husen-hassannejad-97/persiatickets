import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_modal.dart';
import 'package:flutter/material.dart';

class LoggedInModal extends StatelessWidget {
  const LoggedInModal({
    super.key,
    required this.isRtl,
    required this.controller,
    required this.firstName,
    required this.lastName,
    required this.mail,
    required this.offset,
    required this.compositWidth,
    required this.compositHeight,
    required this.compositTarget,
    required this.onTapViewProfile,
    required this.onTapAccountSettings,
    required this.onTapSignOut,
  });

  final bool isRtl;
  final OverlayPortalController controller;
  final String firstName;
  final String lastName;
  final String mail;
  final Offset offset;
  final double compositWidth;
  final double compositHeight;
  final Widget compositTarget;
  final Function() onTapViewProfile;
  final Function() onTapAccountSettings;
  final Function() onTapSignOut;

  @override
  Widget build(BuildContext context) {
    return AppModal.show(
        controller: controller,
        offset: offset,
        compositWidth: compositWidth,
        compositHeight: compositHeight,
        compositTarget: compositTarget,
        body: Container(
          width: 256,
          height: 152,
          decoration: BoxDecoration(
              color: Theme.of(context).appColors.bgPrimary,
              border: Border.all(
                color: Theme.of(context).appColors.borderSecondary,
              ),
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppButton.buttonIcon(AppIconName.ueb92User01,
                  text: 'View Profile',
                  iconSize: 20.0,
                  bgColor: Colors.transparent,
                  bgHoverColor: Colors.transparent,
                  textColor: Theme.of(context).appColors.textSecondary700,
                  context: context,
                  isRTL: isRtl,
                  padding: EdgeInsets.all(8.0),
                  onTap: onTapViewProfile),
              AppButton.buttonIcon(AppIconName.ueb22Settings02,
                  text: 'Account Settings',
                  iconSize: 20.0,
                  bgColor: Colors.transparent,
                  bgHoverColor: Colors.transparent,
                  textColor: Theme.of(context).appColors.textSecondary700,
                  context: context,
                  isRTL: isRtl,
                  padding: EdgeInsets.all(8.0),
                  onTap: onTapAccountSettings),
              Divider(color: Theme.of(context).appColors.borderSecondary),
              AppButton.buttonIcon(AppIconName.ueb02LogOut01,
                  text: 'Sign Out',
                  iconSize: 20.0,
                  bgColor: Colors.transparent,
                  bgHoverColor: Colors.transparent,
                  textColor: Theme.of(context).appColors.textSecondary700,
                  context: context,
                  isRTL: isRtl,
                  padding: EdgeInsets.all(8.0),
                  onTap: onTapSignOut),
            ],
          ),
        ));
  }
}
