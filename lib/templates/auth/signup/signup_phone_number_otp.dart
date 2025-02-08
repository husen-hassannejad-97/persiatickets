import 'package:billit_now/apps/helper/router/router_extention/signup_router_extention.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/apps/helper/utils/country_model.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_snackbar.dart';
import 'package:billit_now/component/app_text_field.dart';
import 'package:billit_now/features/base/base_bloc.dart';
import 'package:billit_now/features/base/base_bloc_event.dart';
import 'package:billit_now/features/base/base_bloc_state.dart';
import 'package:billit_now/features/base/base_bloc_stateless_widget.dart';
import 'package:billit_now/features/base/base_stateful_page.dart';
import 'package:billit_now/repositories/auth/auth_repository.dart';
import 'package:billit_now/repositories/auth/input_models/verify_signup_input_model.dart';
import 'package:billit_now/repositories/auth/models/snackbar_type.dart';
import 'package:billit_now/repositories/shared/errors.dart';
import 'package:billit_now/templates/auth/auth_data.dart';
import 'package:billit_now/templates/auth/signup/signup_data.dart';
import 'package:billit_now/templates/auth/signup/signup_details.dart';
import 'package:billit_now/templates/auth/signup/signup_email.dart';
import 'package:billit_now/templates/auth/signup/signup_phone_number.dart';
import 'package:billit_now/templates/auth/widgets/auth_scaffold.dart';
import 'package:billit_now/templates/auth/widgets/country_code.dart';
import 'package:billit_now/templates/auth/widgets/main_logo.dart';
import 'package:billit_now/templates/auth/widgets/resend_code.dart';
import 'package:billit_now/templates/auth/widgets/steps_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:billit_now/templates/shared/Utils.dart';

import '../../../core/di/di_setup.dart';
import '../../../features/base/base_extra.dart';
import '../../../repositories/shared/models/code_type.dart';

class SignupPhoneNumberOtpEvent extends BaseBlocEvent {}

class VerifyPhoneEvent extends SignupPhoneNumberOtpEvent {
  String phone;
  String code;
  VerifyPhoneEvent({
    required this.phone,
    required this.code,
  });
}

@injectable
class SignupPhoneNumberOtpBloc
    extends BaseBloc<SignupPhoneNumberOtpEvent, BaseBlocState> {
  AuthRepository authRepo;
  SignupPhoneNumberOtpBloc(this.authRepo) {
    on<VerifyPhoneEvent>((event, emit) async => callRepo(
        emit: emit,
        repoFunc: await authRepo.verifySignup(VerifySignupInputModel(
          id: event.phone,
          type: CodeType.phone,
          code: event.code,
        ))));
  }
}

class PhoneVerifiedEvent extends BaseBlocEvent {}

class SignupPhoneNumberOtpPageExtra implements BaseExtra {
  @override
  final String from;

  SignupPhoneNumberOtpPageExtra({
    required this.from,
  });
}

class SignupPhoneNumberOtpPage extends BaseStatefulPage {
  // final SignupPhoneNumberOtpPageExtra? argument;

  const SignupPhoneNumberOtpPage({
    // required this.argument,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SignupPhoneNumberOtpPageState();
}

class _SignupPhoneNumberOtpPageState
    extends BasePageState<SignupPhoneNumberOtpPage> {
  SignupData? _data;
  CountryModel? _country;

  @override
  bool allowRTLDirectionality() => true;

  @override
  List setProviders(BuildContext context) {
    return [
      BlocProvider(create: (context) {
        return getIt<SignupPhoneNumberBloc>();
      })
    ];
  }

  @override
  void initState() {
    super.initState();
    _loadSignupData();
    _loadCountry();
  }

  void _loadCountry() async {
    CountryModel country = await getCountryFromStorage();
    setState(() {
      _country = country;
    });
  }

  Future<void> _loadSignupData() async {
    SignupData data = await retrieveFromStorage();
    setState(() {
      _data = data;
    });
  }

  @override
  Widget body(BuildContext context) {
    if (_data == null ||
        _country == null ||
        _country!.name.isEmpty ||
        _country!.dialCode.isEmpty ||
        _country!.code.isEmpty ||
        _country!.mobileNumberLength == 0 ||
        _country!.format.isEmpty) {
      return Container();
    } else {
      return SignupPhoneNumberOtp(
        data: _data!,
        country: _country!,
      );
    }
  }

  @override
  void consumeEvent(BuildContext context, BaseBlocEvent event) {
    if (event is PhoneVerifiedEvent) {
      if (_data != null) {
        if (_data!.email == null || _data!.email!.isEmpty) {
          context.goSignupEmail(SignupEmailPageExtra(
            from: 'signup_phone_number_otp',
          ));
        } else {
          context.goSignupDetails(
              SignupDetailsPageExtra(from: 'signup_phone_number_otp'));
        }
      }
    } else if (event is CodePhoneEvent) {
      context.read<SignupPhoneNumberBloc>().add(event);
    }
  }
}

class SignupPhoneNumberOtp
    extends BaseBlocStatelessWidget<SignupPhoneNumberOtpBloc> {
  SignupPhoneNumberOtp({required this.country, required this.data, super.key});

  final SignupData data;
  final CountryModel country;
  final _otpFormKey = GlobalKey<FormState>();
  final _codeOtpController = TextEditingController();
  final _countryCodeController = TextEditingController();

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
                                    .replaceFirst(
                                        "[placeholder]",
                                        data.phone?.toNumberString(
                                                getLanguage()) ??
                                            ""),
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
                                      textFieldController:
                                          _countryCodeController,
                                      selectedCountry: (_) {},
                                      defaultSelected: country,
                                      enabled: false,
                                      defaultTextFieldValue: data.phone ?? "",
                                    ),
                                    AppTextField.main(
                                        controller: _codeOtpController,
                                        keyboardType: TextInputType.number,
                                        labelText:
                                            getString("verification_code"),
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
                                              context,
                                              CodePhoneEvent(
                                                data.phone ?? "",
                                              ));
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
                                                      phone: data.phone ?? "",
                                                      code: _codeOtpController
                                                          .text));
                                              // if (_otpFormKey.currentState!
                                              //     .validate()) {
                                              // Process the email, e.g., send it to a server
                                              //   print(
                                              //       'Email: ${_codeOtpController.text}');
                                              // }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
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
          Align(
              alignment: Alignment.bottomCenter,
              child: StepsFooter.create(data, (String key) {
                getString(key);
              }))
        ],
      ),
    );
  }

  @override
  void consumeState(BuildContext context, BaseBlocState state) {
    if (state is StateSuccess) {
      addEvent(context, PhoneVerifiedEvent());
    } else if (state is StateError && state.error is BadRequestError) {
      AppSnackbar().show(
          context: context,
          type: SnackbarType.warning,
          message: (state.error as BadRequestError).detail);
    }
  }
}
