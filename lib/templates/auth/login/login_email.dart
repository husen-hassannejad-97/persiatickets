import 'package:billit_now/apps/helper/router/router_extention/login_router_extention.dart';
import 'package:billit_now/apps/helper/router/router_extention/signup_router_extention.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_snackbar.dart';
import 'package:billit_now/component/app_text_field.dart';
import 'package:billit_now/features/base/base_bloc_state.dart';
import 'package:billit_now/features/base/base_bloc_stateless_widget.dart';
import 'package:billit_now/repositories/auth/models/auth_type_enum_model.dart';
import 'package:billit_now/repositories/auth/models/snackbar_type.dart';
import 'package:billit_now/repositories/shared/errors.dart';
import 'package:billit_now/templates/auth/signup/signup_data.dart';
import 'package:billit_now/templates/auth/widgets/auth_scaffold.dart';
import 'package:billit_now/templates/auth/widgets/device_info_provider.dart';
import 'package:billit_now/templates/auth/widgets/login_apple.dart';
import 'package:billit_now/templates/auth/widgets/login_facebook.dart';
import 'package:billit_now/templates/auth/widgets/login_google.dart';
import 'package:billit_now/templates/auth/widgets/login_sign_options.dart';
import 'package:billit_now/templates/auth/widgets/or_seprator.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repositories/auth/auth_repository.dart';
import '../../../features/base/base_bloc.dart';
import '../../../features/base/base_bloc_event.dart';
import '../../../features/base/base_stateless_page.dart';
import '../../../repositories/auth/input_models/send_code_input_model.dart';
import '../../../repositories/shared/models/code_type.dart';
import '../signup/signup_email_otp.dart';
import 'login_email_otp.dart';

sealed class LoginEmailEvent extends BaseBlocEvent {}

class CodeEvent extends LoginEmailEvent {
  String email;
  CodeEvent({required this.email});
}

class GoToLoginEmailOtp extends BaseBlocEvent {
  final String email;
  GoToLoginEmailOtp({required this.email});
}

class GoToSignupEmailOtp extends BaseBlocEvent {
  final String email;
  GoToSignupEmailOtp({required this.email});
}

class GoToLoginPhone extends BaseBlocEvent {}

@injectable
class LoginEmailBloc extends BaseBloc<LoginEmailEvent, BaseBlocState> {
  AuthRepository authRepo;
  LoginEmailBloc(this.authRepo) {
    on<CodeEvent>((event, emit) async => callRepoWithResult(emit: emit, repoFunc: await authRepo.sendCode(SendCodeInputModel(
            codeType: CodeType.email,
            input: event.email,
            deviceInfoModel: await getDeviceInfoModel())))
   );
  }
}

class LoginEmailPage extends BaseStatelessPage {
  const LoginEmailPage({super.key});

  @override
  bool allowRTLDirectionality() => true;

  @override
  Widget body(BuildContext context) {
    return LoginEmail();
  }

  Future<void> saveEmail(String email, Function() done) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    done();
  }

  @override
  void consumeEvent(BuildContext context, BaseBlocEvent event) {
    if (event is GoToLoginEmailOtp) {
      saveEmail(event.email, () {
        context.goLoginEmailOtp(
          LoginEmailOtpPageExtra(from: 'login_email')
        );
      });
    } else if (event is GoToSignupEmailOtp) {
      saveOnStorage(
          SignupData(
              head: SignupHead.email,
              email: event.email,
              phone: null,
              firstName: null,
              lastName: null,
              password: null,
              termsAgreed: false
          ), () {
        context.goSignupEmailOtp(SignupEmailOtpPageExtra(
          from: 'login_email',));
      });
    } else if (event is GoToLoginPhone) {
      context.goLoginPhoneNumber();
    } else if (event is GoogleSignInDone) {
      // TODO Navigate to Home page
    } else if (event is GoogleSignInDone) {
      // TODO Navigate to Error
    } else if (event is FacebookSignInDone) {
      // TODO Navigate to Home page
    } else if (event is FacebookSignInError) {
      // TODO Navigate to Error
    } else if (event is AppleSignInDone) {
      // TODO Navigate to Home page
    } else if (event is AppleSignInError) {
      // TODO Navigate to Error
    }
  }
}

class LoginEmail extends BaseBlocStatelessWidget<LoginEmailBloc> {
  LoginEmail({super.key});

  final _mailFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  late String _lastEnteredEmail;

  final ScrollController _scrollController = ScrollController();

  @override
  Widget body(BuildContext context, BaseBlocState state) {
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
            constraints: Theme.of(context).appDimensions.minMaxWidthLoginSingUp,
            child: Container(
              // width: 400,
              margin:
                  Theme.of(context).appDimensions.topBottonMarginLoginSingUp,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Column(children: [
                      // Logo
                      Container(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: AppIcon.logo(
                          appIconName: AppIconName.logo,
                          context: context,
                          size: 48,
                        ),
                      ),
                      // title
                      Container(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Center(
                          child: Text(
                            getString("login_or_signup"),
                            style: Theme.of(context)
                                .appTexts
                                .displaySmSemiBold
                                .copyWith(
                                    color: Theme.of(context)
                                        .appColors
                                        .textPrimary900),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      // subtitle
                      Center(
                        child: Text(
                          getString("welcome_and_enter_number"),
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
                        key: _mailFormKey,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              AppTextField.main(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                labelText: getString("email_address"),
                                placeHolder: getString("email_address_sample"),
                                helpText: '',
                                validator: (value) {
                                  // TODO Doesn't allow us to type into the box
                                  if (value!.isEmpty) {
                                    return getString("please_enter_email");
                                  }
                                  if (!RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(value)) {
                                    return getString("please_enter_valid_email_msg");
                                  }
                                  return null;
                                },
                              ),
                              AppButton.buttonPrimary(
                                text: getString("continue"),
                                context: context,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                onTap: () {
                                  if (_mailFormKey.currentState!.validate()) {
                                    _lastEnteredEmail = _emailController.text;
                                    addEvent(context,
                                        CodeEvent(email: _lastEnteredEmail));
                                  }
                                },
                                disable: state is StateLoading,
                              ),
                              const SizedBox(height: 16),
                              // Continue with phone number Btn
                              AppButton.buttonTertiary(
                                  text: getString("continue_with_phone_number"),
                                  context: context,
                                  onTap: () {
                                    addEvent(context, GoToLoginPhone());
                                  }),
                            ],
                          ),
                        ),
                      ),

                      // ---OR---
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: OrSepreatpr(),
                      ),
                      // thirdparty options to login/sign up
                      LoginSignOptions(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void consumeState(BuildContext context, BaseBlocState state) {
    if (state is StateSuccessWithResult<AuthTypeEnumModel>) {
      if (state.result == AuthTypeEnumModel.signup) {
        addEvent(context, GoToSignupEmailOtp(email: _lastEnteredEmail));
      } else if (state.result == AuthTypeEnumModel.login) {
        addEvent(context, GoToLoginEmailOtp(email: _lastEnteredEmail));
      }
    }  else if (state is StateError && state.error is BadRequestError) {
      AppSnackbar().show(
          context: context,
          type: SnackbarType.warning,
          message: (state.error as BadRequestError).detail);
    }
  }
}
