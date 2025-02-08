import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/component/app_switch.dart';
import 'package:flutter/material.dart';

class AccessibilityModal extends StatelessWidget {
  final OverlayPortalController controller;
  final Offset offset;
  final Widget child;
  final bool isApplyed;
  final Function(bool isApplyed) onApply;

  const AccessibilityModal({
    super.key,
    required this.controller,
    required this.offset,
    required this.isApplyed,
    required this.onApply,
    required this.child,
  });

  static final _link = LayerLink();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, limits) => OverlayPortal(
        controller: controller,
        overlayChildBuilder: (context) => Stack(
          children: [
            ModalBarrier(
              onDismiss: () => controller.hide(),
            ),
            CompositedTransformFollower(
                link: _link,
                offset: offset,
                targetAnchor: Alignment.centerLeft,
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).appColors.bgSecondary,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                          color: Theme.of(context).appColors.borderSecondary)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text('Show wheelchair seats',
                            style: Theme.of(context)
                                .appTexts
                                .textSmSemiBord
                                .copyWith(
                                    color: Theme.of(context)
                                        .appColors
                                        .textSecondary700)),
                      ),
                      AppSwitch.main(
                        label: '',
                        enableColor: Theme.of(context).appColors.bgBrandSolid,
                        diableColor: Theme.of(context).appColors.bgTertiary,
                        enable: isApplyed,
                        onChange: onApply,
                      ),
                    ],
                  ),
                )),
          ],
        ),
        child: CompositedTransformTarget(
          link: _link,
          child: InkWell(onTap: () => controller.toggle(), child: child),
        ),
      ),
    );
  }
}
