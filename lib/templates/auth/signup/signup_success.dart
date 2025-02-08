import 'package:billit_now/apps/helper/router/router_extention/login_router_extention.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_switch.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:billit_now/templates/auth/widgets/auth_scaffold.dart';
import 'package:flutter/material.dart';

class SignupSuccess extends BaseStatelessWidget {
  SignupSuccess({super.key});

  @override
  bool allowRTLDirectionality() => true;

  final ScrollController _scrollController = ScrollController();

  @override
  Widget body(BuildContext context) {
    return AuthScaffold(
      scrollController: _scrollController,
      body: SingleChildScrollView(
          controller: _scrollController,
          padding: Theme.of(context)
              .appDimensions
              .horizontalRespoonsivePaddingLoginSingUp,
          child: Align(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints:
                  Theme.of(context).appDimensions.minMaxWidthLoginSingUp,
              child: Container(
                margin:
                    Theme.of(context).appDimensions.topBottonMarginLoginSingUp,
                child: Column(
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: Column(children: [
                        // logo
                        AppIcon.logo(
                          appIconName: AppIconName.success,
                          context: context,
                          size: 48,
                        ),
                        const SizedBox(height: 24),
                        // title
                        Container(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Center(
                            child: Text(
                              getString("success_created_account"),
                              style: Theme.of(context)
                                  .appTexts
                                  .displaySmSemiBold
                                  .copyWith(
                                      color: Theme.of(context)
                                          .appColors
                                          .textPrimary900),
                            ),
                          ),
                        ),
                        // subtitle
                        Center(
                          child: Text(
                            getString("your_account_has_been_successfully_created"),
                            style: Theme.of(context)
                                .appTexts
                                .textMdRegular
                                .copyWith(
                                    color: Theme.of(context)
                                        .appColors
                                        .textTeritory600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ]),
                    ),
                    // Content
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          border: Border.all(
                              color:
                                  Theme.of(context).appColors.borderSecondary)),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Text(getString("notifications_from_us"),
                              style: Theme.of(context)
                                  .appTexts
                                  .textLgSemiBold
                                  .copyWith(
                                      color: Theme.of(context)
                                          .appColors
                                          .textPrimary900)),
                          Text(
                              getString("select_notification_message"),
                              style: Theme.of(context)
                                  .appTexts
                                  .textMdRegular
                                  .copyWith(
                                      color: Theme.of(context)
                                          .appColors
                                          .textTeritory600)),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              AppSwitch.main(
                                label: getString("email"),
                                enableColor:
                                    Theme.of(context).appColors.bgBrandSolid,
                                diableColor:
                                    Theme.of(context).appColors.bgTertiary,
                                enable: true,
                                onChange: (value) {},
                              ),
                              const SizedBox(width: 32),
                              AppSwitch.main(
                                label: getString("sms"),
                                enableColor:
                                    Theme.of(context).appColors.bgBrandSolid,
                                diableColor:
                                    Theme.of(context).appColors.bgTertiary,
                                enable: false,
                                onChange: (value) {},
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    AppButton.buttonPrimary(
                      text: getString("confirm_settings"),
                      context: context,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      onTap: () {
                        context.goLoginWelcome();
                        // if (_verifyFormKey.currentState!
                        //     .validate()) {
                        //   // Process the email, e.g., send it to a server
                        //   print(
                        //       'Email: ${_codeVerifyController.text}');
                        // }
                      },
                    ),
                    // email validation form
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
