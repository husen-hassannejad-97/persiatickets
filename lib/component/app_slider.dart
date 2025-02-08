import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AppSlider extends StatelessWidget {
  final List<Widget> items;
  final CarouselSliderController buttonCarouselController;
  final double height;
  final int initialPage;
  final bool enlargeCenterPage;
  final bool reverse;
  final bool infinitScroll;
  final double viewportFraction;
  final ScrollPhysics? scrollPhysics;
  final Function(int index, CarouselPageChangedReason reason) onPageChanged;

  const AppSlider._internal(
      {super.key,
      required this.items,
      required this.buttonCarouselController,
      required this.height,
      required this.initialPage,
      required this.enlargeCenterPage,
      required this.reverse,
      required this.infinitScroll,
      required this.viewportFraction,
      this.scrollPhysics,
      required this.onPageChanged});

  factory AppSlider.def({
    Key? key,
    required List<Widget> items,
    double height = 230,
    double viewportFraction = 0.35,
    int initialPage = 0,
    required CarouselSliderController buttonCarouselController,
    required Function(int index, CarouselPageChangedReason reason)
        onPageChanged,
  }) =>
      AppSlider._internal(
        items: items,
        buttonCarouselController: buttonCarouselController,
        height: height,
        initialPage: initialPage,
        enlargeCenterPage: true,
        reverse: true,
        infinitScroll: true,
        viewportFraction: viewportFraction,
        onPageChanged: onPageChanged,
      );

  factory AppSlider.text({
    Key? key,
    required List<Widget> items,
    double height = 50,
    bool reverse = false,
    required CarouselSliderController buttonCarouselController,
    required Function(int index, CarouselPageChangedReason reason)
        onPageChanged,
  }) =>
      AppSlider._internal(
        items: items,
        buttonCarouselController: buttonCarouselController,
        height: height,
        initialPage: 0,
        enlargeCenterPage: false,
        reverse: reverse,
        infinitScroll: true,
        viewportFraction: 0.34,
        onPageChanged: onPageChanged,
      );

  factory AppSlider.expanded({
    Key? key,
    required List<Widget> items,
    double viewportFraction = 0.21,
    bool reverse = false,
    bool infinitScroll = true,
    bool enlargeCenterPage = true,
    double height = 462,
    required int initialPage,
    required CarouselSliderController buttonCarouselController,
    required Function(int index, CarouselPageChangedReason reason)
        onPageChanged,
  }) =>
      AppSlider._internal(
        items: items,
        buttonCarouselController: buttonCarouselController,
        height: height,
        initialPage: initialPage,
        enlargeCenterPage: enlargeCenterPage,
        reverse: reverse,
        infinitScroll: infinitScroll,
        viewportFraction: viewportFraction,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
      );

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: items,
      carouselController: buttonCarouselController,
      options: CarouselOptions(
        height: height,
        autoPlay: false,
        enableInfiniteScroll: infinitScroll,
        enlargeCenterPage: enlargeCenterPage,
        initialPage: initialPage,
        reverse: reverse,
        viewportFraction: viewportFraction,
        onPageChanged: (index, reason) => onPageChanged(index, reason),
        scrollPhysics: scrollPhysics,
      ),
    );
  }
}
