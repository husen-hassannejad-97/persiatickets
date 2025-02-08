import 'package:billit_now/apps/helper/router/router_extention/login_router_extention.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/apps/helper/utils/country_model.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_snackbar.dart';
import 'package:billit_now/component/app_text_field.dart';
import 'package:billit_now/core/di/di_setup.dart';
import 'package:billit_now/features/base/base_bloc.dart';
import 'package:billit_now/features/base/base_bloc_event.dart';
import 'package:billit_now/features/base/base_bloc_state.dart';
import 'package:billit_now/features/base/base_bloc_stateless_widget.dart';
import 'package:billit_now/features/base/base_stateful_page.dart';
import 'package:billit_now/repositories/auth/auth_repository.dart';
import 'package:billit_now/repositories/auth/models/snackbar_type.dart';
import 'package:billit_now/repositories/shared/errors.dart';
import 'package:billit_now/templates/auth/auth_data.dart';
import 'package:billit_now/templates/auth/login/login_data.dart';
import 'package:billit_now/templates/auth/widgets/auth_scaffold.dart';
import 'package:billit_now/templates/auth/widgets/country_code.dart';
import 'package:billit_now/templates/auth/widgets/main_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:billit_now/templates/shared/Utils.dart';

import '../../../features/base/base_extra.dart';
import '../../../repositories/auth/input_models/verify_input_model.dart';
import '../../../repositories/shared/models/code_type.dart';
import '../widgets/resend_code.dart';
import 'login_phone.dart';

class LoginPhoneOtpEvent extends BaseBlocEvent {}

class VerifyPhoneEvent extends LoginPhoneOtpEvent {
  String phone;
  String code;
  VerifyPhoneEvent({
    required this.phone,
    required this.code,
  });
}

@injectable
class LoginPhoneOtpBloc extends BaseBloc<LoginPhoneOtpEvent, BaseBlocState> {
  final AuthRepository authRepo;
  LoginPhoneOtpBloc({required this.authRepo}) {
    on<VerifyPhoneEvent>((event, emit) async => callRepo(
        emit: emit,
        repoFunc: await authRepo.verify(VerifyInputModel(
          id: event.phone,
          type: CodeType.phone,
          code: event.code,
        ))));
  }
}

class LoginPhoneOtpPageExtra implements BaseExtra {
  @override
  final String from;
  LoginPhoneOtpPageExtra({
    required this.from,
  });
}

class LoginPhoneOtpPage extends BaseStatefulPage {
  const LoginPhoneOtpPage({
    super.key,
    // required this.argument,
  });

  // final LoginPhoneOtpPageExtra? argument;

  @override
  State<StatefulWidget> createState() => _LoginPhoneOtpPageState();
}

class _LoginPhoneOtpPageState extends BasePageState<LoginPhoneOtpPage> {
  String _phone = '';
  CountryModel? _country;

  @override
  bool allowRTLDirectionality() => true;

  @override
  List setProviders(BuildContext context) {
    return [
      BlocProvider(create: (context) {
        return getIt<LoginPhoneBloc>();
      })
    ];
  }

  @override
  void initState() {
    super.initState();
    _loadPhone();
    _loadCountry();
  }

  void _loadPhone() async {
    String phone = await getPhoneFromStorage();
    setState(() {
      _phone = phone;
    });
  }

  void _loadCountry() async {
    CountryModel country = await getCountryFromStorage();
    setState(() {
      _country = country;
    });
  }

  @override
  Widget body(BuildContext context) {
    if (_phone.isEmpty ||
        _country == null ||
        _country!.name.isEmpty ||
        _country!.dialCode.isEmpty ||
        _country!.code.isEmpty ||
        _country!.mobileNumberLength == 0 ||
        _country!.format.isEmpty) {
      return Container();
    } else {
      return LoginPhoneOtp(phone: _phone, country: _country!);
    }
  }

  @override
  void consumeEvent(BuildContext context, BaseBlocEvent event) {
    if (event is CodeEvent) {
      context.read<LoginPhoneBloc>().add(event);
    }
  }
}

class LoginPhoneOtp extends BaseBlocStatelessWidget<LoginPhoneOtpBloc> {
  LoginPhoneOtp({super.key, required this.phone, required this.country});

  final String phone;
  final CountryModel country;
  final _otpFormKey = GlobalKey<FormState>();
  final _codeOtpController = TextEditingController();
  final _phoneNumberController = TextEditingController();

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
                        MainLogo(iconName: AppIconName.uec69Phone),
                        const SizedBox(height: 24),
                        // title
                        Container(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Center(
                            child: Text(
                              getString("check_your_phone"),
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
                                .replaceFirst("[placeholder]",
                                    phone.toNumberString(getLanguage())),
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
                                CountryCode(
                                  labelText: getString("phone_number"),
                                  dropdownPlaceHolder:
                                      getString("select_country_code"),
                                  dropdownSearchPlaceHolder:
                                      getString("search_country_name"),
                                  textFieldController: _phoneNumberController,
                                  selectedCountry: (_) {},
                                  defaultSelected: country,
                                  enabled: false,
                                  defaultTextFieldValue: phone,
                                ),
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
                                          context, CodeEvent(phone: phone));
                                    }),
                                    Expanded(
                                      child: AppButton.buttonPrimary(
                                        text: getString("verify_number"),
                                        context: context,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 10),
                                        onTap: () {
                                          addEvent(
                                              context,
                                              VerifyPhoneEvent(
                                                  phone: phone,
                                                  code:
                                                      _codeOtpController.text));
                                          // if (_otpFormKey.currentState!
                                          //     .validate()) {
                                          //   // Process the email, e.g., send it to a server
                                          //   print(
                                          //       'Email: ${_codeOtpController.text}');
                                          // }
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
