import 'package:billit_now/apps/helper/router/router_extention/signup_router_extention.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_snackbar.dart';
import 'package:billit_now/component/app_text_field.dart';
import 'package:billit_now/core/di/di_setup.dart';
import 'package:billit_now/features/base/base_bloc.dart';
import 'package:billit_now/features/base/base_bloc_state.dart';
import 'package:billit_now/features/base/base_bloc_stateless_widget.dart';
import 'package:billit_now/features/base/base_stateful_page.dart';
import 'package:billit_now/repositories/auth/auth_repository.dart';
import 'package:billit_now/repositories/auth/input_models/verify_signup_input_model.dart';
import 'package:billit_now/repositories/auth/models/snackbar_type.dart';
import 'package:billit_now/repositories/shared/errors.dart';
import 'package:billit_now/templates/auth/signup/signup_data.dart';
import 'package:billit_now/templates/auth/signup/signup_details.dart';
import 'package:billit_now/templates/auth/signup/signup_email.dart';
import 'package:billit_now/templates/auth/signup/signup_phone_number.dart';
import 'package:billit_now/templates/auth/widgets/auth_scaffold.dart';
import 'package:billit_now/templates/auth/widgets/main_logo.dart';
import 'package:billit_now/templates/auth/widgets/resend_code.dart';
import 'package:billit_now/templates/auth/widgets/steps_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:oktoast/oktoast.dart';

import '../../../features/base/base_bloc_event.dart';
import '../../../features/base/base_extra.dart';
import '../../../repositories/shared/models/code_type.dart';

class SignupEmailOtpEvent extends BaseBlocEvent {}

class VerifyEmailEvent extends SignupEmailOtpEvent {
  String email;
  String code;
  VerifyEmailEvent({
    required this.email,
    required this.code,
  });
}

@injectable
class SignupEmailOtpBloc extends BaseBloc<SignupEmailOtpEvent, BaseBlocState> {
  AuthRepository authRepo;
  SignupEmailOtpBloc(this.authRepo) {
    on<VerifyEmailEvent>((event, emit) async => callRepo(
        emit: emit,
        repoFunc: await authRepo.verifySignup(VerifySignupInputModel(
          id: event.email,
          type: CodeType.email,
          code: event.code,
        ))));
  }
}

class EmailVerifiedEvent extends BaseBlocEvent {}

class SignupEmailOtpPageExtra implements BaseExtra {
  @override
  final String from;

  SignupEmailOtpPageExtra({
    required this.from,
  });
}

class SignupEmailOtpPage extends BaseStatefulPage {
  // final SignupEmailOtpPageExtra? argument;

  const SignupEmailOtpPage({
    // required this.argument,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SignupEmailOtpPageState();
}

class _SignupEmailOtpPageState extends BasePageState<SignupEmailOtpPage> {
  SignupData? _data;

  @override
  bool allowRTLDirectionality() => true;

  @override
  List setProviders(BuildContext context) {
    return [BlocProvider(create: (context) => getIt<SignupEmailBloc>())];
  }

  @override
  void initState() {
    super.initState();
    _loadSignupData();
  }

  @override
  Widget body(BuildContext context) {
    if (_data == null) {
      return Container();
    } else {
      return SignupEmailOtp(data: _data!);
    }
  }

  Future<void> _loadSignupData() async {
    SignupData data = await retrieveFromStorage();
    setState(() {
      _data = data;
    });
  }

  @override
  void consumeEvent(BuildContext context, BaseBlocEvent event) {
    if (event is EmailVerifiedEvent) {
      if (_data != null) {
        if (_data!.phone == null || _data!.phone!.isEmpty) {
          // So we didn't verified phone, let's verify it:
          context.goSignupPhoneNumber(
              SignupPhoneNumberPageExtra(from: 'signup_email_otp'));
        } else {
          context.goSignupDetails(SignupDetailsPageExtra(
            from: 'signup_email_otp',
          ));
        }
      }
    } else if (event is CodeEvent) {
      context.read<SignupEmailBloc>().add(event);
    }
  }
}

class SignupEmailOtp extends BaseBlocStatelessWidget<SignupEmailOtpBloc> {
  SignupEmailOtp({required this.data, super.key}) {
    _email = data.email ?? '';
  }

  final SignupData data;
  final _otpFormKey = GlobalKey<FormState>();
  late final String _email;
  final TextEditingController _codeOtpController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  @override
  Widget body(BuildContext context, BaseBlocState state) {
    return OKToast(
      child: AuthScaffold(
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
                                  getString("verification_sent_email"),
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
                                          keyboardType: TextInputType.number,
                                          labelText: getString("email_address"),
                                          placeHolder: '',
                                          helpText: '',
                                          enable: false,
                                          initValue: _email,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return getString(
                                                  "please_enter_verification_code");
                                            }
                                            return null;
                                          }),
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
                                                CodeEvent(
                                                    email: data.email ?? ""));
                                          }),
                                          Expanded(
                                            child: AppButton.buttonPrimary(
                                              text: getString("verify_email"),
                                              context: context,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 10),
                                              onTap: () {
                                                // context.goSignupPhoneNumber();
                                                addEvent(
                                                    context,
                                                    VerifyEmailEvent(
                                                        email: data.email ?? "",
                                                        code: _codeOtpController
                                                            .text));
                                                // if (_otpFormKey.currentState!
                                                // .validate()) {
                                                // Process the email, e.g., send it to a server
                                                // print(
                                                //     'Email: ${_codeOtpController.text}');
                                                // }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      // Back to Log in Btn
                                      AppButton.buttonTertiary(
                                          text: getString("back_to_sign_up"),
                                          textColor: Theme.of(context)
                                              .appColors
                                              .buttonTeritoryFg,
                                          icon: AppIconName.arrowLeft,
                                          context: context,
                                          onTap: () {
                                            context.pop();
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
              child: StepsFooter.create(data, (String key) {
                getString(key);
              }),
            )
          ],
        ),
      ),
    );
  }

  @override
  void consumeState(BuildContext context, BaseBlocState state) {
    if (state is StateSuccess) {
      addEvent(context, EmailVerifiedEvent());
    } else if (state is StateError && state.error is BadRequestError) {
      AppSnackbar().show(
          context: context,
          type: SnackbarType.warning,
          message: (state.error as BadRequestError).detail);
    }
  }
}
