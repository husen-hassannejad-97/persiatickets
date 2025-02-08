import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/header.dart';
import 'package:flutter/material.dart';

class FormComplationModal extends StatelessWidget {
  const FormComplationModal._internal({
    super.key,
  });

  factory FormComplationModal.show({
    Key? key,
  }) =>
      FormComplationModal._internal(
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
        height: 190,
        width: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppIcon.button(
                      appIconName: AppIconName.ueae0Tool02,
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
              'Starred (*) items must be completed!',
              style: Theme.of(context).appTexts.textSmRegular.copyWith(
                  color: Theme.of(context).appColors.textErrorPrimary600),
            ),
            AppButton.buttonPrimary(
                context: context,
                text: 'Back to Form',
                padding: EdgeInsets.symmetric(vertical: 10),
                onTap: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
