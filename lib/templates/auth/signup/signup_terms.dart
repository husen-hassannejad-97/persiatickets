import 'package:billit_now/apps/helper/router/router_extention/signup_router_extention.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/core/di/di_setup.dart';
import 'package:billit_now/features/base/base_bloc.dart';
import 'package:billit_now/features/base/base_bloc_event.dart';
import 'package:billit_now/features/base/base_bloc_state.dart';
import 'package:billit_now/features/base/base_stateful_page.dart';
import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:billit_now/repositories/auth/auth_repository.dart';
import 'package:billit_now/repositories/auth/input_models/complete_input_model.dart';
import 'package:billit_now/repositories/shared/errors.dart';
import 'package:billit_now/templates/auth/signup/signup_data.dart';
import 'package:billit_now/templates/auth/widgets/auth_scaffold.dart';
import 'package:billit_now/templates/auth/widgets/main_logo.dart';
import 'package:billit_now/templates/auth/widgets/steps_footer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../features/base/base_extra.dart';
import '../../../repositories/shared/result.dart';

class SignupTermsPageEvent extends BaseBlocEvent {}
class CompleteSignup extends SignupTermsPageEvent{
  final String email;
  final String phoneNumber;
  final String password;
  final String firstName;
  final String lastName;
  CompleteSignup({
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
}

class SignupTermsEvent extends BaseBlocEvent {}
class TermsAgreed extends SignupTermsEvent{}

@injectable
class SignupTermsPageBloc extends BaseBloc<SignupTermsPageEvent, BaseBlocState> {
  AuthRepository authRepo;
  SignupTermsPageBloc({required this.authRepo}) {
    on<CompleteSignup>((event, emit) async {
      try {
        // Emit loading state
        emit(StateLoading());

        // Call the repository function
        final result = await authRepo.complete(
            CompleteInputModel(
              email: event.email,
              phoneNumber: event.phoneNumber,
              password: event.password,
              firstName: event.firstName,
              lastName: event.lastName,
            )
        );

        // Handle result
        if (result is Success) {
          emit(StateSuccess());
        } else if (result is Error) {
          emit(StateError(error: result.error));
        } else {
          throw UnexpectedError(message: 'Unhandled Result type');
        }
      } catch (e, stackTrace) {
        // Handle any unexpected errors
        emit(StateError(error: UnexpectedError(message: "An unexpected error happened!")));
        // Log stack trace for debugging
        if (kDebugMode) {
          print('Error in ResultToStateConverter: $e\n$stackTrace');
        }
      }
    });
  }
}

class SignupTermsPageExtra implements BaseExtra {
  @override
  final String from;

  SignupTermsPageExtra({
    required this.from,
  });
}

class SignupTermsPage extends BaseStatefulPage {

  // final SignupTermsPageExtra? argument;

  const SignupTermsPage({
    // required this.argument,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SignupTermsPageState();

}

class _SignupTermsPageState extends BasePageState<SignupTermsPage> {

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
  List setProviders(BuildContext context) {
    return [
      BlocProvider(create: (context) {
        return getIt<SignupTermsPageBloc>();
      })
    ];
  }

  @override
  Widget body(BuildContext context) {
    return BlocListener<SignupTermsPageBloc, BaseBlocState>(
        listener: (context, state) => {
          if(state is StateSuccess) {
            clearFromStorage(() {
              context.goSignupSuccess();
            })
          }
        },
        child: _data == null ? Container() : SignupTerms(data: _data!)
    );
  }

  @override
  void consumeEvent(BuildContext context, BaseBlocEvent event) {
    if(event is TermsAgreed) {
      if(_data != null) {
        context.read<SignupTermsPageBloc>().add(
            CompleteSignup(
              email: _data!.email ?? "",
              phoneNumber: _data!.phone ?? "",
              password: _data!.password ?? "",
              firstName: _data!.firstName ?? "",
              lastName: _data!.lastName ?? "",
            )
        );
      }
    }
  }

}

class SignupTerms extends BaseStatefulWidget {
  const SignupTerms({super.key, required this.data});

  final SignupData data;

  @override
  State<SignupTerms> createState() => _SignupTermsState(data: data);
}

class _SignupTermsState extends BaseWidgetState<SignupTerms> {

  _SignupTermsState({required this.data});
  final ScrollController _scrollController = ScrollController();
  bool isAtBottom = false;
  final SignupData data;

  late List<Map<String, String>> terms;

  @override
  void initState() {
    super.initState();
    terms = [
      {
        'title': getString("ticket_purchase"),
        'body':
        getString("ticket_purchase_term_description")
      },
      {
        'title': getString("event_changes"),
        'body':
        getString("'We reserve the right to make changes to events, including date, time, venue and order. We will notify users of any material changes via email or via the Platform.")
      },
      {
        'title': getString("account"),
        'body':
        getString("account_term_description")
      },
      {
        'title': getString("age_restrictions"),
        'body':
        getString("age_restrictions_term_description")
      },
      {
        'title': getString("code_of_conduct"),
        'body':
        getString("code_of_conduct_term_description")
      },
      {
        'title': getString("data_privacy"),
        'body':
        getString("data_privacy_term_description")
      },
      {
        'title': getString("limitation_of_liability"),
        'body':
        getString("limitation_of_liability_term_description")
      },
      {
        'title': getString("governing_law"),
        'body':
        getString("governing_law_term_description")
      },
    ];
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent - 100) {
      setState(() {
        isAtBottom = true;
      });
    } else {
      setState(() {
        isAtBottom = false;
      });
    }
  }

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
                            MainLogo(iconName: AppIconName.ued08FileCheck02),
                            const SizedBox(height: 24),
                            // title
                            Container(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Center(
                                child: Text(
                                  getString("agree_to_terms"),
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
                                getString("confirm_rules_to_finish_account_setup"),
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
                            RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                    text:
                                        "${getString("you_must_read_and_agree_to_the_following_terms")}\n\n",
                                    style: Theme.of(context)
                                        .appTexts
                                        .textMdRegular
                                        .copyWith(
                                            color: Theme.of(context)
                                                .appColors
                                                .textPrimary900),
                                    children:
                                        List.generate(terms.length, (index) {
                                      return _term(
                                          context,
                                          (index + 1).toString(),
                                          terms[index]['title']!,
                                          terms[index]['body']!);
                                    }))),
                            const SizedBox(height: 12),
                            AppButton.buttonPrimary(
                              text: getString("agree_and_create_account"),
                              context: context,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              onTap: () {
                                addEvent(context, TermsAgreed());
                                // context.goSignupSuccess();
                              },
                            ),
                            const SizedBox(height: 50)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )),
          isAtBottom
              ? Container()
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 90),
                      width: 32,
                      height: 32,
                      child: AppButton.buttonIcon(AppIconName.chevronDown,
                          bgColor: Theme.of(context).appColors.bgPrimary,
                          bgHoverColor:
                              Theme.of(context).appColors.bgPrimaryHover,
                          textColor: Theme.of(context).appColors.fgSecondary700,
                          iconSize: 8,
                          context: context,
                          onTap: () => _scrollDown()))),
          Align(
              alignment: Alignment.bottomCenter,
              child: StepsFooter.create(data, (String key) {
                getString(key);
              }))
        ],
      ),
    );
  }

  TextSpan _term(
          BuildContext context, String number, String title, String text) =>
      TextSpan(
          text: '\t\t\t\t$number. $title: ',
          style: Theme.of(context)
              .appTexts
              .textMdSemiBold
              .copyWith(color: Theme.of(context).appColors.textPrimary900),
          children: [
            TextSpan(
                text: '$text\n\n',
                style: Theme.of(context).appTexts.textMdRegular.copyWith(
                    color: Theme.of(context).appColors.textPrimary900))
          ]);

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }
}
