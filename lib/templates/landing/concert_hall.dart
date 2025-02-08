import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_slider.dart';
import 'package:billit_now/component/app_video_player.dart';
import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ConcertHall extends BaseStatefulWidget {
  const ConcertHall({super.key, required this.title, required this.tabs});

  final String title;
  final List<Map<String, String>> tabs;

  @override
  State<ConcertHall> createState() => _ConcertHallState();
}

class _ConcertHallState extends BaseWidgetState<ConcertHall> {
  CarouselSliderController carouselController = CarouselSliderController();
  double complatedVideoPercent = 0.0;
  int selectedTabIndex = 0;
  String currentVideo = "";
  String currentVideoThumbnail = "";
  GlobalKey _playerKey = GlobalKey();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    setPlayerVideo(widget.tabs[selectedTabIndex]['video']!,
        widget.tabs[selectedTabIndex]['thumbnail']!);
  }

  void setPlayerVideo(String link, String thumbnail) {
    setState(() {
      currentVideo = link;
      currentVideoThumbnail = thumbnail;
      _playerKey = GlobalKey();
    });
  }

  @override
  Widget body(BuildContext context) {
    return widget.tabs.isEmpty
        ? Container()
        : Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: context.logicalHeight,
                width: context.logicalWidth,
                child: AppVideoPlayer.basic(
                  key: _playerKey,
                  video: currentVideo,
                  thumbnail: currentVideoThumbnail,
                  showControls: false,
                  loadingWidth: context.logicalWidth,
                  durations: (currentDuration, totalDuration) {},
                  percentOfCompletion: (double percent) {
                    if (percent > 0.8) {
                      carouselController.nextPage();
                    }

                    if (percent != complatedVideoPercent) {
                      setState(() {
                        complatedVideoPercent = percent;
                      });
                    }
                  },
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 96),
                  child: Text(widget.title,
                      textAlign: TextAlign.center,
                      style: context.isRegularSmartphoneOrLess
                          ? Theme.of(context)
                              .appTexts
                              .displayMdSemibold
                              .copyWith(
                                  color: Theme.of(context).appColors.textWhite)
                          : Theme.of(context)
                              .appTexts
                              .displayXlSemibold
                              .copyWith(
                                  color:
                                      Theme.of(context).appColors.textWhite)),
                ),
              ),
              // top gradient
              Positioned(
                right: 0,
                left: 0,
                top: 0,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).appColors.bgPrimary,
                        Theme.of(context).appColors.bgPrimary.withOpacity(0.8),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.6, 1.0],
                    ),
                  ),
                ),
              ),
              // botton gradient
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Theme.of(context).appColors.bgPrimary,
                        Theme.of(context).appColors.bgPrimary.withOpacity(0.9),
                        Colors.transparent,
                      ],
                      stops: const [0.2, 0.7, 1.0],
                    ),
                  ),
                ),
              ),
              // bottom widgets
              Positioned(
                right: 10,
                left: 10,
                bottom: 10,
                child: Column(
                  children: [
                    // video complitor
                    SizedBox(
                        width: 350,
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          width: 350,
                          height: 3,
                          child: LinearProgressIndicator(
                              minHeight: 3,
                              value: complatedVideoPercent.isNaN
                                  ? 0
                                  : complatedVideoPercent,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).appColors.fgTertiary600),
                              backgroundColor: Theme.of(context)
                                  .appColors
                                  .alphaWite20
                                  .withOpacity(.5)),
                        )),

                    const SizedBox(height: 16),
                    // tabs btn
                    _tabSlider(carouselController)
                  ],
                ),
              ),
            ],
          );
  }

  Widget _tabSlider(CarouselSliderController carouselController) => SizedBox(
        width: 420,
        child: Stack(
          children: [
            AppSlider.text(
                items: List.generate(
                  widget.tabs.length,
                  (int index) => AppButton.buttonTertiary(
                      text: widget.tabs[index]['title'],
                      textStyle: selectedTabIndex == index
                          ? context.isRegularSmartphoneOrLess
                              ? Theme.of(context).appTexts.textMdSemiBold
                              : Theme.of(context).appTexts.textLgSemiBold
                          : context.isRegularSmartphoneOrLess
                              ? Theme.of(context).appTexts.textMdRegular
                              : Theme.of(context).appTexts.textLgRegular,
                      textColor: selectedTabIndex == index
                          ? Theme.of(context).appColors.textWhite
                          : Theme.of(context).appColors.fgTertiary600,
                      bgHoverColor: Colors.transparent,
                      context: context,
                      onTap: () {
                        // carouselController.jumpToPage(index);
                      }),
                ),
                buttonCarouselController: carouselController,
                height: 50,
                onPageChanged: (index, __) {
                  setState(() {
                    selectedTabIndex = index;
                    setPlayerVideo(widget.tabs[selectedTabIndex]['video']!,
                        widget.tabs[selectedTabIndex]['thumbnail']!);
                  });
                }),
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  carouselController.previousPage();
                },
                child: Container(
                  width: 120,
                  height: 30,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Theme.of(context).appColors.bgPrimary.withOpacity(0.8),
                        Theme.of(context).appColors.bgPrimary.withOpacity(0.5),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.7, 1.0],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  carouselController.nextPage();
                },
                child: Container(
                  width: 120,
                  height: 30,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Theme.of(context).appColors.bgPrimary.withOpacity(0.8),
                        Theme.of(context).appColors.bgPrimary.withOpacity(0.5),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.7, 1.0],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
