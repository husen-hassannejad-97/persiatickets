import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/repositories/event_map/models/sort_filter.dart';
import 'package:flutter/material.dart';

class SortingModal extends StatefulWidget {
  final OverlayPortalController controller;
  final Offset offset;
  final SortFilter initValue;
  final List<SortFilter> sortList;
  final Function(SortFilter value) onApply;
  final Widget child;

  const SortingModal({
    super.key,
    required this.controller,
    required this.offset,
    required this.initValue,
    required this.sortList,
    required this.onApply,
    required this.child,
  });

  static final _link = LayerLink();

  @override
  State<SortingModal> createState() => _SortingModalState();
}

class _SortingModalState extends State<SortingModal> {
  late SortFilter _groupValue;

  @override
  initState() {
    super.initState();
    _groupValue = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, limits) => OverlayPortal(
        controller: widget.controller,
        overlayChildBuilder: (context) => Stack(
          children: [
            ModalBarrier(
              onDismiss: () => widget.controller.hide(),
            ),
            CompositedTransformFollower(
                link: SortingModal._link,
                offset: widget.offset,
                targetAnchor: Alignment.centerLeft,
                child: Container(
                  width: 200,
                  height: widget.sortList.length * 43.0,
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.0, vertical: 9.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).appColors.bgSecondary,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                          color: Theme.of(context).appColors.borderSecondary)),
                  child: Column(
                    children: List.generate(
                      widget.sortList.length,
                      (index) => _radioButton(
                        context,
                        widget.sortList[index],
                        _groupValue,
                        (value) {
                          widget.onApply(value);
                        },
                      ),
                    ),
                  ),
                )),
          ],
        ),
        child: CompositedTransformTarget(
          link: SortingModal._link,
          child: InkWell(
              onTap: () => widget.controller.toggle(), child: widget.child),
        ),
      ),
    );
  }

  _radioButton(BuildContext context, SortFilter value, SortFilter groupValue,
          Function(SortFilter) onChanged) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 9.0),
        child: InkWell(
          onTap: () {
            setState(() {
              _groupValue = value;
              widget.controller.toggle();
              onChanged(value);
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value.title,
                  style: Theme.of(context).appTexts.textSmMedium.copyWith(
                      color: Theme.of(context).appColors.textPrimary900)),
              value == groupValue
                  ? AppIcon.button(
                      appIconName: AppIconName.filledCircleCheckDefault,
                      color: Theme.of(context).appColors.fgBrandPrimary600,
                      size: 13.0,
                      context: context)
                  : Container()
            ],
          ),
        ),
      );
}
