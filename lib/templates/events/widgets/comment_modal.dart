import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/templates/events/widgets/comment_textfield.dart';
import 'package:billit_now/templates/events/widgets/rating_selectable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommentModal extends StatelessWidget {
  CommentModal._internal(
      {super.key, required this.rating, required this.comment});

  final Function(double rate) rating;
  final Function(String commnet) comment;

  factory CommentModal.show(
          {Key? key,
          required Function(double rate) rating,
          required Function(String commnet) comment}) =>
      CommentModal._internal(key: key, rating: rating, comment: comment);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Theme.of(context).appColors.bgPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        padding: EdgeInsets.all(24),
        height: 456,
        width: 480,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Write a Review',
                      style: Theme.of(context).appTexts.textLgSemiBold.copyWith(
                          color: Theme.of(context).appColors.textPrimary900)),
                  AppButton.buttonIcon(AppIconName.ueaefXClose,
                      bgColor: Colors.transparent,
                      bgHoverColor: Colors.transparent,
                      textColor: Colors.transparent,
                      iconSize: 24,
                      context: context, onTap: () {
                    Navigator.pop(context);
                  })
                ]),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                'Rate the event and leave a comment to share your experience.',
                style: Theme.of(context).appTexts.textSmRegular.copyWith(
                    color: Theme.of(context).appColors.textTeritory600),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 8.0),
              width: 480,
              child: Center(
                child: Text(
                  'Rate the Event',
                  style: Theme.of(context).appTexts.textMdSemiBold.copyWith(
                      color: Theme.of(context).appColors.textSecondary700),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(bottom: 8.0),
                width: 480,
                child: RatingSelectable(
                  rate: rating,
                )),
            SizedBox(
                height: 200.0,
                child: CommentTextField(controller: _controller)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 100,
                  child: AppButton.buttonTertiary(
                      context: context,
                      text: 'Cancel',
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      border: Border.all(
                          color:
                              Theme.of(context).appColors.buttonSecondaryBorder,
                          width: 1),
                      onTap: () {
                        context.pop();
                      }),
                ),
                SizedBox(
                  width: 150,
                  child: AppButton.buttonPrimary(
                      context: context,
                      text: 'Submit Review',
                      padding: EdgeInsets.symmetric(vertical: 10),
                      onTap: () {
                        comment(_controller.text);
                        context.pop();
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
