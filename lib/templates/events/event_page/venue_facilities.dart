import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:billit_now/repositories/event/models/venue_facilities_model.dart';
import 'package:billit_now/templates/events/widgets/app_collapse.dart';
import 'package:flutter/material.dart';

class VenueFacilities extends BaseStatelessWidget {
  VenueFacilities({super.key, required this.data});

  final VenueFacilitiesModel data;

  @override
  Widget body(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title
          Text('Venue Facilities at ${data.name}',
              style: Theme.of(context)
                  .appTexts
                  .displayXsSemibold
                  .copyWith(color: Theme.of(context).appColors.textPrimary900)),
          // description
          Text(data.desc,
              style: Theme.of(context).appTexts.textMdRegular.copyWith(
                  color: Theme.of(context).appColors.textSecondary700)),
          // Collapse List
          ...List.generate(data.facilities.length, (int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: AppCollapse(
                  title: data.facilities[index].title,
                  children:
                      // Fasilities of Collapse
                      List.generate(data.facilities[index].facilities.length,
                          (int nestIndex) {
                    FacilityModel facilities =
                        data.facilities[index].facilities[nestIndex];
                    return Container(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppIcon.button(
                              appIconName: AppIconName(facilities.icon),
                              size: 24.0,
                              context: context),
                          Container(
                            padding: EdgeInsets.only(left: 12.0),
                            width: constraint.maxWidth - 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(facilities.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .appTexts
                                        .textMdSemiBold
                                        .copyWith(
                                            color: Theme.of(context)
                                                .appColors
                                                .textPrimary900)),
                                SizedBox(height: 4),
                                Text(facilities.desc,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .appTexts
                                        .textMdRegular
                                        .copyWith(
                                            color: Theme.of(context)
                                                .appColors
                                                .textTeritory600))
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  })),
            );
          })
        ],
      );
    });
  }
}
