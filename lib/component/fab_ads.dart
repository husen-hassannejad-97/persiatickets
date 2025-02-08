import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/component/app_video_player.dart';
import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:flutter/material.dart';

class FabAds extends BaseStatefulWidget {
  const FabAds(
      {super.key,
      required this.adId,
      required this.video,
      required this.brandImage,
      required this.brandName,
      required this.thumbnail});

  final String adId;
  final String video;
  final String brandImage;
  final String brandName;
  final String thumbnail;

  @override
  State<FabAds> createState() => _FabAdsState();
}

class _FabAdsState extends BaseWidgetState<FabAds> {
  bool isExpanded = false;
  double width = 96;
  double height = 96;

  @override
  Widget body(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isExpanded = true;
          width = 216;
          height = 270;
        });
      },
      onExit: (event) {
        setState(() {
          isExpanded = false;
          width = 96;
          height = 96;
        });

        // dispose expanded video on circular mode
        // _expandedVideoController.dispose();

        // initializeVideoController();
      },
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Theme.of(context).appColors.bgSecondary,
            borderRadius:
                BorderRadius.all(Radius.circular(isExpanded ? 12 : 100)),
          ),
          child: isExpanded
              ? isExpandedView()
              : ClipOval(
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: AppVideoPlayer.basic(
                        video: widget.video,
                        network: true,
                        thumbnail: widget.thumbnail,
                        loadingWidth: 10,
                        showControls: false,
                        durations: (_, __) {},
                        percentOfCompletion: (_) {}),
                  ),
                )),
    );
  }

  Widget isExpandedView() => Column(
        children: [
          Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                child: AppVideoPlayer.basic(
                    video: widget.video,
                    thumbnail: widget.thumbnail,
                    network: true,
                    loadingWidth: 10,
                    showControls: true,
                    durations: (_, __) {},
                    percentOfCompletion: (_) {}),
              )),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.brandImage),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    widget.brandName,
                    style: Theme.of(context).appTexts.textMdMedium.copyWith(
                        color: Theme.of(context).appColors.textPrimary900),
                    // TODO Implement click
                  )
                ],
              ),
            ),
          )
        ],
      );
}
