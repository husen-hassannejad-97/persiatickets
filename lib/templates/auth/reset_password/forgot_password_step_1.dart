import 'package:billit_now/apps/helper/router/router_extention/login_router_extention.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_snackbar.dart';
import 'package:billit_now/component/app_text_field.dart';
import 'package:billit_now/features/base/base_bloc.dart';
import 'package:billit_now/features/base/base_bloc_event.dart';
import 'package:billit_now/features/base/base_bloc_state.dart';
import 'package:billit_now/features/base/base_bloc_stateless_widget.dart';
import 'package:billit_now/features/base/base_stateless_page.dart';
import 'package:billit_now/repositories/auth/auth_repository.dart';
import 'package:billit_now/repositories/auth/input_models/password_reset_request_input_model.dart';
import 'package:billit_now/repositories/auth/models/snackbar_type.dart';
import 'package:billit_now/repositories/shared/errors.dart';
import 'package:billit_now/templates/auth/widgets/auth_scaffold.dart';
import 'package:billit_now/templates/auth/widgets/main_logo.dart';
import 'package:billit_now/templates/auth/widgets/steps_footer.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

class GoToStep2 extends BaseBlocEvent{}

class ForgotPasswordStep1Page extends BaseStatelessPage {
  const ForgotPasswordStep1Page({super.key});

  @override
  bool allowRTLDirectionality() => true;

  @override
  Widget body(BuildContext context) {
    return ForgotPasswordStep1();
  }

  @override
  void consumeEvent(BuildContext context, BaseBlocEvent event) {
    if(event is GoToStep2) {
      context.goForgotPasswordStep2();
    }
  }
  
}

@injectable
class ForgotPasswordStep1Bloc extends BaseBloc<ForgotPasswordStep1Event, BaseBlocState> {
  final AuthRepository authRepo;
  ForgotPasswordStep1Bloc({required this.authRepo}) {
    on<RequestPasswordReset>((event, emit) async => callRepo(emit: emit, repoFunc: await authRepo.passwordResetRequest(
            PasswordResetRequestInputModel(
              email: event.email,
            )
        ))
    );
  }
}

class ForgotPasswordStep1Event extends BaseBlocEvent {}
class RequestPasswordReset extends ForgotPasswordStep1Event{
  final String email;
  RequestPasswordReset({required this.email});
}


class ForgotPasswordStep1 extends BaseBlocStatelessWidget<ForgotPasswordStep1Bloc> {
  ForgotPasswordStep1({super.key});

  final _verifyFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  late String _lastEnteredEmail;

  final ScrollController _scrollController = ScrollController();

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
                            MainLogo(iconName: AppIconName.ue97dKey01),
                            const SizedBox(height: 24),
                            // title
                            Container(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Center(
                                child: Text(
                                  getString("forgot_password_with_question_mark"),
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
                                getString("we_will_send_you_instructions_to_reset_your_password_with_period"),
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
                                        controller: _emailController,
                                        keyboardType: TextInputType.number,
                                        labelText: getString("email_address"),
                                        placeHolder: getString("email_address_sample"),
                                        helpText: '',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return getString("please_enter_verification_code");
                                          }
                                          return null;
                                        }),
                                    AppButton.buttonPrimary(
                                      text: getString("reset_password"),
                                      context: context,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      onTap: () {
                                        _lastEnteredEmail = _emailController.text;
                                        addEvent(context, RequestPasswordReset(email: _lastEnteredEmail));
                                        // if (_verifyFormKey.currentState!
                                        //     .validate()) {
                                        //   // Process the email, e.g., send it to a server
                                        //   print(
                                        //       'Email: ${_codeVerifyController.text}');
                                        // }
                                      },
                                    ),
                                    const SizedBox(height: 16),
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
                  'enable': false
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

  @override
  void consumeState(BuildContext context, BaseBlocState state) {
    if(state is StateSuccess) {
      addEvent(context, GoToStep2());
    } else if (state is StateError && state.error is BadRequestError) {
      AppSnackbar().show(
          context: context,
          type: SnackbarType.warning,
          message: (state.error as BadRequestError).detail);
    }
  }

}
