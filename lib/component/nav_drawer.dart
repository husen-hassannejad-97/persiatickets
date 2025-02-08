import 'package:billit_now/apps/helper/router/router_extention/landing_router_extention.dart';
import 'package:billit_now/apps/helper/router/router_extention/login_router_extention.dart';
import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_text_field.dart';
import 'package:billit_now/component/empty_modal.dart';
import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:billit_now/local_storage/auth/AuthStorage.dart';
import 'package:billit_now/local_storage/auth/entities/token_entity.dart';
import 'package:flutter/material.dart';

import '../core/di/di_setup.dart';
import '../core/localization/languages.dart';
import '../core/localization/layout_direction.dart';
import '../core/localization/localize.dart';
import '../repositories/event/models/lang_model.dart';
import 'modal_dropdown.dart';

class NavDrawer extends BaseStatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends BaseWidgetState<NavDrawer> {
  bool? isLogedIn;

  final OverlayPortalController langCurrencyDropDownController =
    OverlayPortalController();

  @override
  void initState() {
    super.initState();

    _checkIsLogedIn();
  }

  _checkIsLogedIn() {
    AuthStorage().readTokenAsString().then((String? value) {
      if (value != null) {
        setState(() {
          isLogedIn = true;
        });
      }
    });
  }

  @override
  Drawer body(BuildContext context) {
    return Drawer(
        elevation: 20.0,
        backgroundColor: Theme.of(context).appColors.bgPrimary,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.zero)),
        child: Row(
          children: [
            // Body
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: context.logicalHeight,
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // logo
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: AppIcon.logo(
                      appIconName: AppIconName.logoFullLTR,
                      context: context,
                      size: 30,
                    ),
                  ),
                  // search
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 0),
                    child: AppTextField.main(
                      controller: TextEditingController(),
                      keyboardType: TextInputType.text,
                      helpText: '',
                      placeHolder: 'Search',
                      icon: AppIconName.ueb1dSearchLg,
                      iconColor: Theme.of(context).appColors.fgSecondary700,
                      iconSize: 15,
                      validator: (_) {
                        return null;
                      },
                    ),
                  ),
                  // top buttons
                  AppButton.buttonTertiary(
                      context: context,
                      text: 'Home',
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      align: MainAxisAlignment.start,
                      onTap: () {
                        context.goLanding();
                      }),
                  AppButton.buttonTertiary(
                      context: context,
                      text: 'Events',
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      align: MainAxisAlignment.start,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return EmptyModal.show(context: context);
                          },
                        );
                      }),
                  AppButton.buttonTertiary(
                      context: context,
                      text: 'Artists',
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      align: MainAxisAlignment.start,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return EmptyModal.show(context: context);
                          },
                        );
                      }),
                  AppButton.buttonTertiary(
                      context: context,
                      text: 'Venues',
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      align: MainAxisAlignment.start,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return EmptyModal.show(context: context);
                          },
                        );
                      }),
                  Container(
                    constraints: BoxConstraints(
                        minHeight: context.logicalHeight / 8,
                        maxHeight: context.logicalHeight / 2),
                    height: context.logicalHeight / 8,
                  ),
                  // bottom Btns
                  AppButton.buttonIcon(AppIconName.ueaf2Zap,
                      text: 'Create & host events',
                      iconSize: 20,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      align: MainAxisAlignment.start,
                      bgColor: Colors.transparent,
                      bgHoverColor: Theme.of(context).appColors.bgActive,
                      textColor: Theme.of(context).appColors.textPrimary900,
                      iconColor: Theme.of(context).appColors.navItemIconFg,
                      context: context, onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EmptyModal.show(context: context);
                      },
                    );
                  }),
                  ModalDropDown.langCurrency(
                    controller: langCurrencyDropDownController,
                    context: context,
                    offset: context.isRegularSmartphoneOrLess
                        ? Offset(-100, -200)
                        : (getLayoutDirection() == LayoutDirection.ltr
                        ? Offset(-200, 35)
                        : Offset(0, 35)),
                    onChangeLang: (LangCurrencyModel lang) {
                      for(int i = 0; i < Language.values.length; i++) {
                        if(lang.title == Language.values[i].title &&
                            lang.subTitle == Language.values[i].subTitle) {
                          getIt<Localize>().setSelectedLanguage(Language.values[i]);
                          break;
                        }
                      }
                    },
                    onChangeCurrency: (LangCurrencyModel currency) {},
                  ),
                  AppButton.buttonIcon(AppIconName.uec4fMessageChatCircle,
                      text: 'Customer support',
                      iconSize: 20,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      align: MainAxisAlignment.start,
                      bgColor: Colors.transparent,
                      bgHoverColor: Theme.of(context).appColors.bgActive,
                      textColor: Theme.of(context).appColors.textPrimary900,
                      iconColor: Theme.of(context).appColors.navItemIconFg,
                      context: context, onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EmptyModal.show(context: context);
                      },
                    );
                  }),
                  AppButton.buttonIcon(AppIconName.ueb42HelpCircle,
                      text: 'Help center',
                      iconSize: 20,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      align: MainAxisAlignment.start,
                      bgColor: Colors.transparent,
                      bgHoverColor: Theme.of(context).appColors.bgActive,
                      textColor: Theme.of(context).appColors.textPrimary900,
                      iconColor: Theme.of(context).appColors.navItemIconFg,
                      context: context, onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EmptyModal.show(context: context);
                      },
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: isLogedIn == true
                        ? AppButton.buttonPrimary(
                            context: context,
                            text: 'Logout',
                            isLoading: false,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            onTap: () => null)
                        : AppButton.buttonPrimary(
                            context: context,
                            text: 'Log in or sign up',
                            isLoading: false,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            onTap: () => context.goLoginEmail()),
                  )
                ],
              ),
            )),
            // right line
            Container(
              height: context.logicalHeight,
              width: 50,
              color: Theme.of(context).appColors.bgOverlay,
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: AppButton.buttonIcon(AppIconName.ueaefXClose,
                          bgColor: Colors.transparent,
                          bgHoverColor: Colors.transparent,
                          textColor: Theme.of(context).appColors.textWhite,
                          context: context,
                          iconSize: 24,
                          iconColor: Theme.of(context).appColors.textWhite,
                          onTap: () => Scaffold.of(context).closeEndDrawer())),
                  Expanded(child: Container())
                ],
              ),
            ),
          ],
        ));
  }
}
