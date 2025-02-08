import 'dart:ui';

import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:billit_now/templates/auth/signup/signup_data.dart';
import 'package:flutter/material.dart';

class StepsFooter extends BaseStatelessWidget {
  StepsFooter({super.key, required this.items});

  final List<Map<String, dynamic>> items;

  @override
  Widget body(BuildContext context) {
    bool isSmScreen = context.logicalWidth > 1200;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: Container(
          height: isSmScreen ? 80 : 20,
          color: Theme.of(context).appColors.alphaWite20.withOpacity(0.8),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: false,
            padding: context.isRegularTabletOrLess
                ? const EdgeInsets.symmetric(horizontal: 24)
                : const EdgeInsets.symmetric(horizontal: 64),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: items.length,
              crossAxisSpacing: 16,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: context.logicalWidth / items.length,
                  height: 2,
                  margin: const EdgeInsets.only(bottom: 12, top: 12),
                  color: items[index]['enable']
                      ? Theme.of(context).appColors.fgBrandPrimaryAlt
                      : Theme.of(context).appColors.bgQuaternary,
                ),
                isSmScreen
                    ? Text(items[index]['title'],
                        style: Theme.of(context)
                            .appTexts
                            .textSmSemiBord
                            .copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textSecondary700))
                    : Container(),
                isSmScreen
                    ? Text(items[index]['subTitle'],
                        style: Theme.of(context)
                            .appTexts
                            .textSmRegular
                            .copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textTeritory600))
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget create(
      SignupData data,
      Function(String) provideString,
      ) {
    final List<Map<String, dynamic>> items = [];
    if(data.head == SignupHead.email) {
      items.add(
          {
            'title': provideString("verify_your_email_address"),
            'subTitle': provideString("verification_of_the_code_sent"),
            'enable': data.email != null
          }
      );
      items.add(
          {
            'title': provideString("verify_your_phone_number"),
            'subTitle': provideString("provide_and_verify_phone_number"),
            'enable': data.phone != null
          }
      );
    } else if(data.head == SignupHead.phone) {
      items.add(
          {
            'title': provideString("verify_your_phone_number"),
            'subTitle': provideString("provide_and_verify_phone_number"),
            'enable': data.phone != null
          }
      );
      items.add(
          {
            'title': provideString("verify_your_email_address"),
            'subTitle': provideString("verification_of_the_code_sent"),
            'enable': data.email != null
          }
      );
    }
    items.add(
        {
          'title': provideString("complete_your_details"),
          'subTitle': provideString("provide_name_and_password"),
          'enable': data.email != null && data.phone != null
        }
    );
    items.add(
        {
          'title': provideString("agree_to_terms"),
          'subTitle': provideString("confirm_rules_to_finish_account_setup"),
          'enable': data.email != null && data.phone != null && data.firstName != null && data.lastName != null && data.password != null
        }
    );
    return StepsFooter(items: items);
  }

}
