import 'dart:async';
import 'dart:math';

import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_slider.dart';
import 'package:billit_now/component/empty_modal.dart';
import 'package:billit_now/component/instagram_card_ads.dart';
import 'package:billit_now/core/localization/languages.dart';
import 'package:billit_now/core/localization/layout_direction.dart';
import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:billit_now/repositories/ad/models/ad_model.dart';
import 'package:billit_now/templates/landing/utils.dart';
import 'package:billit_now/templates/landing/widgets/circular_percent_indicator.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../shared/Utils.dart';

import '../shared/AdActionBloc.dart';

class Ads {
  final int id;
  final String image;
  final String description;
  final int page;

  Ads(
      {required this.id,
      required this.image,
      required this.description,
      required this.page});
}

class Spotlight extends BaseStatefulWidget {
  const Spotlight(
      {super.key,
      required this.title,
      required this.onWebsiteTap,
      required this.adItems});

  final String title;
  final Function onWebsiteTap;
  final List<AdModel> adItems;

  @override
  State<Spotlight> createState() => _SpotlightState();
}

class _SpotlightState extends BaseWidgetState<Spotlight> {
  CarouselSliderController buttonCarouselController =
      CarouselSliderController();
  // scroll controlls
  final List<ScrollController> _controllers =
      List.generate(4, (_) => ScrollController());

  final COLUMN_DUPLICATION = 4;
  late List<List<Ads>> ads2part;
  late List<List<Ads>> ads3part;
  late List<List<Ads>> ads4part;

  final List<double> _speeds = [0.5, 0.7, 0.5, 0.7];
  final List<Timer> _timers = List<Timer>.empty(growable: true);

  // ads changer controlls
  Timer? _timer;
  int indexOfCompany = 0;

