import 'package:billit_now/apps/helper/router/router_extention/signup_router_extention.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_snackbar.dart';
import 'package:billit_now/component/app_text_field.dart';
import 'package:billit_now/features/base/base_bloc.dart';
import 'package:billit_now/features/base/base_bloc_stateless_widget.dart';
import 'package:billit_now/features/base/base_extra.dart';
import 'package:billit_now/features/base/base_stateful_page.dart';
import 'package:billit_now/repositories/auth/models/snackbar_type.dart';
import 'package:billit_now/repositories/shared/errors.dart';
import 'package:billit_now/templates/auth/signup/signup_data.dart';
import 'package:billit_now/templates/auth/signup/signup_email_otp.dart';
import 'package:billit_now/templates/auth/widgets/auth_scaffold.dart';
import 'package:billit_now/templates/auth/widgets/device_info_provider.dart';
import 'package:billit_now/templates/auth/widgets/main_logo.dart';
import 'package:billit_now/templates/auth/widgets/steps_footer.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../features/base/base_bloc_event.dart';
import '../../../features/base/base_bloc_state.dart';
import '../../../repositories/auth/auth_repository.dart';
import '../../../repositories/auth/input_models/send_code_input_model.dart';
import '../../../repositories/auth/models/auth_type_enum_model.dart';
import '../../../repositories/shared/models/code_type.dart';

sealed class SignupEmailEvent extends BaseBlocEvent {}

class CodeEvent extends SignupEmailEvent {
  String email;
  CodeEvent({required this.email});
}

@injectable
class SignupEmailBloc extends BaseBloc<SignupEmailEvent, BaseBlocState> {
  AuthRepository authRepo;
  SignupEmailBloc(this.authRepo) {
    on<CodeEvent>((event, emit) async => callRepoWithResult(emit: emit, repoFunc: await authRepo.sendCode(SendCodeInputModel(
            codeType: CodeType.email,
            input: event.email,
            deviceInfoModel: await getDeviceInfoModel())))
    );
  }
}

class GoToEmailOtpPage extends BaseBlocEvent {
  final String email;
  GoToEmailOtpPage({required this.email});
}

class GoToDetailsPage extends BaseBlocEvent {}

class SignupEmailPageExtra implements BaseExtra {
  @override
  final String from;

  SignupEmailPageExtra({
    required this.from,
  });
}

class SignupEmailPage extends BaseStatefulPage {
  const SignupEmailPage({
    super.key,
    // required this.argument,
  });

  // final SignupEmailPageExtra? argument;

  @override
  State<StatefulWidget> createState() => _SignupEmailPageState();
}

class _SignupEmailPageState extends BasePageState<SignupEmailPage> {
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
      return SignupEmail(data: _data!);
    }
  }

  @override
  void consumeEvent(BuildContext context, BaseBlocEvent event) {
    if (event is GoToEmailOtpPage) {
      if (_data != null) {
        saveOnStorage(_data!.copy(email: event.email), () {
          context
              .goSignupEmailOtp(SignupEmailOtpPageExtra(from: 'signup_email'));
        });
      }
    }
  }
}

class SignupEmail extends BaseBlocStatelessWidget<SignupEmailBloc> {
  SignupEmail({super.key, required this.data});

  final SignupData data;
  final _mailFormKey = GlobalKey<FormState>();
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
                            MainLogo(iconName: AppIconName.uec48Mail01),
                            const SizedBox(height: 24),
                            // title
                            Container(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Center(
                                child: Text(
                                  getString("verify_your_email_address"),
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
                                getString("please_enter_your_email_address"),
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
                                        keyboardType: TextInputType.text,
                                        labelText: getString("email_address"),
                                        placeHolder: getString("email_address_sample"),
                                        helpText: '',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return getString("please_enter_your_password");
                                          }
                                          return null;
                                        }),
                                    const SizedBox(height: 12),
                                    AppButton.buttonPrimary(
                                      text: getString("confirm_and_continue"),
                                      context: context,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      onTap: () {
                                        _lastEnteredEmail =
                                            _emailController.text;
                                        addEvent(
                                            context,
                                            CodeEvent(
                                                email: _lastEnteredEmail));
                                        // context.goSignupContinueEmailAddressOtp();
                                        // if (_mailFormKey.currentState!.validate()) {
                                        // Process the email, e.g., send it to a server
                                        // print('Email: ${_emailController.text}');
                                        // }
                                      },
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
    if (state is StateSuccessWithResult<AuthTypeEnumModel>) {
      if (state.result == AuthTypeEnumModel.signup) {
        addEvent(context, GoToEmailOtpPage(email: _lastEnteredEmail));
      } else if (state.result == AuthTypeEnumModel.login) {
        // TODO Ask what do we do here?
      }
    } else if (state is StateError && state.error is BadRequestError) {
      AppSnackbar().show(
          context: context,
          type: SnackbarType.warning,
          message: (state.error as BadRequestError).detail);
    }
  }
}
