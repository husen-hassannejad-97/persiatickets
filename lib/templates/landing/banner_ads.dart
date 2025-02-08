import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_video_player.dart';
import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:billit_now/templates/landing/utils.dart';
import 'package:billit_now/templates/shared/AdActionBloc.dart';
import 'package:flutter/foundation.dart';
import 'package:billit_now/component/empty_modal.dart';
import 'package:flutter/material.dart';

class BannerAds extends BaseStatefulWidget {
  final String adId;
  final String title;
  final String description;
  final String link;
  final String videoUrl;
  const BannerAds({
    super.key,
    required this.adId,
    required this.title,
    required this.description,
    required this.link,
    required this.videoUrl,
  });

  @override
  State<BannerAds> createState() => _BannerAdsState();
}

class _BannerAdsState extends BaseWidgetState<BannerAds> {
  @override
  bool get wantKeepAlive => true;

  @override
  bool get visibilityDetection => true;
  @override
  Key get visibilityKey => Key("banner_ads");

  @override
  bool allowRTLDirectionality() => true;

  @override
  void onVisible(BuildContext context) {
    if (kDebugMode) {
      print("Banner Ads is Visible");
    }
    addEvent(context, AdActionViewEvent(adId: widget.adId));
  }

  @override
  void onInvisible(BuildContext context) {
    if (kDebugMode) {
      print("Banner Ads is InVisible");
    }
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      height: context.isRegularSmartphoneOrLess ? 579 : 256,
      margin: EdgeInsets.symmetric(
          horizontal: context.isRegularSmartphoneOrLess ? 0 : 96),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: context.isRegularSmartphoneOrLess
              ? null
              : const BorderRadius.all(Radius.circular(12))),
      child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: context.isRegularSmartphoneOrLess
              ? Axis.vertical
              : Axis.horizontal,
          children: [
            SizedBox(
              width: context.logicalWidth / 3,
              height: context.isRegularSmartphoneOrLess ? 330 : 256,
              child: AppVideoPlayer.basic(
                network: true,
                video: widget.videoUrl,
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
              width: context.isRegularSmartphoneOrLess
                  ? context.logicalWidth
                  : context.logicalWidth < 1000
                      ? context.logicalWidth / 2.3
                      : context.logicalWidth / 2,
              padding: const EdgeInsets.only(
                  top: 32, bottom: 32, left: 26, right: 36),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .appTexts
                          .displaySmSemiBold
                          .copyWith(color: const Color(0xff171717)),
                    ),
                    Text(
                      widget.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .appTexts
                          .textMdRegular
                          .copyWith(color: const Color(0xff171717)),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      width: 180,
                      child: AppButton.buttonPrimary(
                          context: context,
                          text: getString("send_money_now"),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          onTap: () {
                            addEvent(context, AdActionClickEvent(adId: widget.adId));
                            launchURL(widget.link);
                            // showDialog(
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     return EmptyModal.show();
                            //   },
                            // );
                          }),
                    )
                  ]),
            )
          ]),
    );
  }
}
