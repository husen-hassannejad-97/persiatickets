import 'package:billit_now/apps/helper/router/router_extention/login_router_extention.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_snackbar.dart';
import 'package:billit_now/component/app_text_field.dart';
import 'package:billit_now/features/base/base_bloc.dart';
import 'package:billit_now/features/base/base_bloc_event.dart';
import 'package:billit_now/features/base/base_bloc_state.dart';
import 'package:billit_now/features/base/base_bloc_stateful_widget.dart';
import 'package:billit_now/features/base/base_stateless_page.dart';
import 'package:billit_now/repositories/auth/auth_repository.dart';
import 'package:billit_now/repositories/auth/input_models/login_input_model.dart';
import 'package:billit_now/repositories/auth/models/snackbar_type.dart';
import 'package:billit_now/repositories/shared/errors.dart';
import 'package:billit_now/templates/auth/widgets/auth_scaffold.dart';
import 'package:billit_now/templates/auth/widgets/main_logo.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repositories/shared/models/code_type.dart';
import '../widgets/device_info_provider.dart';

class LoginEmailPasswordEvent extends BaseBlocEvent {}
class LoginPassword extends LoginEmailPasswordEvent {
  final String email;
  final String password;
  LoginPassword({required this.email, required this.password});
}

@injectable
class LoginEmailPasswordBloc extends BaseBloc<LoginEmailPasswordEvent, BaseBlocState> {
  final AuthRepository authRepo;
  LoginEmailPasswordBloc(this.authRepo) {
    on<LoginPassword>((event, emit) async => callRepo(emit: emit, repoFunc: await authRepo.login(
          LoginInputModel(
            codeType: CodeType.email,
            email: event.email,
            password: event.password,
            deviceInfoModel: await getDeviceInfoModel(),
          )
        ))
    );
  }
}

class LoginEmailPasswordPage extends BaseStatelessPage {
  const LoginEmailPasswordPage({super.key});

  @override
  Widget body(BuildContext context) {
    return LoginEmailPassword();
  }

}

class LoginEmailPassword extends BaseBlocStatefulWidget {
  const LoginEmailPassword({super.key});

  @override
  State<StatefulWidget> createState() => _LoginEmailPasswordState();

}

class _LoginEmailPasswordState extends BaseBlocStateWidget<LoginEmailPassword, LoginEmailPasswordBloc> {

  final _passwordController = TextEditingController();
  String? _lastEnteredPassword;

  final ScrollController _scrollController = ScrollController();

  String? _email;

  @override
  bool allowRTLDirectionality() => true;

  @override
  void initState() {
    super.initState();
    _loadEmail();
  }

  Future<void> _loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email') ?? "";
    });
  }

  @override
  Widget body(BuildContext context, BaseBlocState state) {
    if(_email == null) {
      return Container();
    }
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
                        MainLogo(iconName: AppIconName.ue989Passcode),
                        const SizedBox(height: 24),
                        // title
                        Container(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Center(
                            child: Text(
                              getString("log_in_with_password"),
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
                            getString("enter_your_password_with_period"),
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
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              AppTextField.main(
                                  controller: _passwordController,
                                  keyboardType: TextInputType.text,
                                  labelText: getString("password"),
                                  isObscure: true,
                                  placeHolder: '',
                                  helpText: '',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return getString("please_enter_your_password");
                                    }
                                    return null;
                                  }),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(getString("forgot_your_password_with_question_mark"),
                                      style: Theme.of(context)
                                          .appTexts
                                          .textSmRegular
                                          .copyWith(
                                          color: Theme.of(context)
                                              .appColors
                                              .textTeritory600)),
                                  AppButton.buttonTertiary(
                                      text: getString("reset_your_password"),
                                      context: context,
                                      onTap: () {
                                        context.goForgotPasswordStep1();
                                      }),
                                ],
                              ),
                              const SizedBox(height: 12),
                              AppButton.buttonPrimary(
                                text: getString("log_in"),
                                context: context,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                onTap: () {
                                  _lastEnteredPassword = _passwordController.text;
                                  addEvent(context, LoginPassword(email: _email!, password: _lastEnteredPassword!));
                                },
                              ),
                              const SizedBox(height: 16),
                              // Log in with an one-time code Btn
                              AppButton.buttonTertiary(
                                  text: getString("log_in_with_an_one_time_code"),
                                  context: context,
                                  onTap: () {}),
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
                          ),
                        )
                      ],
                    )
                    // email validation form
                  ],
                ),
              ),
            ),
          )),
    );
  }

  @override
  void consumeState(BuildContext context, BaseBlocState state) {
    if(state is StateSuccess) {
      context.goLoginWelcome();
    } else if (state is StateError && state.error is BadRequestError) {
      AppSnackbar().show(
          context: context,
          type: SnackbarType.warning,
          message: (state.error as BadRequestError).detail);
    }
  }

}
