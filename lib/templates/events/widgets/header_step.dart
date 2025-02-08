import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/repositories/event/models/header_navigation_model.dart';
import 'package:flutter/material.dart';

class HeaderStep extends StatelessWidget {
  const HeaderStep({super.key, required this.index, required this.step});

  final int index;
  final HeaderNavigationModel step;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        index == 0
            ? Container()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: AppIcon.button(
                    appIconName: AppIconName.uea21ChevronRight,
                    size: 16.0,
                    context: context),
              ),
        Container(
          decoration: BoxDecoration(
            color: step.isDone
                ? Theme.of(context).appColors.bgSecondaryHover
                : Theme.of(context).appColors.bgPrimary,
            border: Border.all(
              color: Theme.of(context).appColors.borderSecondary,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            child: Row(
              children: [
                step.isDone
                    ? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: AppIcon.button(
                            appIconName: AppIconName.filledCircleCheckDefault,
                            size: 10.0,
                            context: context),
                      )
                    : Container(),
                Text(step.isDone ? step.title : '$index. ${step.title}',
                    style: Theme.of(context).appTexts.textSmMedium.copyWith(
                        color: step.isDone
                            ? Theme.of(context).appColors.textBrandSecondary700
                            : step.isHover
                                ? Theme.of(context).appColors.textSecondary700
                                : Theme.of(context)
                                    .appColors
                                    .textQuaternary500)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
