import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/repositories/auth/models/snackbar_type.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class AppSnackbar {
  const AppSnackbar();

  void show(
      {required BuildContext context,
      required SnackbarType type,
      required String message,
      String? subMessage}) {
    showToast(
      message,
      duration: Duration(seconds: 4),
      position: ToastPosition.bottom,
      margin: EdgeInsets.only(bottom: 5.0),
      backgroundColor: Colors.black,
      radius: 8.0,
      textPadding: EdgeInsets.all(8.0),
      textStyle: Theme.of(context)
          .appTexts
          .textMdMedium
          .copyWith(color: Theme.of(context).appColors.textWhite),
    );
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Row(
    //       children: [
    //         AppIcon.button(
    //             appIconName: type == SnackbarType.error
    //                 ? AppIconName.ueb58AlertCircle
    //                 : type == SnackbarType.warning
    //                     ? AppIconName.ueb58WarningCircle
    //                     : AppIconName.ueaacCheckCircle,
    //             context: context),
    //         SizedBox(width: 16.0),
    //         Text(message,
    //             style: Theme.of(context).appTexts.textSmSemiBord.copyWith(
    //                 color: Theme.of(context).appColors.textSecondary700)),
    //         SizedBox(width: 6.0),
    //         Text(subMessage ?? '',
    //             style: Theme.of(context).appTexts.textSmRegular.copyWith(
    //                 color: Theme.of(context).appColors.textTeritory600))
    //       ],
    //     ),
    //     showCloseIcon: true,
    //     closeIconColor: Theme.of(context).appColors.fgQuinary400,
    //     backgroundColor: Theme.of(context).appColors.bgPrimary,
    //     elevation: 10,
    //     behavior: SnackBarBehavior.floating,
    //     margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
    //   ),
    // );
  }
}
