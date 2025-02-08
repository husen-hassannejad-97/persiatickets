import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/empty_modal.dart';
import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:billit_now/features/base/base_stateless_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Footer extends BaseStatefulWidget {
  Footer(
      {super.key,
      required this.buttons,
      });

  final List<Map<String, String>> buttons;

  @override
  State<StatefulWidget> createState() => _FooterState();

}

class _FooterState extends BaseWidgetState<Footer> {

  @override
  bool allowRTLDirectionality() => true;

  @override
  void onVisible(BuildContext context) {
    if (kDebugMode) {
      print("Footer is Visible");
    }
  }

  @override
  void onInvisible(BuildContext context) {
    if (kDebugMode) {
      print("Footer is InVisible");
    }
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: context.logicalWidth),
      color: Theme.of(context).appColors.bgPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 32),
      child: context.isRegularSmartphoneOrLess
          ? _footerColumn(context)
          : _footerRow(context),
    );
  }

  Widget _footerRow(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          AppIcon.logo(
            appIconName: AppIconName.logoFullLTR,
            context: context,
            size: 30,
          ),
          // center btns
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Wrap(
                  alignment: WrapAlignment.center,
                  children: List.generate(
                      widget.buttons.length,
                      (index) => SizedBox(
                            // find a better way to have equal width
                            width: widget.buttons[index]['title']!.length <= 10
                                ? 100
                                : widget.buttons[index]['title']!.length * 10,
                            child: AppButton.buttonTertiary(
                                text: widget.buttons[index]['title']!,
                                context: context,
                                bgHoverColor: Colors.transparent,
                                onTap: () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return EmptyModal.show(
                                            context: context);
                                      },
                                    )
                                // widget.buttons[index]['link']!
                                ),
                          ))),
            ),
          ),

          // copyright
          Text(
            '© 2024 Persia Tickets',
            style: Theme.of(context)
                .appTexts
                .textMdRegular
                .copyWith(color: Theme.of(context).appColors.textTeritory600),
          )
        ],
      );
  Widget _footerColumn(BuildContext context) => SizedBox(
        width: context.logicalWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            AppIcon.logo(
              appIconName: AppIconName.logoFullLTR,
              context: context,
              size: 30,
            ),
            // center btns
            Container(
              width: 300,
              height: 200,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 4.0,
                  ),
                  itemCount: widget.buttons.length,
                  itemBuilder: (context, index) => AppButton.buttonTertiary(
                      text: widget.buttons[index]['title']!,
                      align: MainAxisAlignment.start,
                      context: context,
                      bgHoverColor: Colors.transparent,
                      onTap: () => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EmptyModal.show(context: context);
                            },
                          )
                      //widget.buttons[index]['link']!
                      )),
            ),

            // copyright
            Text(
              '© 2024 Persia Tickets',
              style: Theme.of(context)
                  .appTexts
                  .textMdRegular
                  .copyWith(color: Theme.of(context).appColors.textTeritory600),
            )
          ],
        ),
      );
}
