import 'package:flutter/material.dart';

class SeatModal extends StatelessWidget {
  final OverlayPortalController controller;
  final Offset offset;
  final Widget child;

  const SeatModal._internal({
    super.key,
    required this.controller,
    required this.offset,
    required this.child,
  });

  factory SeatModal.def({
    Key? key,
    required BuildContext context,
    required OverlayPortalController controller,
    required Offset offset,
    required Widget child,
  }) =>
      SeatModal._internal(
        key: key,
        controller: controller,
        offset: offset,
        child: child,
      );

  static final _link = LayerLink();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 40,
        width: 40,
        child: LayoutBuilder(
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
                      width: 100,
                      height: 100,
                      color: Colors.red,
                    )),
              ],
            ),
            child: CompositedTransformTarget(
              link: _link,
              child: InkWell(onTap: () => controller.toggle(), child: child),
            ),
          ),
        ),
      ),
    );
  }
}
