import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:billit_now/repositories/event/models/cancellation_policy_model.dart';
import 'package:billit_now/templates/events/widgets/app_collapse.dart';
import 'package:flutter/material.dart';

class CancellationPolicy extends BaseStatelessWidget {
  CancellationPolicy({super.key, required this.data});

  final CancellationPolicyModel data;

  @override
  Widget body(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return AppCollapse(
          title: data.title,
          children: List.generate(
              data.policies.length,
              (int index) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      index == 0
                          ? Container()
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 24.0),
                              child: Divider(
                                color: Theme.of(context)
                                    .appColors
                                    .borderPrimary
                                    .withOpacity(0.2),
                                thickness: 1.0,
                              ),
                            ),
                      Text(
                        data.policies[index].title,
                        style: Theme.of(context)
                            .appTexts
                            .textLgSemiBold
                            .copyWith(
                                color:
                                    Theme.of(context).appColors.textPrimary900),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppIcon.button(
                              appIconName: AppIconName(data.policies[index].icon),
                              size: 24.0,
                              context: context),
                          SizedBox(width: 8.0),
                          SizedBox(
                            width: constraint.maxWidth - 50,
                            child: Text(
                              data.policies[index].description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .appTexts
                                  .textMdRegular
                                  .copyWith(
                                      color: Theme.of(context)
                                          .appColors
                                          .textSecondary700),
                            ),
                          )
                        ],
                      )
                    ],
                  )));
    });
  }
}
