import 'package:billit_now/apps/helper/router/router_extention/login_router_extention.dart';
import 'package:billit_now/apps/helper/router/router_extention/signup_router_extention.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/apps/helper/utils/country_model.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_snackbar.dart';
import 'package:billit_now/features/base/base_bloc.dart';
import 'package:billit_now/features/base/base_bloc_state.dart';
import 'package:billit_now/features/base/base_bloc_stateless_widget.dart';
import 'package:billit_now/features/base/base_stateless_page.dart';
import 'package:billit_now/repositories/auth/models/snackbar_type.dart';
import 'package:billit_now/repositories/shared/errors.dart';
import 'package:billit_now/templates/auth/auth_data.dart';
import 'package:billit_now/templates/auth/login/login_data.dart';
import 'package:billit_now/templates/auth/login/login_phone_otp.dart';
import 'package:billit_now/templates/auth/signup/signup_data.dart';
import 'package:billit_now/templates/auth/signup/signup_phone_number_otp.dart';
import 'package:billit_now/templates/auth/widgets/auth_scaffold.dart';
import 'package:billit_now/templates/auth/widgets/country_code.dart';
import 'package:billit_now/templates/auth/widgets/device_info_provider.dart';
import 'package:billit_now/templates/auth/widgets/login_sign_options.dart';
import 'package:billit_now/templates/auth/widgets/or_seprator.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../features/base/base_bloc_event.dart';
import '../../../repositories/auth/auth_repository.dart';
import '../../../repositories/auth/input_models/send_code_input_model.dart';
import '../../../repositories/auth/models/auth_type_enum_model.dart';
import '../../../repositories/shared/models/code_type.dart';
import '../widgets/login_apple.dart';
import '../widgets/login_facebook.dart';
import '../widgets/login_google.dart';

sealed class LoginPhoneEvent extends BaseBlocEvent {}

class CodeEvent extends LoginPhoneEvent {
  String phone;
  CodeEvent({required this.phone});
}

class GoToLoginPhoneOtp extends BaseBlocEvent {
  final String phone;
  final CountryModel country;
  GoToLoginPhoneOtp({required this.phone, required this.country});
}

class GoToSignupPhoneOtp extends BaseBlocEvent {
  final String phone;
  final CountryModel country;
  GoToSignupPhoneOtp({required this.phone, required this.country});
}

class GoToLoginEmail extends BaseBlocEvent {}

@injectable
class LoginPhoneBloc extends BaseBloc<LoginPhoneEvent, BaseBlocState> {
  AuthRepository authRepo;
  LoginPhoneBloc(this.authRepo) {
    on<CodeEvent>((event, emit) async => callRepoWithResult(emit: emit, repoFunc: await authRepo.sendCode(SendCodeInputModel(
            codeType: CodeType.phone,
            input: event.phone,
            deviceInfoModel: await getDeviceInfoModel())))
    );
  }
}

class LoginPhonePage extends BaseStatelessPage {
  const LoginPhonePage({super.key});

  @override
  bool allowRTLDirectionality() => true;

  @override
  Widget body(BuildContext context) {
    return LoginPhone();
  }

  @override
  void consumeEvent(BuildContext context, BaseBlocEvent event) {
    if (event is GoToLoginPhoneOtp) {
      savePhoneOnStorage(event.phone, () {
        saveCountryOnStorage(event.country, () {
          context.goLoginPhoneNumberOtp(
              LoginPhoneOtpPageExtra(from: 'login_phone'));
        });
      });
    } else if (event is GoToSignupPhoneOtp) {
      savePhoneOnStorage(event.phone, () {
        saveCountryOnStorage(event.country, () {
          saveOnStorage(
              SignupData(
                  head: SignupHead.phone,
                  email: null,
                  phone: event.phone,
                  firstName: null,
                  lastName: null,
                  password: null,
                  termsAgreed: null), () {
            context.goSignupPhoneNumberOtp(
                SignupPhoneNumberOtpPageExtra(from: 'login_phone'));
          });
        });
      });
    } else if (event is GoToLoginEmail) {
      context.goLoginEmail();
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

class LoginPhone extends BaseBlocStatelessWidget<LoginPhoneBloc> {
  LoginPhone({super.key});

  final _phoneFormKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  late CountryModel _selectedCountry;
  late String _lastEnteredPhone;

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
                        Container(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: AppIcon.logo(
                              appIconName: AppIconName.logo,
                              context: context,
                              size: 48),
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
                          key: _phoneFormKey,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                CountryCode(
                                  labelText: getString("phone_number"),
                                  dropdownPlaceHolder: getString("select_country_code"),
                                  dropdownSearchPlaceHolder:
                                      getString("search_country_name"),
                                  textFieldController: _phoneController,
                                  selectedCountry: (CountryModel country) {
                                    _selectedCountry = country;
                                  },
                                  enabled: true,
                                ),

                                AppButton.buttonPrimary(
                                  text: getString("continue"),
                                  context: context,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  onTap: () {
                                    // if (_phoneFormKey.currentState!
                                    //     .validate()) {
                                    //
                                    // }
                                    _lastEnteredPhone = _phoneController.text;
                                    addEvent(
                                        context,
                                        CodeEvent(
                                            phone:
                                                '+${_selectedCountry.dialCode}$_lastEnteredPhone'));
                                  },
                                ),
                                const SizedBox(height: 16),
                                // Continue with email address Btn
                                AppButton.buttonTertiary(
                                    text: getString("continue_with_email_address"),
                                    context: context,
                                    onTap: () {
                                      addEvent(context, GoToLoginEmail());
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
          )),
    );
  }

  @override
  void consumeState(BuildContext context, BaseBlocState state) {
    if (state is StateSuccessWithResult<AuthTypeEnumModel>) {
      if (state.result == AuthTypeEnumModel.signup) {
        addEvent(
            context,
            GoToSignupPhoneOtp(
              phone: '+${_selectedCountry.dialCode}$_lastEnteredPhone',
              country: _selectedCountry,
            ));
      } else if (state.result == AuthTypeEnumModel.login) {
        addEvent(
            context,
            GoToLoginPhoneOtp(
              phone: '+${_selectedCountry.dialCode}$_lastEnteredPhone',
              country: _selectedCountry,
            ));
      }
    }  else if (state is StateError && state.error is BadRequestError) {
      AppSnackbar().show(
          context: context,
          type: SnackbarType.warning,
          message: (state.error as BadRequestError).detail);
    }
  }
}
