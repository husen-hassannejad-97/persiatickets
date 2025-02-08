import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:billit_now/repositories/event/models/what_attendees_say_model.dart';
import 'package:billit_now/templates/events/widgets/app_collapse.dart';
import 'package:billit_now/templates/events/widgets/rating.dart';
import 'package:billit_now/templates/landing/utils.dart';
import 'package:flutter/material.dart';

import '../widgets/comment_modal.dart';

class WhatAttendeesSay extends BaseStatelessWidget {
  WhatAttendeesSay({
    super.key,
    required this.data,
    required this.writeReview,
    required this.showAllReviews,
  });

  final WhatAttendeesSayModel data;
  final Function() writeReview;
  final Function() showAllReviews;

  @override
  Widget body(BuildContext context) {
    return data.comments.isEmpty
        ? Container()
        : AppCollapse(
            title: 'What Attendees Are Saying (${data.averageScore}/5)',
            children: [
                ...List.generate(
                    data.comments.length,
                    (int index) => index < 6
                        ? _comment(
                            context,
                            index,
                            data.comments[index].name ?? "", // FIXME
                            data.comments[index].score ?? 0.0,
                            data.comments[index].date,
                            data.comments[index].comment,
                            data.comments[index].organizerResponse?.comment ?? "",
                            data.comments[index].organizerResponse?.date ?? DateTime.now(),
                          )
                        : Container()),
                data.comments.length <= 6
                    ? Container()
                    : Container(
                        padding: const EdgeInsets.only(top: 20.0),
                        width: 150,
                        child: AppButton.buttonTertiary(
                            context: context,
                            bgHoverColor: Colors.transparent,
                            text: 'Show all ${data.comments.length} reviews',
                            onTap: showAllReviews),
                      ),
                Container(
                  padding: EdgeInsets.only(top: 24.0),
                  width: 250,
                  child: AppButton.buttonIcon(AppIconName.ueb2fEdit05,
                      text: 'Write a review and rate',
                      iconColor: Theme.of(context).appColors.textWhite,
                      iconSize: 20.0,
                      bgColor: Theme.of(context).appColors.buttonPrimaryBg,
                      bgHoverColor:
                          Theme.of(context).appColors.buttonPrimaryBgHover,
                      textColor: Theme.of(context).appColors.textWhite,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16.0),
                      context: context, onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CommentModal.show(
                          rating: (double rate) {},
                          comment: (String comment) {},
                        );
                      },
                    );
                  }),
                )
              ]);
  }

  Widget _comment(
          BuildContext context,
          int index,
          String name,
          double score,
          DateTime commentDate,
          String comment,
          String response,
          DateTime responseDate) =>
      Column(
        children: [
          index == 0
              ? Container()
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Divider(
                    color: Theme.of(context)
                        .appColors
                        .borderPrimary
                        .withOpacity(0.5),
                    thickness: 1.0,
                  ),
                ),
          // NAme and score and Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  //profile image
                  name.length < 2
                      ? Container()
                      : Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Theme.of(context).appColors.bgSecondary,
                              borderRadius: BorderRadius.circular(100)),
                          child: Text(
                              '${name[0].toUpperCase()}${name[1].toUpperCase()}',
                              style: Theme.of(context)
                                  .appTexts
                                  .textLgSemiBold
                                  .copyWith(
                                      color: Theme.of(context)
                                          .appColors
                                          .fgQuinary400)),
                        ),
                  SizedBox(width: 8.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Text(name,
                          style: Theme.of(context)
                              .appTexts
                              .textMdSemiBold
                              .copyWith(
                                  color: Theme.of(context)
                                      .appColors
                                      .textPrimary900)),
                      //score
                      Row(
                        children: [
                          Rating(score: score),
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: Text('$score/5',
                                style: Theme.of(context)
                                    .appTexts
                                    .textMdSemiBold
                                    .copyWith(
                                        color: Theme.of(context)
                                            .appColors
                                            .textPrimary900)),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              Text(formatFullDate(commentDate), // TODO Check
                  style: Theme.of(context).appTexts.textMdRegular.copyWith(
                      color: Theme.of(context).appColors.textTeritory600))
            ],
          ),
          // commnet
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(comment,
                style: Theme.of(context).appTexts.textMdRegular.copyWith(
                    color: Theme.of(context).appColors.textSecondary700)),
          ),
          // response and Date
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Organizer\'s Response',
                    style: Theme.of(context).appTexts.textMdSemiBold.copyWith(
                        color: Theme.of(context).appColors.textPrimary900)),
                Text(formatFullDate(responseDate),
                    style: Theme.of(context).appTexts.textMdRegular.copyWith(
                        color: Theme.of(context).appColors.textTeritory600))
              ],
            ),
          ),
          // response commnet
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(response,
                style: Theme.of(context).appTexts.textMdRegular.copyWith(
                    color: Theme.of(context).appColors.textSecondary700)),
          ),
        ],
      );
}
