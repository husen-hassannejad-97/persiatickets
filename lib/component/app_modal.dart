import 'package:flutter/material.dart';

class AppModal extends StatelessWidget {
  AppModal._internal(
      {super.key,
      required this.controller,
      required this.offset,
      required this.compositWidth,
      required this.compositHeight,
      required this.compositTarget,
      required this.body});

  final OverlayPortalController controller;
  final Offset offset;
  final double compositWidth;
  final double compositHeight;
  final Widget compositTarget;
  final Widget body;

  factory AppModal.show(
      {required OverlayPortalController controller,
      required Offset offset,
      required double compositWidth,
      required double compositHeight,
      required Widget compositTarget,
      required Widget body}) {
    return AppModal._internal(
        controller: controller,
        offset: offset,
        compositWidth: compositWidth,
        compositHeight: compositHeight,
        compositTarget: compositTarget,
        body: body);
  }

  final _link = LayerLink();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: 135,
        child: LayoutBuilder(
          builder: (context, limits) => OverlayPortal(
            controller: controller,
            overlayChildBuilder: (context) => Stack(
              children: [
                ModalBarrier(
                  onDismiss: () {
                    controller.hide();
                  },
                ),
                CompositedTransformFollower(
                    link: _link,
                    offset: offset,
                    targetAnchor: Alignment.centerLeft,
                    child: body),
              ],
            ),
            child: CompositedTransformTarget(
                link: _link,
                child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      controller.toggle();
                    },
                    child: compositTarget)),
          ),
        ),
      ),
    );
  }
}
