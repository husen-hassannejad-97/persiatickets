import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/component/read_more_text.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:billit_now/repositories/event/models/info_faq_model.dart';
import 'package:billit_now/templates/events/widgets/app_collapse.dart';
import 'package:flutter/material.dart';

class InfoFAQ extends BaseStatelessWidget {
  InfoFAQ({super.key, required this.data});

  final InfoFaqModel data;

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        // descrition
        AppCollapse(title: 'Information and FAQ', children: [
          Text(data.desc,
              style: Theme.of(context).appTexts.textMdRegular.copyWith(
                  color: Theme.of(context).appColors.textSecondary700))
        ]),
        ...List.generate(data.faqs.length, (int index) {
          return Column(
            children: [
              index == 0
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Divider(
                        color: Theme.of(context)
                            .appColors
                            .borderPrimary
                            .withOpacity(0.5),
                        thickness: 1.0,
                      ),
                    ),
              AppCollapse(
                title: data.faqs[index].title,
                children: [
                  ReadMoreText(
                    text: data.faqs[index].desc,
                    trimLength: 450,
                    style: Theme.of(context).appTexts.textMdRegular.copyWith(
                        color: Theme.of(context).appColors.textSecondary700),
                    trimTextStyle: Theme.of(context)
                        .appTexts
                        .textMdSemiBold
                        .copyWith(
                            color:
                                Theme.of(context).appColors.buttonTeritoryFg),
                  ),
                  data.faqs[index].items == null
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(top: 12.0, left: 12.0),
                          child: Column(
                              children: List<Widget>.generate(
                                  data.faqs[index].items!.length,
                                  (int nestIndex) {
                            return Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(right: 5.0),
                                    padding: EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .appColors
                                            .textSecondary700,
                                        borderRadius:
                                            BorderRadius.circular(100))),
                                Text(
                                  data.faqs[index].items![nestIndex],
                                  style: Theme.of(context)
                                      .appTexts
                                      .textMdRegular
                                      .copyWith(
                                          color: Theme.of(context)
                                              .appColors
                                              .textSecondary700),
                                )
                              ],
                            );
                          })),
                        )
                ],
              ),
            ],
          );
        })
      ],
    );
  }
}
