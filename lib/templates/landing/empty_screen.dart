import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyScreen extends BaseStatelessWidget {
  EmptyScreen({super.key});

  @override
  Widget body(BuildContext context) {
    return SizedBox(
      height: context.logicalHeight,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.logicalWidth / 4, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/anims/warning.json',
              height: 100,
              repeat: true,
              alignment: Alignment.center,
              fit: BoxFit.fill,
            ),
            Text(
                getString("no_events_found_message"),
                style: Theme.of(context).appTexts.displayMdSemibold.copyWith(
                    color: Theme.of(context).appColors.textPrimary900)),
          ],
        ),
      ),
    );
  }
}
