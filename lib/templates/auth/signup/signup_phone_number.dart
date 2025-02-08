import 'package:billit_now/apps/helper/router/router_extention/signup_router_extention.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/apps/helper/utils/country_model.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_snackbar.dart';
import 'package:billit_now/features/base/base_bloc.dart';
import 'package:billit_now/features/base/base_bloc_state.dart';
import 'package:billit_now/features/base/base_bloc_stateful_widget.dart';
import 'package:billit_now/features/base/base_stateful_page.dart';
import 'package:billit_now/repositories/auth/models/snackbar_type.dart';
import 'package:billit_now/repositories/shared/errors.dart';
import 'package:billit_now/templates/auth/auth_data.dart';
import 'package:billit_now/templates/auth/signup/signup_data.dart';
import 'package:billit_now/templates/auth/signup/signup_phone_number_otp.dart';
import 'package:billit_now/templates/auth/widgets/auth_scaffold.dart';
import 'package:billit_now/templates/auth/widgets/country_code.dart';
import 'package:billit_now/templates/auth/widgets/device_info_provider.dart';
import 'package:billit_now/templates/auth/widgets/main_logo.dart';
import 'package:billit_now/templates/auth/widgets/steps_footer.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../features/base/base_bloc_event.dart';
import '../../../features/base/base_extra.dart';
import '../../../repositories/auth/auth_repository.dart';
import '../../../repositories/auth/input_models/send_code_input_model.dart';
import '../../../repositories/shared/models/code_type.dart';

class SignupPhoneNumberEvent extends BaseBlocEvent {}

class CodePhoneEvent extends SignupPhoneNumberEvent {
  String phone;
  CodePhoneEvent(this.phone);
}

@injectable
class SignupPhoneNumberBloc
    extends BaseBloc<SignupPhoneNumberEvent, BaseBlocState> {
  AuthRepository authRepo;
  SignupPhoneNumberBloc(this.authRepo) {
    on<CodePhoneEvent>((event, emit) async => callRepoWithResult(emit: emit, repoFunc: await authRepo.sendCode(SendCodeInputModel(
            codeType: CodeType.phone,
            input: event.phone,
            deviceInfoModel: await getDeviceInfoModel()))));
  }
}

class GoToSignupPhoneNumberOtp extends BaseBlocEvent {
  String phone;
  final CountryModel country;
  GoToSignupPhoneNumberOtp({
    required this.phone,
    required this.country
  });
}

class SignupPhoneNumberPageExtra implements BaseExtra {
  @override
  final String from;

  SignupPhoneNumberPageExtra({
    required this.from,
  });
}

class SignupPhoneNumberPage extends BaseStatefulPage {
  // final SignupPhoneNumberPageExtra? argument;

  const SignupPhoneNumberPage({
    // required this.argument,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SignupPhoneNumberPageState();
}

class _SignupPhoneNumberPageState extends BasePageState<SignupPhoneNumberPage> {
  SignupData? _data;

  @override
  bool allowRTLDirectionality() => true;

  @override
  void initState() {
    super.initState();
    _loadSignupData();
  }

  Future<void> _loadSignupData() async {
    SignupData data = await retrieveFromStorage();
    setState(() {
      _data = data;
    });
  }

  @override
  Widget body(BuildContext context) {
    if (_data == null) {
      return Container();
    } else {
      return SignupPhoneNumber(data: _data!);
    }
  }

  @override
  void consumeEvent(BuildContext context, BaseBlocEvent event) {
    if (event is GoToSignupPhoneNumberOtp) {
      if (_data != null) {
        saveCountryOnStorage(event.country,  () {
          saveOnStorage(_data!.copy(phone: event.phone), () {
            context.goSignupPhoneNumberOtp(SignupPhoneNumberOtpPageExtra(
              from: 'signup_phone_number',
            ));
          });
        });
      }
    }
  }
}

class SignupPhoneNumber extends BaseBlocStatefulWidget {
  final SignupData data;

  SignupPhoneNumber({required this.data});

  @override
  State<StatefulWidget> createState() => _SignupPhoneNumberState();
}

class _SignupPhoneNumberState
    extends BaseBlocStateWidget<SignupPhoneNumber, SignupPhoneNumberBloc> {
  final _phoneFormKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  late CountryModel _selectedCountry;
  late String _lastEnteredPhone;

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
                                  getString("verify_your_phone_number"),
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
                                getString("please_enter_your_phone_number"),
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
                                      dropdownPlaceHolder:
                                          getString("select_country_code"),
                                      dropdownSearchPlaceHolder:
                                          getString("search_country_name"),
                                      textFieldController: _phoneController,
                                      selectedCountry: (CountryModel country) {
                                        _selectedCountry = country;
                                      },
                                      enabled: true,
                                    ),
                                    // AppTextField.main(
                                    //     controller: _phoneController,
                                    //     keyboardType: TextInputType.phone,
                                    //     labelText: 'Phone number',
                                    //     placeHolder: '',
                                    //     helpText: '',
                                    //     validator: (value) {
                                    //       if (value!.isEmpty) {
                                    //         return 'Please enter your phone number';
                                    //       }
                                    //       if (!RegExp(
                                    //               r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    //           .hasMatch(value)) {
                                    //         return 'Please enter a valid phone number';
                                    //       }
                                    //       return null;
                                    //     }),
                                    AppButton.buttonPrimary(
                                      text: getString("confirm_and_continue"),
                                      context: context,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      onTap: () {
                                        _lastEnteredPhone =
                                            _phoneController.text;
                                        addEvent(
                                            context,
                                            CodePhoneEvent(
                                                '+${_selectedCountry.dialCode}$_lastEnteredPhone'));
                                        // if (_phoneFormKey.currentState!
                                        //     .validate()) {
                                        //   // Process the phone, e.g., send it to a server
                                        //   print(
                                        //       'phone: ${_phoneController.text}');
                                        // }
                                      },
                                    ),
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
              child: StepsFooter.create(widget.data, (String key) {
                getString(key);
              }))
        ],
      ),
    );
  }

  @override
  void consumeState(BuildContext context, BaseBlocState state) {
    if (state is StateSuccessWithResult) {
      addEvent(
          context,
          GoToSignupPhoneNumberOtp(
              phone: '+${_selectedCountry.dialCode}$_lastEnteredPhone',
              country: _selectedCountry,
            ));
    } else if (state is StateError && state.error is BadRequestError) {
      AppSnackbar().show(
          context: context,
          type: SnackbarType.warning,
          message: (state.error as BadRequestError).detail);
    }
  }
}