  // timing change auto events
  _startTiming(int seconds) {
    _timer?.cancel();
    int second = 0;

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (second < seconds) {
        second += 1;
      } else {
        second = 0;
        setState(() {
          if (widget.adItems[indexOfCompany].mediaUrls.isEmpty) {
            indexOfCompany =
                indexLoopMapper(indexOfCompany + 2, widget.adItems.length);
          } else {
            indexOfCompany =
                indexLoopMapper(indexOfCompany + 1, widget.adItems.length);
          }

          initAds();
          buttonCarouselController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initAds();

    _startScrolling();
    _startTiming(10);
  }

  @override
  void deactivate() {
    super.deactivate();
    for (final timer in _timers) {
      timer.cancel();
    }

    _timer?.cancel();
  }

  @override
  void activate() {
    super.activate();
    _startScrolling();
    _startTiming(10);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  bool get visibilityDetection => true;
  @override
  Key get visibilityKey => Key("spotlight");

  @override
  void onVisible(BuildContext context) {
    if (kDebugMode) {
      print("Spotlight is Visible");
    }
    addEvent(context,
        AdActionViewEvent(adId: widget.adItems[indexOfCompany].id.toString()));
  }

  @override
  void onInvisible(BuildContext context) {
    if (kDebugMode) {
      print("Spotlight is InVisible");
    }
  }

  // genrate list of ads for display these in 2 3 4 splitted parts
  List<List<Ads>> splitList(List<Ads> list, int parts) {
    // 1) Distribute items in a round-robin manner
    List<List<Ads>> result = List.generate(parts, (_) => []);

    for (int i = 0; i < list.length; i++) {
      result[i % parts].add(list[i]);
    }

    // 2) Edge case handling: if a column has only 1 item,
    // pick another item from a column that has more than 1 item
    Random random = Random();
    for (int i = 0; i < parts; i++) {
      if (result[i].length == 1) {
        // Attempt to find a random column that has more than 1 item
        int randomColumnIndex = i;
        int attempts = 0;
        const int maxAttempts = 50; // Avoid infinite loops in extreme cases

        while (
            (randomColumnIndex == i || result[randomColumnIndex].length < 2) &&
                attempts < maxAttempts) {
          randomColumnIndex = random.nextInt(parts);
          attempts++;
        }

        // If found a column with at least 2 items, move one randomly
        if (randomColumnIndex != i && result[randomColumnIndex].length > 1) {
          int randomItemIndex =
              random.nextInt(result[randomColumnIndex].length);
          Ads item = result[randomColumnIndex].removeAt(randomItemIndex);
          result[i].add(item);
        }
      }
    }

    // 3) Duplicate each column 3 times to have more data for smooth scrolling
    for (int i = 0; i < parts; i++) {
      List<Ads> originalColumn = result[i];
      List<Ads> extendedColumn = [];
      for (int j = 0; j < COLUMN_DUPLICATION; j++) {
        extendedColumn.addAll(originalColumn);
      }
      result[i] = extendedColumn;
    }

    return result;
  }

  List<Ads> duplicateItems(List<Ads> items, int count) {
    return List.generate(count, (_) => items).expand((x) => x).toList();
  }

  initAds() {
    List<Ads> ads =
        List.generate(widget.adItems[indexOfCompany].mediaUrls.length, (index) {
      return Ads(
          id: widget.adItems[indexOfCompany].id,
          image: widget.adItems[indexOfCompany].mediaUrls[index],
          description: widget.adItems[indexOfCompany].description,
          page: index + 1);
    });
    ads2part = splitList(ads, 2);
    ads3part = splitList(ads, 3);
    ads4part = splitList(ads, 4);
  }

  getNextCompany(int index) {
    buttonCarouselController.jumpToPage(index);
    _startTiming(10);

    setState(() {
      indexOfCompany = index;
      initAds();
    });
  }

  static const List<double> grayscaleMatrix = <double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ];

  @override
  Widget body(BuildContext context) {
    final position = getString("number_item_of")
        .replaceFirst(
        "[first_num]", (indexOfCompany + 1).toString())
        .replaceFirst(
        "[last_num]", widget.adItems.length.toString());
    final websiteAndPageNumberSection = [
      // brand website Btn
      context.isRegularSmartphoneOrLess
          ? Container()
          : AppButton.buttonTertiary(
          context: context,
          text:
          getString("[placeholder]_website").replaceFirst(
              "[placeholder]",
              widget.adItems[indexOfCompany].title),
          textStyle: Theme.of(context)
              .appTexts
              .textMdSemiBold
              .copyWith(
              color: Theme.of(context)
                  .appColors
                  .buttonTeritoryFg,),
          padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 8),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return EmptyModal.show(context: context);
              },
            );
          }),
      const SizedBox(
        width: 16,
      ),
      Text(
        getLanguage() == Language.ar || getLanguage() == Language.fa ?
        position.toNumberString(getLanguage()) : position,
        style: Theme.of(context).appTexts.textMdMedium.copyWith(
            color: Theme.of(context).appColors.textSecondary700),
        textDirection: getTextDirection(),
      ),
      const SizedBox(
        width: 16,
      ),
      // timer circle
      SizedBox(
          width: 24,
          height: 24,
          child: CircularPercentIndicator(
              percent:
              (indexOfCompany + 1) / widget.adItems.length)),
    ];
    final firstRow = [
      Text(
        widget.title,
        style: context.isRegularSmartphoneOrLess
            ? Theme.of(context).appTexts.displayXsSemibold.copyWith(
            color: Theme.of(context).appColors.textPrimary900)
            : Theme.of(context).appTexts.displaySmSemiBold.copyWith(
            color: Theme.of(context).appColors.textPrimary900),
      ),
      Row(
          children: getLayoutDirection() == LayoutDirection.ltr
              ? websiteAndPageNumberSection
              : websiteAndPageNumberSection.reversed.toList())
    ];
    // check if all companies are empty
    return Container(
      padding: EdgeInsets.only(
          left: context.isRegularSmartphoneOrLess ? 0 : 96,
          right: context.isRegularSmartphoneOrLess ? 0 : 96,
          top: 96,
          bottom: 48),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).appColors.bgPrimary,
            Theme.of(context).appColors.bgSecondary,
          ],
          stops: const [0.0, 1.0],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: context.isRegularSmartphoneOrLess ? 16 : 0,
                right: context.isRegularSmartphoneOrLess ? 16 : 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: getLayoutDirection() == LayoutDirection.ltr ? firstRow : firstRow.reversed.toList(),
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            height: context.isRegularSmartphoneOrLess ? 968 : 768,
            child: Stack(
              children: [
                context.isRegularSmartphoneOrLess
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(
                            2, (index) => _buildRow(index, ads2part[index])),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAli,
                        children: List.generate(
                            context.logicalWidth < 960 ? 3 : 4,
                            (index) => context.logicalWidth < 960
                                ? _buildColumn(index, 3, ads3part[index])
                                : _buildColumn(index, 4, ads4part[index])),
                      ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Container(
                //     width: context.logicalWidth,
                //     decoration: BoxDecoration(
                //       gradient: LinearGradient(
                //         begin: Alignment.bottomCenter,
                //         end: Alignment.topCenter,
                //         colors: [
                //           Theme.of(context)
                //               .appColors
                //               .bgSecondary
                //               .withOpacity(0.8),
                //           Colors.transparent,
                //         ],
                //         stops: const [0.0, 0.2],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(
            width: context.isRegularSmartphoneOrLess
                ? context.logicalWidth / 2
                : context.logicalWidth / 2.5,
            child: AppSlider.def(
                items: List.generate(
                    widget.adItems.length,
                    (int index) => InkWell(
                          onTap: () {
                            getNextCompany(index);
                          },
                          child: index != indexOfCompany
                              ? ColorFiltered(
                                  colorFilter:
                                      const ColorFilter.matrix(grayscaleMatrix),
                                  child: Image.network(
                                    widget.adItems[index].logo,
                                  ),
                                )
                              : Image.network(
                                  widget.adItems[index].logo,
                                ),
                        )),
                buttonCarouselController: buttonCarouselController,
                height: 80,
                initialPage: context.isRegularSmartphoneOrLess ? 0 : 2,
                viewportFraction:
                    context.isRegularSmartphoneOrLess ? 0.9 : 0.35,
                onPageChanged: (int index, __) {}),
          ),
          // brand website Btn
          context.isRegularSmartphoneOrLess
              ? SizedBox(
                  width: 170,
                  child: AppButton.buttonTertiary(
                      context: context,
                      text: getString("[placeholder]_website").replaceFirst(
                          "[placeholder]",
                          widget.adItems[indexOfCompany].title),
                      textStyle: Theme.of(context)
                          .appTexts
                          .textMdSemiBold
                          .copyWith(
                              color:
                                  Theme.of(context).appColors.buttonTeritoryFg),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      border: Border.all(
                          color: Theme.of(context).appColors.borderPrimary),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return EmptyModal.show(context: context);
                          },
                        );
                      }),
                )
              : Container()
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers and timers
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final timer in _timers) {
      timer.cancel();
    }

    _timer?.cancel();
    super.dispose();
  }

  void _startScrolling() {
    for (int i = 0; i < _controllers.length; i++) {
      Timer timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
        final controller = _controllers[i];
        if (controller.hasClients) {
          final position = controller.offset + _speeds[i];
          controller.jumpTo(position % controller.position.maxScrollExtent);
        }
      });
      _timers.add(timer);
    }
  }

  Widget _buildColumn(int columnIndex, int columnLength, List<Ads> adsItems) {
    // We need at least two items to scroll
    if (adsItems.length < 2) {
      adsItems = duplicateItems(adsItems, 2);
    }
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _speeds[columnIndex] = 0.0;
        });
      },
      onExit: (event) {
        setState(() {
          _speeds[columnIndex] = columnIndex.isOdd ? 0.5 : 0.7;
        });
      },
      child: SizedBox(
        width: (context.logicalWidth) / (columnLength + 1),
        child: ListView.builder(
          reverse: columnIndex.isOdd ? true : false,
          physics: const NeverScrollableScrollPhysics(),
          controller: _controllers[columnIndex],
          itemCount: adsItems.length,
          itemBuilder: (context, itemIndex) {
            return Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 8),
                child: InstagramCardAds.main(
                  link: widget.adItems[indexOfCompany].link.toString(),
                  adId: widget.adItems[indexOfCompany].id.toString(),
                  accountImage: widget.adItems[indexOfCompany].logo,
                  accountName: "", // TODO Doesn't give us this from server
                  postImages: adsItems[itemIndex].image,
                  description: adsItems[itemIndex].description,
                  onTap: (link) {
                    launchURL(link);
                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return EmptyModal.show();
                    //   },
                    // );
                  },
                ));
          },
        ),
      ),
    );
  }

  Widget _buildRow(int rowIndex, List<Ads> adsItems) {
    // We need at least two items to scroll
    if (adsItems.length < 2) {
      adsItems = duplicateItems(adsItems, 2);
    }
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _speeds[rowIndex] = 0.2;
        });
      },
      onExit: (event) {
        setState(() {
          _speeds[rowIndex] = rowIndex.isOdd ? 1.0 : 1.5;
        });
      },
      child: SizedBox(
        height: 470,
        child: ListView.builder(
          reverse: rowIndex.isOdd ? true : false,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: _controllers[rowIndex],
          itemCount: adsItems.length,
          itemBuilder: (context, itemIndex) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InstagramCardAds.main(
                link: widget.adItems[indexOfCompany].link.toString(),
                adId: widget.adItems[indexOfCompany].id.toString(),
                accountImage: widget.adItems[indexOfCompany].title,
                accountName: "", // TODO Doesn't give us this from server
                postImages: adsItems[itemIndex].image,
                description: adsItems[itemIndex].description,
                onTap: (link) {
                  launchURL(link);
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return EmptyModal.show();
                  //   },
                  // );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
