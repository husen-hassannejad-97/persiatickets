import 'package:billit_now/apps/helper/router/router_extention/login_router_extention.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/templates/auth/widgets/auth_scaffold.dart';
import 'package:billit_now/templates/auth/widgets/main_logo.dart';
import 'package:flutter/material.dart';

import '../../../features/base/base_stateless_page.dart';

class ForgotPasswordStep4Page extends BaseStatelessPage {
  const ForgotPasswordStep4Page({super.key});

  @override
  bool allowRTLDirectionality() => true;

  @override
  Widget body(BuildContext context) {
    return ForgotPasswordStep4();
  }

}

class ForgotPasswordStep4 extends BaseStatelessPage {
  ForgotPasswordStep4({super.key});

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
                        MainLogo(iconName: AppIconName.success),
                        const SizedBox(height: 24),
                        // title
                        Container(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Center(
                            child: Text(
                              getString("password_reset"),
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
                            getString("password_reset_success_message"),
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
                    Column(
                      children: [
                        AppButton.buttonPrimary(
                          text: getString("go_to_log_in"),
                          context: context,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          onTap: () {
                            context.goLoginEmail();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
