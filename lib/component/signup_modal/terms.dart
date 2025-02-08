import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/signup_modal/stepper.dart';
import 'package:billit_now/repositories/event_map/models/stepper_num.dart';
import 'package:billit_now/templates/auth/widgets/main_logo.dart';
import 'package:flutter/material.dart';

class Terms extends StatefulWidget {
  const Terms({super.key, required this.onAgreeTerms});

  final Function onAgreeTerms;

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  final List<Map<String, String>> terms = [
    {
      'title': 'Ticket Purchase',
      'body':
          'All ticket sales are final. After purchase, you can change your seat or position for a few minutes, after which tickets are non-refundable or exchangeable, unless the event is canceled or rescheduled.'
    },
    {
      'title': 'Event Changes',
      'body':
          'We reserve the right to make changes to events, including date, time, venue and order. We will notify users of any material changes via email or via the Platform.'
    },
    {
      'title': 'Account',
      'body':
          'Users must create an account to purchase tickets. You are responsible for maintaining the confidentiality of your account information and all activities that occur under your account.'
    },
    {
      'title': 'Age restrictions',
      'body':
          "Some events may have age restrictions. It is the user's responsibility to ensure that they meet the age requirements of the event."
    },
    {
      'title': 'Code of Conduct',
      'body':
          'Users must adhere to all rules and regulations set forth by the event organizers and venue. Disruptive behavior may result in expulsion from the event without a refund.'
    },
    {
      'title': 'Data Privacy',
      'body':
          'We respect your privacy. Personal data collected during the registration and purchase process will be handled in accordance with our Privacy Policy.'
    },
    {
      'title': 'Limitation of Liability',
      'body':
          'We are not responsible for any indirect, incidental or consequential damages arising from the use of the Services or attendance at the Events.'
    },
    {
      'title': 'Governing Law',
      'body':
          'These terms are governed by the laws of Austria and Germany. Any dispute will be settled in the relevant courts of the respective country.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 24.0,
            ),
            // logo
            MainLogo(iconName: AppIconName.ued08FileCheck02),

            Container(
              width: 24.0,
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        // title
        Container(
          padding: const EdgeInsets.only(bottom: 12),
          child: Center(
            child: Text(
              'Agree to Terms',
              style: Theme.of(context)
                  .appTexts
                  .textLgSemiBold
                  .copyWith(color: Theme.of(context).appColors.textPrimary900),
            ),
          ),
        ),
        // subtitle
        Center(
          child: Text(
            'Confirm rules to finish account setup.',
            style: Theme.of(context)
                .appTexts
                .textSmRegular
                .copyWith(color: Theme.of(context).appColors.textTeritory600),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
              child: Center(
            child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                    text:
                        'To create a user account, you must read and agree to the following terms and conditions:\n\n',
                    style: Theme.of(context).appTexts.textMdRegular.copyWith(
                        color: Theme.of(context).appColors.textPrimary900),
                    children: List.generate(terms.length, (index) {
                      return _term(context, (index + 1).toString(),
                          terms[index]['title']!, terms[index]['body']!);
                    }))),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 32.0, bottom: 24.0, right: 24.0, left: 24.0),
          child: AppButton.buttonPrimary(
              context: context,
              text: 'Agree & create account',
              padding: EdgeInsets.symmetric(vertical: 10.0),
              onTap: () => widget.onAgreeTerms),
        ),
        // Stepper
        StepperSignUp(step: StepperNum.step3),
      ],
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
}
