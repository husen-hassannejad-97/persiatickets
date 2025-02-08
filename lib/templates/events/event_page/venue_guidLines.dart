import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:billit_now/repositories/event/models/venue_guidelines_model.dart';
import 'package:billit_now/templates/events/widgets/app_collapse.dart';
import 'package:flutter/material.dart';

class VenueGuidelines extends BaseStatelessWidget {
  VenueGuidelines({super.key, required this.data});

  final VenueGuidelinesModel data;

  @override
  Widget body(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return AppCollapse(
          title: 'Event and Venue Guidelines',
          children: List.generate(data.guides.length, (int index) {
            return Container(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppIcon.button(
                      appIconName: AppIconName(data.guides[index].icon),
                      color: Theme.of(context).appColors.mallard600,
                      size: 15.0,
                      context: context),
                  Container(
                    width: constraint.maxWidth - 50,
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(data.guides[index].desc,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .appTexts
                            .textMdRegular
                            .copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textSecondary700)),
                  )
                ],
              ),
            );
          }));
    });
  }
}
