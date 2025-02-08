import 'package:billit_now/apps/helper/router/router_extention/landing_router_extention.dart';
import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/modal_dropdown.dart';
import 'package:billit_now/repositories/event/models/header_navigation_model.dart';
import 'package:billit_now/repositories/event/models/lang_model.dart';
import 'package:billit_now/templates/events/widgets/header_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HeaderNavigation extends StatefulWidget implements PreferredSizeWidget {
  const HeaderNavigation(
      {super.key, required this.scrollController, required this.steps})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  final ScrollController scrollController;
  final List<HeaderNavigationModel> steps;

  @override
  State<HeaderNavigation> createState() => _HeaderNavigationState();

  @override
  final Size preferredSize;
}

class _HeaderNavigationState extends State<HeaderNavigation> {
  final OverlayPortalController langCurrencyDropDownController =
      OverlayPortalController();

  bool _isAppBarVisible = true;

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (widget.scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      // Scrolling down
      if (_isAppBarVisible) {
        setState(() {
          _isAppBarVisible = false;
        });
      }
    } else if (widget.scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      // Scrolling up
      if (!_isAppBarVisible) {
        setState(() {
          _isAppBarVisible = true;
        });
      }
    }
  }

  @override
  void dispose() {
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      height: _isAppBarVisible ? kToolbarHeight : 0,
      child: AppBar(
        actions: [
          context.logicalWidth < 1100
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AppButton.buttonIcon(AppIconName.ueb0aMenu02,
                      iconSize: 15,
                      bgColor: Colors.transparent,
                      bgHoverColor: Colors.transparent,
                      textColor: Colors.transparent,
                      padding: const EdgeInsets.all(2),
                      context: context,
                      onTap: () => Scaffold.of(context).openEndDrawer()),
                )
              : Container(),
        ],
        title: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: context.logicalWidth),
            margin: EdgeInsets.symmetric(
                horizontal: context.logicalWidth > 1200 ? 32 : 0, vertical: 12),
            child: context.logicalWidth < 1100 ? _smScreen() : _lgScreen(),
          ),
        ),
        backgroundColor: Theme.of(context).appColors.bgPrimary.withOpacity(0.9),
        shadowColor: Colors.transparent,
        surfaceTintColor: Theme.of(context).appColors.bgSecondary,
        foregroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  _lgScreen() =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        // Logo
        Row(
          children: [
            InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: AppIcon.logo(
                  appIconName: AppIconName.logoFullLTR,
                  context: context,
                  size: 30,
                ),
                onTap: () => context.goLanding()),
            Container(
              margin: EdgeInsets.only(left: 16.0),
              height: 32,
              child: VerticalDivider(
                color: Theme.of(context).appColors.borderSecondary,
                thickness: 1,
              ),
            ),
          ],
        ),
        // Steps
        Row(
          children: List.generate(
              widget.steps.length,
              (int index) =>
                  HeaderStep(index: index, step: widget.steps[index])),
        ),
        //  Lang / Currency
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 16.0),
              height: 32,
              child: VerticalDivider(
                color: Theme.of(context).appColors.borderSecondary,
                thickness: 1,
              ),
            ),
            ModalDropDown.langCurrency(
              controller: langCurrencyDropDownController,
              context: context,
              offset: Offset(-300, 35),
              onChangeLang: (LangCurrencyModel lang) {},
              onChangeCurrency: (LangCurrencyModel currency) {},
            ),
          ],
        )
      ]);
  _smScreen() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: AppIcon.logo(
              appIconName: AppIconName.logoFullLTR,
              context: context,
              size: 30,
            ),
            onTap: () => context.goLanding(),
          ),
        ],
      );
}
