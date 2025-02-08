import 'dart:async';

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
import 'package:billit_now/features/base/base_stateful_page.dart';
import 'package:billit_now/repositories/auth/auth_repository.dart';
import 'package:billit_now/repositories/auth/models/snackbar_type.dart';
import 'package:billit_now/repositories/shared/errors.dart';
import 'package:billit_now/templates/auth/widgets/auth_scaffold.dart';
import 'package:billit_now/templates/auth/widgets/main_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/di/di_setup.dart';
import '../../../features/base/base_extra.dart';
import '../../../repositories/auth/input_models/verify_input_model.dart';
import '../../../repositories/shared/models/code_type.dart';
import '../widgets/resend_code.dart';
import 'login_email.dart';

class LoginEmailOtpEvent extends BaseBlocEvent {}

class VerifyEmailEvent extends LoginEmailOtpEvent {
  String email;
  String code;
  VerifyEmailEvent({
    required this.email,
    required this.code,
  });
}

@injectable
class LoginEmailOtpBloc extends BaseBloc<LoginEmailOtpEvent, BaseBlocState> {
  final AuthRepository authRepo;
  LoginEmailOtpBloc({required this.authRepo}) {
    on<VerifyEmailEvent>((event, emit) async => callRepo(
        emit: emit,
        repoFunc: await authRepo.verify(VerifyInputModel(
          id: event.email,
          type: CodeType.email,
          code: event.code,
        ))));
  }
}

class LoginEmailOtpPageExtra implements BaseExtra {
  @override
  final String from;
  LoginEmailOtpPageExtra({
    required this.from,
  });
}

class LoginEmailOtpPage extends BaseStatefulPage {
  // final LoginEmailOtpPageExtra? argument;

  const LoginEmailOtpPage({
    // required this.argument,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _LoginEmailOtpPageState();
}

class _LoginEmailOtpPageState extends BasePageState<LoginEmailOtpPage> {
  String _email = '';

  @override
  List setProviders(BuildContext context) {
    return [
      BlocProvider(create: (context) {
        return getIt<LoginEmailBloc>();
      })
    ];
  }

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
  Widget body(BuildContext context) {
    if (_email.isEmpty) {
      return Container();
    } else {
      return LoginEmailOtp(email: _email);
    }
  }

  @override
  void consumeEvent(BuildContext context, BaseBlocEvent event) {
    if (event is CodeEvent) {
      context.read<LoginEmailBloc>().add(event);
    }
  }
}

class LoginEmailOtp extends BaseBlocStatelessWidget<LoginEmailOtpBloc> {
  LoginEmailOtp({required this.email, super.key});

  final String email;
  final _otpFormKey = GlobalKey<FormState>();
  final _codeOtpController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  @override
  bool allowRTLDirectionality() => true;

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
                            getString(
                                    "we_sent_a_verification_code_to_[placeholder]")
                                .replaceFirst("[placeholder]", email),
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
                          key: _otpFormKey,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                AppTextField.main(
                                    controller: _codeOtpController,
                                    keyboardType: TextInputType.number,
                                    labelText: getString("verification_code"),
                                    placeHolder: '--- ---',
                                    helpText: '',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return getString(
                                            "please_enter_verification_code");
                                      }
                                      return null;
                                    }),
                                Row(
                                  children: [
                                    ResendCode(click: () {
                                      addEvent(
                                          context, CodeEvent(email: email));
                                    }),
                                    Expanded(
                                      child: AppButton.buttonPrimary(
                                        text: getString("verify_email"),
                                        context: context,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 10),
                                        onTap: () {
                                          // if (_otpFormKey.currentState!
                                          //     .validate()) {
                                          //   // Process the email, e.g., send it to a server
                                          //   print(
                                          //       'Email: ${_codeOtpController.text}');
                                          // }
                                          addEvent(
                                              context,
                                              VerifyEmailEvent(
                                                  email: email,
                                                  code:
                                                      _codeOtpController.text));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                // Log in with password Btn
                                AppButton.buttonTertiary(
                                    text: getString("log_in_with_password"),
                                    context: context,
                                    onTap: () {
                                      context.goLoginEmailPassword();
                                    }),
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
                          ),
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

  @override
  void consumeState(BuildContext context, BaseBlocState state) {
    if (state is StateSuccess) {
      context.goLoginWelcome();
    } else if (state is StateError && state.error is BadRequestError) {
      AppSnackbar().show(
          context: context,
          type: SnackbarType.warning,
          message: (state.error as BadRequestError).detail);
    }
  }
}
