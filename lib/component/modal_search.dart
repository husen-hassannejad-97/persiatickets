import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/app_text_field.dart';
import 'package:flutter/material.dart';

class ModalSearch extends StatelessWidget {
  final OverlayPortalController controller;
  final TextEditingController searchTextFieldController;
  final Function()? onDismiss;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final Widget child;
  final List<Map> serachResults;

  const ModalSearch._internal({
    super.key,
    required this.controller,
    required this.searchTextFieldController,
    required this.child,
    required this.serachResults,
    this.onDismiss,
    this.border,
    this.borderRadius,
  });

  factory ModalSearch.def({
    Key? key,
    required BuildContext context,
    required OverlayPortalController controller,
    required TextEditingController searchTextFieldController,
    required Widget child,
    required List<Map> serachResults,
    Function()? onDismiss,
    BoxBorder? border,
    BorderRadius? borderRadius,
  }) =>
      ModalSearch._internal(
        key: key,
        controller: controller,
        searchTextFieldController: searchTextFieldController,
        serachResults: serachResults,
        onDismiss: onDismiss,
        border: border ??
            Border.all(
              color: Theme.of(context).appColors.borderPrimary,
            ),
        borderRadius:
            borderRadius ?? const BorderRadius.all(Radius.circular(8.0)),
        child: child,
      );

  static final _link = LayerLink();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 40,
        width: 40,
        child: LayoutBuilder(
          builder: (context, limits) => OverlayPortal(
            controller: controller,
            overlayChildBuilder: (context) => Stack(
              children: [
                ModalBarrier(
                  onDismiss: onDismiss,
                ),
                CompositedTransformFollower(
                  link: _link,
                  offset: Offset(
                      MediaQuery.of(context).size.width > 1366
                          ? -800
                          : (-context.logicalWidth / 2),
                      35),
                  targetAnchor: Alignment.centerLeft,
                  child: Column(
                    children: [
                      SizedBox(
                        width: context.logicalWidth / 3,
                        child: AppTextField.main(
                          controller: searchTextFieldController,
                          keyboardType: TextInputType.text,
                          helpText: '',
                          placeHolder: 'Search by artists, events, and venues',
                          icon: AppIconName.ueb1dSearchLg,
                          iconColor: Theme.of(context).appColors.fgSecondary700,
                          iconSize: 10,
                          validator: (_) {
                            return null;
                          },
                        ),
                      ),
                      serachResults.isEmpty
                          ? Container(width: context.logicalWidth / 3)
                          : Container(
                              width: context.logicalWidth / 3,
                              height: 396,
                              decoration: BoxDecoration(
                                color: Theme.of(context).appColors.bgSecondary,
                                border: Border.all(
                                    color: Theme.of(context)
                                        .appColors
                                        .borderSecondary,
                                    width: 1),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context)
                                        .appColors
                                        .fgQuinary400
                                        .withOpacity(0.1),
                                    spreadRadius: 0,
                                    blurRadius: 10,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: ListView.builder(
                                  itemCount: serachResults.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, bottom: 3, top: 24),
                                          child: Text(
                                              serachResults[index]['category'],
                                              style: Theme.of(context)
                                                  .appTexts
                                                  .textSmSemiBord
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .appColors
                                                          .textSecondary700)),
                                        ),
                                        Divider(
                                          color: Theme.of(context)
                                              .appColors
                                              .borderPrimary,
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: serachResults[index]
                                                    ['items']
                                                .length,
                                            itemBuilder: (BuildContext context,
                                                int indedntIndex) {
                                              return _searchItem(
                                                  context: context,
                                                  image: serachResults[index]
                                                          ['items']
                                                      [indedntIndex]['icon'],
                                                  title: serachResults[index]
                                                          ['items']
                                                      [indedntIndex]['title'],
                                                  subTitle: serachResults[index]
                                                              ['items']
                                                          [indedntIndex]
                                                      ['subTitle']);
                                            })
                                      ],
                                    );
                                  })),
                    ],
                  ),
                ),
              ],
            ),
            child: CompositedTransformTarget(
              link: _link,
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  Widget _searchItem(
          {required BuildContext context,
          required String image,
          required String title,
          required String subTitle}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 14),
            child: CircleAvatar(
              backgroundImage: AssetImage(image),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: Theme.of(context).appTexts.textMdSemiBold.copyWith(
                      color: Theme.of(context).appColors.textPrimary900)),
              Text(subTitle,
                  style: Theme.of(context).appTexts.textMdRegular.copyWith(
                      color: Theme.of(context).appColors.textTeritory600))
            ],
          )
        ],
      );
}
