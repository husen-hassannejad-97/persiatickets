import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:billit_now/repositories/event/models/explore_pricing_model.dart';
import 'package:billit_now/templates/events/widgets/app_collapse.dart';
import 'package:flutter/material.dart';

class ExplorePricing extends BaseStatelessWidget {
  ExplorePricing({super.key, required this.data});

  final ExplorePricingModel data;

  @override
  Widget body(BuildContext context) {
    return AppCollapse(
        title: 'Explore Pricing and Seating for ${data.name}',
        children: [
          Text(data.desc,
              style: Theme.of(context).appTexts.textMdRegular.copyWith(
                  color: Theme.of(context).appColors.textSecondary700)),
          // Table
          Container(
            margin: const EdgeInsets.only(top: 24.0),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).appColors.borderSecondary,
                    width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder(
                  horizontalInside: BorderSide(
                      width: 1,
                      color: Theme.of(context).appColors.borderSecondary,
                      style: BorderStyle.solid)),
              children: [
                _tableRow('Section Name', 'Free Seats', 'Total Seats', 'Price',
                    style: Theme.of(context).appTexts.textXsSemibold.copyWith(
                        color: Theme.of(context).appColors.textQuaternary500),
                    bgColor: Theme.of(context).appColors.bgSecondary),
                ...List.generate(
                    data.sections.length,
                    (int index) => _tableRow(
                        data.sections[index].sectionName,
                        data.sections[index].freeSeatsCount.toString(),
                        data.sections[index].totalSeatsCount.toString(),
                        "\$${data.sections[index].startPrice} - \$${data.sections[index].endPrice}",
                        style: Theme.of(context)
                            .appTexts
                            .textSmRegular
                            .copyWith(
                                color: Theme.of(context)
                                    .appColors
                                    .textTeritory600)))
              ],
            ),
          ),
        ]);
  }

  TableRow _tableRow(
          String section, String freeSeats, String totalSeats, String price,
          {TextStyle? style, Color? bgColor}) =>
      TableRow(decoration: BoxDecoration(color: bgColor), children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
          child: Text(section, style: style),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
          child: Text(freeSeats, style: style),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
          child: Text(totalSeats, style: style),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
          child: Text(price, style: style),
        )
      ]);
}
