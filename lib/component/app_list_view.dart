import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:flutter/material.dart';

import '../core/localization/layout_direction.dart';

class AppListView extends BaseStatefulWidget {
  const AppListView({
    super.key,
    required this.controller,
    required this.items,
  });

  final ScrollController controller;
  final List<Widget> items;

  const AppListView._internal({
    super.key,
    required this.controller,
    required this.items,
  });

  factory AppListView.def({
    Key? key,
    required ScrollController controller,
    required List<Widget> items,
  }) =>
      AppListView._internal(
        controller: controller,
        items: items,
      );

  @override
  State<AppListView> createState() => _AppListViewState();
}

class _AppListViewState extends BaseWidgetState<AppListView> {
  @override
  Widget body(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.separated(
          controller: widget.controller,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: widget.items.length,
          itemBuilder: (context, index) => widget.items[index],
          separatorBuilder: (context, index) => const SizedBox(width: 32),
          reverse: getLayoutDirection() == LayoutDirection.rtl,
      ),
    );
  }
}
