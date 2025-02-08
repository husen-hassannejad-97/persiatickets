import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:billit_now/repositories/event/models/venue_location_model.dart';
import 'package:billit_now/templates/events/widgets/app_collapse.dart';
import 'package:billit_now/templates/events/widgets/app_map.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VenueLocation extends BaseStatelessWidget {
  VenueLocation({super.key, required this.data});

  final VenueLocationModel data;

  @override
  Widget body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Venue Location: ${data.name}',
            style: Theme.of(context)
                .appTexts
                .displayXsSemibold
                .copyWith(color: Theme.of(context).appColors.textPrimary900)),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: LayoutBuilder(builder: (context, constraint) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: constraint.maxWidth - 150,
                  child: Text(data.address,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).appTexts.textMdRegular.copyWith(
                          color: Theme.of(context).appColors.textSecondary700)),
                ),
                AppButton.buttonTertiary(
                    context: context,
                    text: 'Get directions',
                    textStyle: Theme.of(context).appTexts.textMdSemiBold,
                    bgColor: Colors.transparent,
                    bgHoverColor: Colors.transparent,
                    textColor:
                        Theme.of(context).appColors.buttonTeritoryColorFg,
                    onTap: () async {
                      await launchUrl(
                          Uri.parse(
                              'https://www.google.com/maps?q=${data.lat},${data.lon}'),
                          mode: LaunchMode.platformDefault);
                    })
              ],
            );
          }),
        ),
        // map
        Container(
          width: context.logicalWidth,
          height: context.logicalHeight / 3,
          padding: EdgeInsets.only(top: 24),
          child: AppMap(
            latitude: data.lat,
            longitude: data.lon,
          ),
        ),
        //overview
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: AppCollapse(title: 'Overview', children: [
            Text(data.overViewDesc,
                style: Theme.of(context).appTexts.textMdRegular.copyWith(
                    color: Theme.of(context).appColors.textSecondary700))
          ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Divider(
            color: Theme.of(context).appColors.borderPrimary.withOpacity(0.2),
            thickness: 1.0,
          ),
        ),
        //Getting here
        AppCollapse(
            title: 'Getting here',
            children: List.generate(
                data.gettingThereItems.length,
                (int index) => LayoutBuilder(builder: (context, constraint) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: LayoutBuilder(builder: (context, constraint) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: Text(data.gettingThereItems[index].title,
                                    style: Theme.of(context)
                                        .appTexts
                                        .textMdSemiBold
                                        .copyWith(
                                            color: Theme.of(context)
                                                .appColors
                                                .textSecondary700)),
                              ),
                              ...List.generate(
                                  data.gettingThereItems[index].items.length,
                                  (int nestIndex) => Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 3.0, left: 3.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 6.0),
                                              padding: EdgeInsets.all(2.0),
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .appColors
                                                      .textSecondary700,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                            ),
                                            SizedBox(
                                              width: constraint.maxWidth - 50,
                                              child: Text(
                                                  data.gettingThereItems[index]
                                                      .items[nestIndex],
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .appTexts
                                                      .textMdRegular
                                                      .copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .appColors
                                                              .textSecondary700)),
                                            ),
                                          ],
                                        ),
                                      ))
                            ],
                          );
                        }),
                      );
                    }))),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Divider(
            color: Theme.of(context).appColors.borderPrimary.withOpacity(0.2),
            thickness: 1.0,
          ),
        ),
        // Nearby Amenities
        AppCollapse(title: 'Nearby Amenities', children: [
          Text(data.nearbyAmenitiesDesc,
              style: Theme.of(context).appTexts.textMdRegular.copyWith(
                  color: Theme.of(context).appColors.textSecondary700))
        ]),
      ],
    );
  }
}
