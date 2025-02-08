import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_video_player.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:billit_now/repositories/event/models/event_ad_banner_model.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EventAdBanner extends BaseStatelessWidget {
  EventAdBanner({
    super.key,
    required this.data,
  });

  final EventAdBannerModel data;

  @override
  Widget body(BuildContext context) {
    return Container(
      height: context.isRegularSmartphoneOrLess ? 579 : 256,
      margin: EdgeInsets.only(top: 24.0),
      decoration: BoxDecoration(
          color: Theme.of(context).appColors.bgSecondary,
          borderRadius: const BorderRadius.all(Radius.circular(8.0))),
      child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: context.isRegularSmartphoneOrLess
              ? Axis.vertical
              : Axis.horizontal,
          children: [
            SizedBox(
              width: context.logicalWidth / 4,
              height: context.isRegularSmartphoneOrLess ? 330 : 256,
              child: AppVideoPlayer.basic(
                network: true,
                video: 'assets/videos/ads.mp4',
                thumbnail: 'assets/images/ads.png',
                radius: context.isRegularSmartphoneOrLess
                    ? const BorderRadius.all(Radius.circular(0))
                    : const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0)),
                showControls: true,
                durations: (currentDuration, totalDuration) {},
                percentOfCompletion: (double percent) {},
                loadingWidth: context.logicalWidth / 3,
              ),
            ),
            Container(
              width: context.logicalWidth / 2.4,
              padding: const EdgeInsets.only(
                  top: 32, bottom: 32, left: 26, right: 36),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .appTexts
                          .displaySmSemiBold
                          .copyWith(
                              color:
                                  Theme.of(context).appColors.textPrimary900),
                    ),
                    Text(
                      data.desc,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).appTexts.textMdRegular.copyWith(
                          color: Theme.of(context).appColors.textPrimary900),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      width: 155,
                      child: AppButton.buttonPrimary(
                          context: context,
                          text: data.btnTitle,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          onTap: () async {
                            await launchUrl(Uri.parse(data.link),
                                mode: LaunchMode.platformDefault);
                          }),
                    )
                  ]),
            )
          ]),
    );
  }
}
