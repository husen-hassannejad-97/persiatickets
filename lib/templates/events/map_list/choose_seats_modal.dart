import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChooseSeatsModal extends StatefulWidget {
  final Function(int count) ticketCount;
  final Function(String group) selectedGroup;
  final Function(String title) groupTitle;

  ChooseSeatsModal._internal(
      {super.key,
      required this.ticketCount,
      required this.selectedGroup,
      required this.groupTitle});

  factory ChooseSeatsModal.show(
          {Key? key,
          required Function(int count) ticketCount,
          required Function(String group) selectedGroup,
          required Function(String title) groupTitle}) =>
      ChooseSeatsModal._internal(
          key: key,
          ticketCount: ticketCount,
          selectedGroup: selectedGroup,
          groupTitle: groupTitle);

  @override
  State<ChooseSeatsModal> createState() => _ChooseSeatsModalState();
}

class _ChooseSeatsModalState extends State<ChooseSeatsModal> {
  int selectedGroup = 0;
  List<String> groups = ['Friends group', 'Family group', 'Other group'];
  TextEditingController titleGroupController = TextEditingController();
  int ticketCount = 1;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      backgroundColor: Theme.of(context).appColors.bgPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SizedBox(
        height: 544,
        width: 512,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context),
            Divider(
              color: Theme.of(context).appColors.borderPrimary,
              height: 1,
            ),
            _ticketCounter(context),
            Divider(
              color: Theme.of(context).appColors.borderPrimary,
              height: 1,
            ),
            _groupSelection(context, groups, selectedGroup, (index) {
              setState(() {
                selectedGroup = index;
              });
            }),
            Divider(
              color: Theme.of(context).appColors.borderPrimary,
              height: 1,
            ),
            // botton Btns
            _bottonBtns(context)
          ],
        ),
      ),
    );
  }

  _header(BuildContext context) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // icon
            Container(
              padding: EdgeInsets.all(12.0),
              margin: EdgeInsets.only(right: 16.0),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).appColors.borderSecondary,
                  ),
                  borderRadius: BorderRadius.circular(10.0)),
              child: AppIcon.button(
                  appIconName: AppIconName.ued5bTicket01,
                  size: 24,
                  context: context),
            ),

            // title and suntitle
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select your tickets and group',
                    style: Theme.of(context).appTexts.textLgSemiBold.copyWith(
                        color: Theme.of(context).appColors.textPrimary900)),
                Text('Select your tickets and group them with your companions.',
                    style: Theme.of(context).appTexts.textSmRegular.copyWith(
                        color: Theme.of(context).appColors.textTeritory600)),
              ],
            )
          ],
        ),
      );

  _ticketCounter(BuildContext context) => Center(
        child: Column(
          children: [
            Text('Number of Tickets',
                style: Theme.of(context).appTexts.textSmSemiBord.copyWith(
                    color: Theme.of(context).appColors.textPrimary900)),
            Text('Choose between 1 to 15 tickets.',
                style: Theme.of(context).appTexts.textSmRegular.copyWith(
                    color: Theme.of(context).appColors.textTeritory600)),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppButton.buttonIcon(AppIconName.ueb0eMinus,
                    bgColor: Colors.transparent,
                    bgHoverColor: Colors.transparent,
                    textColor: Colors.transparent,
                    padding: EdgeInsets.all(8.0),
                    border: Border.all(
                      color: Theme.of(context).appColors.buttonSecondaryBorder,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                    context: context, onTap: () {
                  int count = ticketCount - 1;
                  setState(() {
                    if (count > 0) {
                      ticketCount = count;
                    }
                  });
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(ticketCount.toString(),
                      style: Theme.of(context)
                          .appTexts
                          .displayMdSemibold
                          .copyWith(
                              color:
                                  Theme.of(context).appColors.textPrimary900)),
                ),
                AppButton.buttonIcon(AppIconName.ueb16Plus,
                    bgColor: Colors.transparent,
                    bgHoverColor: Colors.transparent,
                    textColor: Colors.transparent,
                    padding: EdgeInsets.all(8.0),
                    border: Border.all(
                      color: Theme.of(context).appColors.buttonSecondaryBorder,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                    context: context, onTap: () {
                  int count = ticketCount + 1;
                  setState(() {
                    ticketCount = count;
                  });
                })
              ],
            )
          ],
        ),
      );

  _groupSelection(
    BuildContext context,
    List<String> groups,
    int selectedGroup,
    void Function(dynamic) onChanged,
  ) =>
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Who Are You Attending With?',
              style: Theme.of(context)
                  .appTexts
                  .textSmSemiBord
                  .copyWith(color: Theme.of(context).appColors.textPrimary900)),
          Text('Select the group type.',
              style: Theme.of(context).appTexts.textMdRegular.copyWith(
                  color: Theme.of(context).appColors.textTeritory600)),
          SizedBox(height: 12),
          Row(
              children: List.generate(
                  groups.length,
                  (int index) => AppButton.radio(
                          Radio(
                            value: index,
                            activeColor:
                                Theme.of(context).appColors.borderBrand,
                            groupValue: selectedGroup,
                            onChanged: onChanged,
                          ),
                          text: groups[index],
                          textStyle: Theme.of(context)
                              .appTexts
                              .textSmSemiBord
                              .copyWith(
                                  color: Theme.of(context)
                                      .appColors
                                      .textSecondary700),
                          subTextStyle: Theme.of(context)
                              .appTexts
                              .textSmRegular
                              .copyWith(
                                  color: Theme.of(context)
                                      .appColors
                                      .textTeritory600),
                          bgColor: Colors.transparent,
                          bgHoverColor: Colors.transparent,
                          textColor:
                              Theme.of(context).appColors.textSecondary700,
                          context: context, onTap: () {
                        onChanged!(index);
                      }))),
          SizedBox(height: 12.0),
          AppTextField.main(
              controller: titleGroupController,
              labelText: 'Title of group *',
              keyboardType: TextInputType.text,
              placeHolder: 'Smith’s Friends',
              helpText: '',
              validator: (_) {})
        ]),
      );

  _bottonBtns(BuildContext context) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 110,
              child: AppButton.buttonIcon(AppIconName.arrowLeft,
                  context: context,
                  text: 'Go back',
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  bgColor: Colors.transparent,
                  bgHoverColor: Colors.transparent,
                  textColor: Theme.of(context).appColors.fgSecondary700,
                  border: Border.all(
                      color: Theme.of(context).appColors.buttonSecondaryBorder,
                      width: 1), onTap: () {
                context.pop();
                context.pop();
              }),
            ),
            SizedBox(
              width: 170,
              child: AppButton.buttonPrimary(
                  context: context,
                  text: 'Confirm & Proceed',
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  onTap: () {
                    widget.ticketCount(ticketCount);
                    widget.selectedGroup(groups[selectedGroup]);
                    widget.groupTitle(titleGroupController.text);
                    context.pop();
                  }),
            ),
          ],
        ),
      );
}
