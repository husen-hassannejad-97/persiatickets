import 'package:billit_now/apps/helper/router/router_extention/login_router_extention.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_text_field.dart';
import 'package:billit_now/features/base/base_bloc.dart';
import 'package:billit_now/features/base/base_bloc_event.dart';
import 'package:billit_now/features/base/base_bloc_state.dart';
import 'package:billit_now/features/base/base_bloc_stateful_widget.dart';
import 'package:billit_now/repositories/auth/auth_repository.dart';
import 'package:billit_now/templates/auth/widgets/auth_scaffold.dart';
import 'package:billit_now/templates/auth/widgets/main_logo.dart';
import 'package:billit_now/templates/auth/widgets/password_checker.dart';
import 'package:billit_now/templates/auth/widgets/steps_footer.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../features/base/base_stateless_page.dart';
import '../../../repositories/auth/input_models/password_reset_confirm_input_model.dart';

class PasswordResetDone extends BaseBlocEvent {}

class ForgotPasswordStep3Page extends BaseStatelessPage {
  const ForgotPasswordStep3Page({super.key});

  @override
  bool allowRTLDirectionality() => true;

  @override
  Widget body(BuildContext context) {
    return ForgotPasswordStep3();
  }

  @override
  void consumeEvent(BuildContext context, BaseBlocEvent event) {
    if (event is PasswordResetDone) {
      context.goForgotPasswordStep4();
    }
  }
}

@injectable
class ForgotPasswordStep3Bloc
    extends BaseBloc<ForgotPasswordStep3Event, BaseBlocState> {
  final AuthRepository authRepo;
  ForgotPasswordStep3Bloc({required this.authRepo}) {
    on<PasswordResetConfirm>((event, emit) async => callRepo(emit: emit, repoFunc: await authRepo
            .passwordResetConfirm(PasswordResetConfirmInputModel())));
  }
}

class ForgotPasswordStep3Event extends BaseBlocEvent {}

class PasswordResetConfirm extends ForgotPasswordStep3Event {
  final String newPassword;
  PasswordResetConfirm({required this.newPassword});
}

class ForgotPasswordStep3 extends BaseBlocStatefulWidget {
  const ForgotPasswordStep3({super.key});

  @override
  State<ForgotPasswordStep3> createState() => _ForgotPasswordStep3State();
}

class _ForgotPasswordStep3State
    extends BaseBlocStateWidget<ForgotPasswordStep3, ForgotPasswordStep3Bloc> {
  final _verifyFormKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  String password = '';

  @override
  Widget body(BuildContext context, BaseBlocState state) {
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
                            MainLogo(iconName: AppIconName.ue97fLock01),
                            const SizedBox(height: 24),
                            // title
                            Container(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Center(
                                child: Text(
                                  getString("set_new_password"),
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
                                getString("your_new_password_must_be_different_with_period"),
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
                            Form(
                              key: _verifyFormKey,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    AppTextField.main(
                                        controller: _passwordController,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        labelText: getString("password"),
                                        isObscure: true,
                                        onChanged: (value) {
                                          setState(() {
                                            password = value;
                                          });
                                        },
                                        placeHolder: '',
                                        helpText: '',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return getString("please_enter_verification_code");
                                          }
                                          return null;
                                        }),
                                    AppTextField.main(
                                        controller: _confirmPasswordController,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        labelText: getString("confirm_password"),
                                        isObscure: true,
                                        placeHolder: '',
                                        helpText: '',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return getString("please_enter_verification_code");
                                          }
                                          return null;
                                        }),
                                    PasswordChecker(password: password),
                                    const SizedBox(height: 12),
                                    AppButton.buttonPrimary(
                                      text: getString("continue"),
                                      context: context,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      onTap: () {
                                        if (_passwordController.text.isEmpty ||
                                            _confirmPasswordController
                                                .text.isEmpty) {
                                          return "${getString("please_enter_your_password")}.";
                                        } else if (_passwordController.text ==
                                            _confirmPasswordController.text) {
                                          addEvent(
                                              context,
                                              PasswordResetConfirm(
                                                  newPassword:
                                                      _passwordController
                                                          .text));
                                        } else if (_passwordController.text !=
                                            _confirmPasswordController.text) {
                                          return getString("password_do_not_match_message");
                                        }
                                      },
                                      disable: _passwordController.text !=
                                          _confirmPasswordController.text,
                                    ),
                                    const SizedBox(height: 12),
                                    // Back to Log in Btn
                                    AppButton.buttonTertiary(
                                        text: getString("back_to_log_in"),
                                        icon: AppIconName.arrowLeft,
                                        textColor: Theme.of(context)
                                            .appColors
                                            .buttonTeritoryFg,
                                        context: context,
                                        onTap: () {
                                          context.goLoginEmail();
                                        }),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
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
                  'enable': true
                },
              ]))
        ],
      ),
    );
  }

  @override
  void consumeState(BuildContext context, BaseBlocState state) {
    if (state is StateSuccess) {
      addEvent(context, PasswordResetDone());
    }
  }
}
