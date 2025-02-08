import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:flutter/material.dart';

class PasswordChecker extends BaseStatelessWidget {
  PasswordChecker({super.key, required this.password});

  final String password;

  @override
  Widget body(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _passIsLongerThan8()
                    ? Theme.of(context).appColors.bgSuccessSolid
                    : Theme.of(context).appColors.fgDisabledSubtle),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: AppIcon.button(
                  appIconName: AppIconName.filledCircleCheckDefault,
                  size: 10,
                  context: context),
            ),
          ),
          Text('\t${getString("must_be_at_least_8_characters")}',
              style: Theme.of(context)
                  .appTexts
                  .textSmRegular
                  .copyWith(color: Theme.of(context).appColors.textTeritory600))
        ],
      ),
      const SizedBox(
        height: 8,
      ),
      Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _passHasSpecialChar()
                    ? Theme.of(context).appColors.bgSuccessSolid
                    : Theme.of(context).appColors.fgDisabledSubtle),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: AppIcon.button(
                  appIconName: AppIconName.filledCircleCheckDefault,
                  size: 10,
                  context: context),
            ),
          ),
          Text('\t${getString("must_contain_one_special_character")}',
              style: Theme.of(context)
                  .appTexts
                  .textSmRegular
                  .copyWith(color: Theme.of(context).appColors.textTeritory600))
        ],
      )
    ]);
  }

  _passIsLongerThan8() {
    return password.length > 8;
  }

  _passHasSpecialChar() {
    return RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
  }
}
