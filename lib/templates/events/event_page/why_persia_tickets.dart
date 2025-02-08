import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:billit_now/repositories/event/models/why_persia_tickets_model.dart';
import 'package:flutter/material.dart';

class WhyPersiaTickets extends BaseStatelessWidget {
  WhyPersiaTickets({super.key, required this.whysList});

  final List<WhyPersiaTicketsModel> whysList;

  @override
  Widget body(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return SizedBox(
        width: constraint.maxWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Why Persia Tickets',
                style: Theme.of(context).appTexts.displayXsSemibold.copyWith(
                    color: Theme.of(context).appColors.textPrimary900)),
            ...List.generate(
                whysList.length,
                (int index) => Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // FIXME Have to load from url
                          // AppIcon.img(
                          //     appIconName: whysList[index].icon,
                          //     color: Theme.of(context).appColors.mallard600,
                          //     size: 24,
                          //     context: context),
                          SizedBox(width: 12.0),
                          SizedBox(
                            width: constraint.maxWidth - 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(whysList[index].title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .appTexts
                                        .textMdSemiBold
                                        .copyWith(
                                            color: Theme.of(context)
                                                .appColors
                                                .textPrimary900)),
                                SizedBox(height: 4.0),
                                Text(whysList[index].desc,
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
                    ))
          ],
        ),
      );
    });
  }
}
