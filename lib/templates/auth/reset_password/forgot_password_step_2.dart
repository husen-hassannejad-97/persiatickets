import 'package:billit_now/apps/helper/router/router_extention/login_router_extention.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:billit_now/templates/auth/widgets/auth_scaffold.dart';
import 'package:billit_now/templates/auth/widgets/main_logo.dart';
import 'package:billit_now/templates/auth/widgets/steps_footer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordStep2Page extends BaseStatefulWidget {
  const ForgotPasswordStep2Page({super.key});

  @override
  State<ForgotPasswordStep2Page> createState() =>
      _ForgotPasswordStep2PageState();
}

class _ForgotPasswordStep2PageState
    extends BaseWidgetState<ForgotPasswordStep2Page> {
  final ScrollController _scrollController = ScrollController();
  bool codeResended = false;

  @override
  bool allowRTLDirectionality() => true;

  @override
  Widget body(BuildContext context) {
    return AuthScaffold(
      scrollController: _scrollController,
      body: Stack(
        children: [
          SingleChildScrollView(
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
                    margin: Theme.of(context)
                        .appDimensions
                        .topBottonMarginLoginSingUp,
                    child: Column(
                      children: [
                        // Header
                        Container(
                          padding: const EdgeInsets.only(bottom: 32),
                          child: Column(children: [
                            // logo
                            MainLogo(iconName: AppIconName.uec48Mail01),
                            const SizedBox(height: 24),
                            // title
                            Container(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Center(
                                child: Text(
                                  getString("check_your_email"),
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
                                getString("we_sent_a_verification_code_to_[placeholder]").replaceFirst("[placeholder]", "placeholder"), // TODO
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
                              text: getString("open_email_app"),
                              context: context,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              onTap: () {
                                context.goForgotPasswordStep3();
                              },
                            ),
                            const SizedBox(height: 16),

                            codeResended
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          getString("forgot_password_check_email_again_part_1"),
                                          style: Theme.of(context)
                                              .appTexts
                                              .textSmRegular
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .appColors
                                                      .textTeritory600)),
                                      AppButton.buttonTertiary(
                                          text: getString("forgot_password_check_email_again_part_2"),
                                          context: context,
                                          onTap: () {
                                            context.pop();
                                          }),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(getString("did_not_receive_the_email_with_question_mark"),
                                          style: Theme.of(context)
                                              .appTexts
                                              .textSmRegular
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .appColors
                                                      .textTeritory600)),
                                      AppButton.buttonTertiary(
                                          text: getString("click_to_resend"),
                                          context: context,
                                          onTap: () {
                                            setState(() {
                                              codeResended = true;
                                            });
                                          }),
                                    ],
                                  ),
                            const SizedBox(height: 32),
                            // Back to Log in Btn
                            AppButton.buttonTertiary(
                                text: getString("back_to_log_in"),
                                textColor: Theme.of(context)
                                    .appColors
                                    .buttonTeritoryFg,
                                icon: AppIconName.arrowLeft,
                                context: context,
                                onTap: () {
                                  context.goLoginEmail();
                                }),
                          ],
                        )
                        // email validation form
                      ],
                    ),
                  ),
                ),
              )),
          Align(
              alignment: Alignment.bottomCenter,
              child: StepsFooter(items: [
                {
                  'title': getString("provide_your_email_address"),
                  'subTitle': getString("provide_email_to_receive_reset_instructions_with_period"),
                  'enable': true
                },
                {
                  'title': getString("check_your_email"),
                  'subTitle': getString("click_the_link_in_your_email_with_period"),
                  'enable': true
                },
                {
                  'title': getString("choose_a_password"),
                  'subTitle': getString("choose_a_secure_password_with_period"),
                  'enable': false
                },
              ]))
        ],
      ),
    );
  }
}
