import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:billit_now/templates/shared/AdActionBloc.dart';
import 'package:flutter/material.dart';

class InstagramCardAds extends BaseStatefulWidget {

  final String adId;
  final String link;
  final String accountImage;
  final String accountName;
  final String postImages;
  final String description;
  final Function(String) onTap;

  const InstagramCardAds._internal(
      {super.key,
        required this.adId,
        required this.link,
        required this.accountImage,
        required this.accountName,
        required this.postImages,
        required this.description,
        required this.onTap});

  factory InstagramCardAds.main(
      {required String accountImage,
        required String accountName,
        required String postImages,
        required String description,
        required String adId,
        required String link,
        required Function(String) onTap}) =>
      InstagramCardAds._internal(
        accountImage: accountImage,
        accountName: accountName,
        postImages: postImages,
        description: description,
        onTap: onTap,
        adId: adId,
        link: link,
      );

  @override
  State<StatefulWidget> createState() => _InstagramCardAds();

}

class _InstagramCardAds extends BaseWidgetState<InstagramCardAds> {

  @override
  bool get wantKeepAlive => true;

  @override
  bool get visibilityDetection => true;

  bool imageLoaded = false;
  bool visible = false;

  @override
  void onVisible(BuildContext context) {
    if(imageLoaded) {
      // addEvent(context, AdActionViewEvent(widget.adId));
    }
  }

  @override
  Widget body(BuildContext context) {
    return InkWell(
      onTap: () {
        addEvent(context, AdActionClickEvent(adId: widget.adId));
        widget.onTap(widget.link);
      },
      child: Container(
        width: 248,
        decoration: BoxDecoration(
            color: Theme.of(context).appColors.bgPrimary,
            border: Border.all(
              color: Theme.of(context).appColors.fgQuinary400,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Column(
          children: [
            // account name and image
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      // width: 24,
                      height: 32,
                      margin:
                          const EdgeInsets.only(top: 10, bottom: 8, left: 12),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.accountImage),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 8, left: 8),
                      child: Text(widget.accountName,
                          style: Theme.of(context)
                              .appTexts
                              .textMdMedium
                              .copyWith(
                                  color: Theme.of(context)
                                      .appColors
                                      .textPrimary900)),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 8, right: 12),
                  child: AppIcon.button(
                      appIconName: AppIconName.instagram,
                      context: context,
                      size: 20),
                )
              ],
            ),
            // post image slider
            SizedBox(
              height: 309,
              child: Stack(
                children: [
                  Image.network(
                    widget.postImages,
                    height: 309,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        // Image has fully loaded
                        imageLoaded = true;
                        if(visible) {
                          // addEvent(context, AdActionViewEvent(widget.adId));
                        }
                      }
                      return child;
                    }
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: AppIcon.button(
                        appIconName: AppIconName.pagination,
                        context: context,
                        size: 6,
                      ),
                    ),
                  )
                ],
              ),
            ),
            //description
            Container(
                margin: const EdgeInsets.all(12),
                child: RichText(
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                      text: '${widget.accountName}\t',
                      style: Theme.of(context).appTexts.textSmSemiBord.copyWith(
                          color: Theme.of(context).appColors.textPrimary900),
                      children: [
                        TextSpan(
                            text: widget.description,
                            style: Theme.of(context)
                                .appTexts
                                .textSmRegular
                                .copyWith(
                                    color: Theme.of(context)
                                        .appColors
                                        .textSecondary700))
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}
