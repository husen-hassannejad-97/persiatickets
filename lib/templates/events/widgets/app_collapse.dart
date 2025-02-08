import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:flutter/material.dart';

class AppCollapse extends StatelessWidget {
  const AppCollapse(
      {super.key, required this.title, this.subTitle, required this.children});

  final String title;
  final String? subTitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
          collapsedIconColor: Theme.of(context).appColors.fgQuinary400,
          iconColor: Theme.of(context).appColors.fgQuinary400,
          collapsedTextColor: Theme.of(context).appColors.textPrimary900,
          textColor: Theme.of(context).appColors.textPrimary900,
          enableFeedback: false,
          initiallyExpanded: true,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          childrenPadding: EdgeInsets.only(top: 24.0),
          subtitle: subTitle == null
              ? null
              : Text(subTitle!,
                  style: Theme.of(context).appTexts.textSmRegular.copyWith(
                      color: Theme.of(context).appColors.textTeritory600)),
          title: Text(title,
              style: Theme.of(context)
                  .appTexts
                  .displayXsSemibold
                  .copyWith(color: Theme.of(context).appColors.textPrimary900)),
          children: children),
    );
  }
}
