import 'package:billit_now/apps/helper/router/router_extention/signup_router_extention.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_text_field.dart';
import 'package:billit_now/features/base/base_stateful_page.dart';
import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:billit_now/templates/auth/signup/signup_data.dart';
import 'package:billit_now/templates/auth/signup/signup_terms.dart';
import 'package:billit_now/templates/auth/widgets/auth_scaffold.dart';
import 'package:billit_now/templates/auth/widgets/main_logo.dart';
import 'package:billit_now/templates/auth/widgets/password_checker.dart';
import 'package:billit_now/templates/auth/widgets/steps_footer.dart';
import 'package:flutter/material.dart';

import '../../../features/base/base_bloc_event.dart';
import '../../../features/base/base_extra.dart';

class GoToTermsPage extends BaseBlocEvent {
  String firstName;
  String lastName;
  String password;
  GoToTermsPage({
    required this.firstName,
    required this.lastName,
    required this.password,
  });
}

class SignupDetailsPageExtra implements BaseExtra {
  @override
  final String from;

  SignupDetailsPageExtra({
    required this.from,
  });
}

class SignupDetailsPage extends BaseStatefulPage {

  // final SignupDetailsPageExtra? argument;

  const SignupDetailsPage({
    // required this.argument,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SignupDetailsPageState();

}

class _SignupDetailsPageState extends BasePageState<SignupDetailsPage> {

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
    if(_data == null) {
      return Container();
    } else {
      return SignupDetails();
    }
  }

  @override
  void consumeEvent(BuildContext context, BaseBlocEvent event) {
    if (event is GoToTermsPage) {
      if (_data != null) {
        saveOnStorage(
            _data!.copy(
              firstName: event.firstName,
              lastName: event.lastName,
              password: event.password,
            ), () {
          context.goSignupTerms(
            SignupTermsPageExtra(
              from: 'signup_details',
            ),
          );
        });
      }
    }
  }
}

class SignupDetails extends BaseStatefulWidget {
  const SignupDetails({super.key});

  @override
  State<SignupDetails> createState() => _SignupDetailsState();
}

class _SignupDetailsState extends BaseWidgetState<SignupDetails> {
  final _verifyFormKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  String password = '';

  final ScrollController _scrollController = ScrollController();

  @override
  Widget body(BuildContext context) {
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
                            MainLogo(iconName: AppIconName.ueb4dInfoCircle),
                            const SizedBox(height: 24),
                            // title
                            Container(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Center(
                                child: Text(
                                  getString("complete_your_details"),
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
                                getString("provide_your_name_and_password_to_continue"),
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
                        Form(
                          key: _verifyFormKey,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: AppTextField.main(
                                          controller: _firstNameController,
                                          keyboardType: TextInputType.text,
                                          labelText: getString("first_name"),
                                          placeHolder: '',
                                          helpText: '',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return getString("please_enter_first_name");
                                            }
                                            return null;
                                          }),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: AppTextField.main(
                                          controller: _lastNameController,
                                          keyboardType: TextInputType.text,
                                          labelText: getString("last_name"),
                                          placeHolder: '',
                                          helpText: '',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return getString("please_enter_last_name");
                                            }
                                            return null;
                                          }),
                                    ),
                                  ],
                                ),
                                AppTextField.main(
                                    controller: _passwordController,
                                    keyboardType: TextInputType.text,
                                    labelText: getString("password"),
                                    isObscure: true,
                                    onChanged: (value) {
                                      setState(() {
                                        password = value;
                                      });
                                    },
                                    placeHolder: '',
                                    helpText: '',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return getString("please_enter_verification_code");
                                      }
                                      return null;
                                    }),
                                PasswordChecker(password: password),
                                const SizedBox(height: 12),
                                AppButton.buttonPrimary(
                                  text: getString("confirm_and_continue"),
                                  context: context,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  onTap: () {
                                    // context.goSignupTerms();
                                    addEvent(
                                        context,
                                        GoToTermsPage(
                                          firstName: _firstNameController.text,
                                          lastName: _lastNameController.text,
                                          password: _passwordController.text,
                                        ));
                                    // if (_verifyFormKey.currentState!
                                    //     .validate()) {
                                    //   // Process the email, e.g., send it to a server
                                    //   print(
                                    //       'Email: ${_codeVerifyController.text}');
                                    // }
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                        // email validation form
                      ],
                    ),
                  ),
                ),
              )),
          Align(
              alignment: Alignment.bottomCenter,
              child: StepsFooter(items: [
                {
                  'title': getString("verify_your_email_address"),
                  'subTitle': getString("verification_of_the_code_sent"),
                  'enable': true
                },
                {
                  'title': getString("verify_your_phone_number"),
                  'subTitle': getString("provide_and_verify_phone_number"),
                  'enable': true
                },
                {
                  'title': getString("complete_your_details"),
                  'subTitle': getString("provide_name_and_password"),
                  'enable': true
                },
                {
                  'title': getString("agree_to_terms"),
                  'subTitle': getString("confirm_rules_to_finish_account_setup"),
                  'enable': false
                },
              ]))
        ],
      ),
    );
  }
}
