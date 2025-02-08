import 'package:billit_now/apps/helper/router/router_extention/login_router_extention.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/core/di/di_setup.config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginModal extends StatelessWidget {
  const LoginModal._internal({
    super.key,
  });

  factory LoginModal.show({
    Key? key,
  }) =>
      LoginModal._internal(
        key: key,
      );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Theme.of(context).appColors.bgPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        padding: EdgeInsets.all(24),
        height: 260,
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppIcon.button(
                      appIconName: AppIconName.ueb3aHeart,
                      size: 24,
                      context: context),
                  AppButton.buttonIcon(AppIconName.ueaefXClose,
                      bgColor: Colors.transparent,
                      bgHoverColor: Colors.transparent,
                      textColor: Colors.transparent,
                      iconSize: 24,
                      context: context, onTap: () {
                    Navigator.pop(context);
                  })
                ]),
            Text(
              'Log in to add to your track list',
              style: Theme.of(context)
                  .appTexts
                  .textLgSemiBold
                  .copyWith(color: Theme.of(context).appColors.textPrimary900),
            ),
            Text(
              'To keep track of this event and receive updates, please sign in to your account. If you don’t have an account, it only takes a moment to create one.',
              style: Theme.of(context)
                  .appTexts
                  .textSmRegular
                  .copyWith(color: Theme.of(context).appColors.textTeritory600),
            ),
            Row(
              children: [
                Expanded(
                  child: AppButton.buttonTertiary(
                      context: context,
                      text: 'Cancel',
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      border: Border.all(
                          color:
                              Theme.of(context).appColors.buttonSecondaryBorder,
                          width: 1),
                      onTap: () {
                        context.pop();
                      }),
                ),
                Expanded(
                  child: AppButton.buttonPrimary(
                      context: context,
                      text: 'Log in / sign up',
                      padding: EdgeInsets.symmetric(vertical: 10),
                      onTap: () {
                        context.goLoginEmail();
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
