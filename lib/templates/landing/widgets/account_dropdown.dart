import 'package:billit_now/apps/helper/router/router_extention/login_router_extention.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/empty_modal.dart';
import 'package:billit_now/core/localization/layout_direction.dart';
import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:flutter/material.dart';

class AccountDropDown extends BaseStatefulWidget {
  final OverlayPortalController controller;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final List<DropdownMenuItem<String>> items;
  final Function(String?) onChanged;

  const AccountDropDown._internal(
      {super.key,
      required this.controller,
      this.border,
      this.borderRadius,
      required this.items,
      required this.onChanged});

  factory AccountDropDown.logIn(
          {Key? key,
          required BuildContext context,
          required OverlayPortalController controller,
          required List<DropdownMenuItem<String>> items,
          BoxBorder? border,
          BorderRadius? borderRadius,
          required Function(String?) onChanged}) =>
      AccountDropDown._internal(
        key: key,
        controller: controller,
        border: border ??
            Border.all(
              color: Theme.of(context).appColors.borderPrimary,
            ),
        borderRadius:
            borderRadius ?? const BorderRadius.all(Radius.circular(8.0)),
        items: items,
        onChanged: onChanged,
      );

  @override
  State<AccountDropDown> createState() => _AccountDropDownState();
}

class _AccountDropDownState extends BaseWidgetState<AccountDropDown> {
  static final _link = LayerLink();
  String? selectedItem;
  bool isShowingModal = false;

  @override
  Widget body(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 40,
        width: 40,
        child: LayoutBuilder(
          builder: (context, limits) => OverlayPortal(
            controller: widget.controller,
            overlayChildBuilder: (context) => Stack(
              children: [
                ModalBarrier(
                  onDismiss: () {
                    widget.controller.hide();
                    setState(() {
                      isShowingModal = false;
                    });
                  },
                ),
                CompositedTransformFollower(
                  link: _link,
                  offset: getLayoutDirection() == LayoutDirection.ltr
                      ? Offset(-200, 35)
                      : Offset(0, 35),
                  targetAnchor: Alignment.centerLeft,
                  child: Container(
                      width: 248,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Theme.of(context).appColors.bgSecondary,
                        border: Border.all(
                            color: Theme.of(context).appColors.borderSecondary,
                            width: 1),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .appColors
                                .fgQuinary400
                                .withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Directionality(textDirection: TextDirection.ltr, child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:
                                  getLayoutDirection() == LayoutDirection.ltr
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                              children: [
                            SizedBox(
                              width: 180,
                              child: AppButton.buttonIcon(AppIconName.ueaf2Zap,
                                  text: getString("create_and_host_events"),
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 8),
                                  bgColor: Colors.transparent,
                                  bgHoverColor: Colors.transparent,
                                  isRTL: getLayoutDirection() == LayoutDirection.rtl,
                                  textColor: Theme.of(context)
                                      .appColors
                                      .textSecondary700,
                                  context: context, onTap: () {
                                    widget.controller.hide();
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return EmptyModal.show(context: context);
                                      },
                                    );
                                  }),
                            ),
                            SizedBox(
                              width: 160,
                              child: AppButton.buttonIcon(
                                  AppIconName.uec4fMessageChatCircle,
                                  text: getString("customer_support"),
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 8),
                                  bgColor: Colors.transparent,
                                  bgHoverColor: Colors.transparent,
                                  isRTL: getLayoutDirection() == LayoutDirection.rtl,
                                  textColor: Theme.of(context)
                                      .appColors
                                      .textSecondary700,
                                  context: context, onTap: () {
                                widget.controller.hide();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return EmptyModal.show(context: context);
                                  },
                                );
                              }),
                            ),
                            SizedBox(
                              width: 120,
                              child: AppButton.buttonIcon(
                                  AppIconName.ueb42HelpCircle,
                                  text: getString("help_center"),
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 8),
                                  bgColor: Colors.transparent,
                                  bgHoverColor: Colors.transparent,
                                  isRTL: getLayoutDirection() == LayoutDirection.rtl,
                                  textColor: Theme.of(context)
                                      .appColors
                                      .textSecondary700,
                                  context: context, onTap: () {
                                widget.controller.hide();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return EmptyModal.show(context: context);
                                  },
                                );
                              }),
                            ),
                            Divider(
                              color:
                              Theme.of(context).appColors.borderSecondary,
                              thickness: 1,
                            ),
                            AppButton.buttonPrimary(
                                context: context,
                                padding:
                                const EdgeInsets.symmetric(vertical: 8),
                                text: getString("login_or_signup"),
                                onTap: () {
                                  widget.controller.hide();
                                  context.goLoginEmail();
                                })
                          ],
                        )),
                      )),
                ),
              ],
            ),
            child: CompositedTransformTarget(
              link: _link,
              child: AppButton.buttonIcon(AppIconName.ueb92User01,
                  iconSize: 20,
                  bgColor: Colors.transparent,
                  bgHoverColor: Colors.transparent,
                  textColor: Colors.transparent,
                  padding: const EdgeInsets.all(2),
                  context: context,
                  border: Border.all(
                      color: isShowingModal
                          ? Theme.of(context).appColors.borderBrand
                          : Theme.of(context).appColors.buttonSecondaryBorder,
                      width: 1), onTap: () {
                widget.controller.toggle();
                setState(() {
                  isShowingModal = true;
                });
              }),
            ),
          ),
        ),
      ),
    );
  }
}
