import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:flutter/material.dart';

class OrSepreatpr extends BaseStatelessWidget {
  OrSepreatpr({super.key});

  @override
  Widget body(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Theme.of(context).appColors.borderPrimary,
            height: 1,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          child: Text(
            getString("or").toUpperCase(),
            style: Theme.of(context)
                .appTexts
                .textSmMedium
                .copyWith(color: Theme.of(context).appColors.textTeritory600),
          ),
        ),
        Expanded(
          child: Container(
            color: Theme.of(context).appColors.borderPrimary,
            height: 1,
          ),
        ),
      ],
    );
  }
}
