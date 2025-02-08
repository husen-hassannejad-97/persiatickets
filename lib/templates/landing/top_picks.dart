import 'dart:ui';

import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/component/empty_modal.dart';
import 'package:billit_now/core/localization/layout_direction.dart';
import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:billit_now/repositories/event/models/event_range_model.dart';
import 'package:billit_now/templates/landing/landing_data_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TopPicks extends BaseStatefulWidget {
  final List<EventRangeModel> tabRanges = filterTabRanges;
  final Function(EventRangeModel) onTabChange;

  TopPicks({super.key, required this.onTabChange});

  @override
  State<StatefulWidget> createState() =>
      _TopPicks();
}

class _TopPicks extends BaseWidgetState<TopPicks> {
  _TopPicks();

  @override
  bool get wantKeepAlive => true;

  @override
  bool get visibilityDetection => true;
  @override
  Key get visibilityKey => Key("top_picks");

  @override
  void onVisible(BuildContext context) {
    if (kDebugMode) {
      print("Top Picks is Visible");
    }
  }

  @override
  void onInvisible(BuildContext context) {
    if (kDebugMode) {
      print("Top Picks is InVisible");
    }
  }

  @override
  Widget body(BuildContext context) {
    final tabs = widget.tabRanges.map((EventRangeModel model) {
      return <String, String>{'title': getString(model.toString().split('.')[1])};
    }).toList();
    final texts = [
      Text(getString("our_top_picks_in"),
          style: context.isRegularSmartphoneOrLess
              ? Theme.of(context).appTexts.displaySmSemibold.copyWith(
              color: Theme.of(context).appColors.textPrimary900)
              : Theme.of(context).appTexts.displayMdSemibold.copyWith(
              color: Theme.of(context).appColors.textPrimary900)),
      SizedBox(width: 16,),
      Text('Vienna, Austria',
          style: context.isRegularSmartphoneOrLess
              ? Theme.of(context)
              .appTexts
              .displaySmSemibold
              .copyWith(color: const Color(0xffB4D685))
              : Theme.of(context)
              .appTexts
              .displayMdSemibold
              .copyWith(color: const Color(0xffB4D685))),
    ];
    return Container(
      height: 244,
      padding: EdgeInsets.only(
          top: 64,
          left: getLayoutDirection() == LayoutDirection.ltr ? context.isRegularSmartphoneOrLess ? 16 : 96 : 96,
          right: getLayoutDirection() == LayoutDirection.ltr ? 96 : context.isRegularSmartphoneOrLess ? 16 : 96),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          const Color(0xff2A3B1A),
          Theme.of(context).appColors.bgPrimary,
        ],
        stops: const [0, 0.9],
        begin: const Alignment(-2.0, 1.2),
        end: const Alignment(-0.0, 0.5),
      )),
      child: Column(
          crossAxisAlignment: getLayoutDirection() == LayoutDirection.ltr
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            Flex(
              direction: context.isRegularSmartphoneOrLess
                  ? Axis.vertical
                  : Axis.horizontal,
              mainAxisAlignment: getLayoutDirection() == LayoutDirection.ltr
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: getLayoutDirection() == LayoutDirection.ltr
                  ? texts
                  : texts.reversed.toList(),
            ),
            const SizedBox(
          height: 32,
        ),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Theme.of(context).appColors.bgPrimary.withOpacity(0.4),
              child: DefaultTabController(
                    initialIndex: 0,
                    length: tabs.length,
                    child: Directionality(
                        textDirection:
                            getLayoutDirection() == LayoutDirection.ltr
                                ? TextDirection.ltr
                                : TextDirection.rtl,
                        child: TabBar(
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            indicator: BoxDecoration(
                              color: Theme.of(context).appColors.bgActive,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            unselectedLabelColor:
                                Theme.of(context).appColors.textTeritory600,
                            labelColor:
                                Theme.of(context).appColors.textPrimary900,
                            dividerColor: Colors.transparent,
                            labelPadding: const EdgeInsets.only(right: 2),
                            onTap: (index) {
                              widget.onTabChange(widget.tabRanges[index]);
                            },
                            tabs: List.generate(
                                tabs.length,
                                (index) => Tab(
                                      height: 36,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 0),
                                        child: Text(tabs[index]['title']!),
                                      ),
                                    )))),
                  ),
                ),
          ),
        ),
      ]),
    );
  }
}
