import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmptyModal extends StatelessWidget {
  final AppIconName icon;
  final String title;
  final String subTitle;
  final String cancelBtnTitle;
  final Color cancelBtnBgColor;
  final Function() onTapCancelBtn;
  final String processBtnTitle;
  final Color processBtnBgColor;
  final Function() onTapProcessBtn;
  const EmptyModal._internal({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.cancelBtnTitle,
    required this.cancelBtnBgColor,
    required this.onTapCancelBtn,
    required this.processBtnTitle,
    required this.processBtnBgColor,
    required this.onTapProcessBtn,
  });

  factory EmptyModal.show({
    Key? key,
    required BuildContext context,
  }) =>
      EmptyModal._internal(
        key: key,
        icon: AppIconName.ueae0Tool02,
        title: 'Page under construction',
        subTitle:
            'We’re sorry, this feature isn’t available yet. We’re working hard to bring it to life soon. Stay tuned!',
        cancelBtnTitle: 'Back to home',
        cancelBtnBgColor: Theme.of(context).appColors.bgBrand,
        onTapCancelBtn: () {
          context.pop();
        },
        processBtnTitle: '',
        processBtnBgColor: Colors.transparent,
        onTapProcessBtn: () {},
      );

  factory EmptyModal.value(
          {Key? key,
          required AppIconName icon,
          required String title,
          required String subTitle,
          required String cancelBtnTitle,
          required Color cancelBtnBgColor,
          required Function() onTapCancelBtn,
          required String processBtnTitle,
          required Color processBtnBgColor,
          required Function() onTapProcessBtn}) =>
      EmptyModal._internal(
          key: key,
          icon: icon,
          title: title,
          subTitle: subTitle,
          cancelBtnTitle: cancelBtnTitle,
          cancelBtnBgColor: cancelBtnBgColor,
          onTapCancelBtn: onTapCancelBtn,
          processBtnTitle: processBtnTitle,
          processBtnBgColor: processBtnBgColor,
          onTapProcessBtn: onTapProcessBtn);

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
                  AppIcon.button(appIconName: icon, size: 24, context: context),
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
              title,
              style: Theme.of(context)
                  .appTexts
                  .textLgSemiBold
                  .copyWith(color: Theme.of(context).appColors.textPrimary900),
            ),
            Text(
              subTitle,
              style: Theme.of(context)
                  .appTexts
                  .textSmRegular
                  .copyWith(color: Theme.of(context).appColors.textTeritory600),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppButton.buttonTertiary(
                      context: context,
                      text: cancelBtnTitle,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      bgColor: cancelBtnBgColor,
                      onTap: onTapCancelBtn),
                ),
                SizedBox(width: 6.0),
                processBtnTitle == ''
                    ? Container()
                    : Expanded(
                        child: AppButton.buttonTertiary(
                            context: context,
                            text: processBtnTitle,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            bgColor: processBtnBgColor,
                            onTap: onTapProcessBtn),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
