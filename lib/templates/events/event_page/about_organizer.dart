import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/core/constants/app_constants.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:billit_now/repositories/event/models/about_organizer_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutOrganizer extends BaseStatelessWidget {
  AboutOrganizer({super.key, required this.data});

  final AboutOrganizerModel data;

  @override
  Widget body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Text(
            'About the Organizer',
            style: Theme.of(context)
                .appTexts
                .displayXsSemibold
                .copyWith(color: Theme.of(context).appColors.textPrimary900),
          ),
        ),
        // Profile
        Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).appColors.borderSecondary,
                    width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: context.isSmallTabletOrLess
                ? Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                          child: _organizerImage(data.organizerModel.organizerImage,
                              width: double.infinity, height: 200)),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24.0),
                          child: _organizerInfo(data, context))
                    ],
                  )
                : Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                          child: _organizerImage(data.organizerModel.organizerImage)),
                      Container(
                          width: context.logicalWidth / 2,
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24.0),
                          child: _organizerInfo(data, context))
                    ],
                  )),
        // Featured Singers
        Padding(
          padding: const EdgeInsets.only(top: 24.0, bottom: 16),
          child: Text(
            'Featured Singers',
            style: Theme.of(context)
                .appTexts
                .textLgSemiBold
                .copyWith(color: Theme.of(context).appColors.textPrimary900),
          ),
        ),
        _featureSigners(context, data.organizerModel.featuredSingers)
      ],
    );
  }

  _organizerImage(String img, {double? width, double? height}) =>
      img.contains(AppConstants.assetImagesDefaultPath)
          ? Image.asset(img, width: width, height: height, fit: BoxFit.cover)
          : Image.network(img, width: width, height: height, fit: BoxFit.cover);
  _organizerInfo(AboutOrganizerModel data, BuildContext context) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // name & socials
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // name
                Text(data.organizerModel.name,
                    style: Theme.of(context).appTexts.textLgSemiBold.copyWith(
                        color: Theme.of(context).appColors.textPrimary900)),
                // socials
                Row(
                  children: List.generate(
                      data.organizerModel.socials.length,
                      (int index) => AppButton.buttonIcon(
                              AppIconName(data.organizerModel.socials[index].icon),
                              iconSize: 20,
                              padding: EdgeInsets.only(left: 6.0),
                              bgColor: Colors.transparent,
                              bgHoverColor: Colors.transparent,
                              textColor: Colors.transparent,
                              context: context, onTap: () async {
                            await launchUrl(Uri.parse(data.organizerModel.socials[index].link),
                                mode: LaunchMode.platformDefault);
                          })),
                )
              ],
            ),
            // info
            //phone number
            RichText(
                text: TextSpan(
                    text: 'Phone number:\t',
                    style: Theme.of(context).appTexts.textMdRegular.copyWith(
                        color: Theme.of(context).appColors.textTeritory600),
                    children: [
                  TextSpan(
                      text: data.organizerModel.phoneNumber,
                      style: Theme.of(context).appTexts.textMdSemiBold.copyWith(
                          color: Theme.of(context).appColors.textSecondary700))
                ])),
            // Email Address
            RichText(
                text: TextSpan(
                    text: 'Email address:\t',
                    style: Theme.of(context).appTexts.textMdRegular.copyWith(
                        color: Theme.of(context).appColors.textTeritory600),
                    children: [
                  TextSpan(
                      text: data.organizerModel.emailAddress,
                      style: Theme.of(context).appTexts.textMdSemiBold.copyWith(
                          color: Theme.of(context).appColors.textSecondary700))
                ])),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Divider(
                color: Theme.of(context).appColors.borderPrimary,
                thickness: 1.0,
              ),
            ),
            // Organizer Company
            RichText(
                text: TextSpan(
                    text: 'Organizer company:\t',
                    style: Theme.of(context).appTexts.textMdRegular.copyWith(
                        color: Theme.of(context).appColors.textTeritory600),
                    children: [
                  TextSpan(
                      text: data.organizerModel.company,
                      style: Theme.of(context).appTexts.textMdSemiBold.copyWith(
                          color: Theme.of(context).appColors.textSecondary700))
                ])),
            // Office number
            RichText(
                text: TextSpan(
                    text: 'Office number:\t',
                    style: Theme.of(context).appTexts.textMdRegular.copyWith(
                        color: Theme.of(context).appColors.textTeritory600),
                    children: [
                  TextSpan(
                      text: data.organizerModel.officeNumber,
                      style: Theme.of(context).appTexts.textMdSemiBold.copyWith(
                          color: Theme.of(context).appColors.textSecondary700))
                ])),
            // address
            RichText(
                text: TextSpan(
                    text: 'Address:\t',
                    style: Theme.of(context).appTexts.textMdRegular.copyWith(
                        color: Theme.of(context).appColors.textTeritory600),
                    children: [
                  TextSpan(
                      text: data.organizerModel.address,
                      style: Theme.of(context).appTexts.textMdSemiBold.copyWith(
                          color: Theme.of(context).appColors.textSecondary700))
                ])),
          ]);

  _featureSigners(BuildContext context, List<SingerModel> singers) =>
      singers.isEmpty
          ? Container()
          : Column(
              children: [
                Row(children: [
                  singers[0] == null
                      ? Container()
                      : _singer(context, singers[0].image, singers[0].name),
                  singers[1] == null
                      ? Container()
                      : _singer(context, singers[1].image, singers[1].name),
                ]),
                SizedBox(height: 16.0),
                Row(children: [
                  singers[2] == null
                      ? Container()
                      : _singer(context, singers[2].image, singers[2].name),
                  singers[3] == null
                      ? Container()
                      : _singer(context, singers[3].image, singers[3].name),
                ])
              ],
            );

  _singer(BuildContext context, String img, String name) => Expanded(
        child: SizedBox(
          height: 40.0,
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: _organizerImage(img, width: 40, height: 40)),
              SizedBox(width: 12.0),
              Text(
                name,
                style: Theme.of(context).appTexts.textSmSemiBord.copyWith(
                    color: Theme.of(context).appColors.textPrimary900),
              )
            ],
          ),
        ),
      );
}
