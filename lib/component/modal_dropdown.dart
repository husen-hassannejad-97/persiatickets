import 'package:billit_now/apps/helper/theme/app_dimensions_theme.dart';
import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/component/app_button.dart';
import 'package:billit_now/component/empty_modal.dart';
import 'package:billit_now/core/di/di_setup.dart';
import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:billit_now/repositories/event/models/lang_model.dart';
import 'package:flutter/material.dart';

import '../core/localization/languages.dart';
import '../core/localization/localize.dart';

class ModalDropDown extends BaseStatefulWidget {
  final OverlayPortalController controller;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final Offset offset;
  final List<Language> langs;
  final List<LangCurrencyModel> currencies;
  final Function(LangCurrencyModel) onChangeLang;
  final Function(LangCurrencyModel) onChangeCurrency;

  const ModalDropDown._internal({
    super.key,
    required this.controller,
    this.border,
    this.borderRadius,
    required this.offset,
    required this.langs,
    required this.currencies,
    required this.onChangeLang,
    required this.onChangeCurrency,
  });

  factory ModalDropDown.langCurrency({
    Key? key,
    required BuildContext context,
    required OverlayPortalController controller,
    BoxBorder? border,
    BorderRadius? borderRadius,
    Offset? offset,
    required Function(LangCurrencyModel) onChangeLang,
    required Function(LangCurrencyModel) onChangeCurrency,
  }) =>
      ModalDropDown._internal(
        key: key,
        controller: controller,
        border: border ??
            Border.all(
              color: Theme.of(context).appColors.borderPrimary,
            ),
        offset: offset ?? const Offset(-200, 35),
        borderRadius:
            borderRadius ?? const BorderRadius.all(Radius.circular(8.0)),
        langs: Language.values,
        currencies: [
          LangCurrencyModel(
              title: 'United States dollar', subTitle: 'USD - \$'),
          LangCurrencyModel(title: 'Euro', subTitle: 'EUR - €'),
          LangCurrencyModel(title: 'Turkish lira', subTitle: 'TRY - ₺'),
          LangCurrencyModel(title: 'Emirati dirham', subTitle: 'AED - د.إ'),
        ],
        onChangeLang: onChangeLang,
        onChangeCurrency: onChangeCurrency,
      );

  @override
  State<ModalDropDown> createState() => _ModalDropDownState();
}

class _ModalDropDownState extends BaseWidgetState<ModalDropDown> {
  static final _link = LayerLink();

  String btnTitle = '';

  @override
  initState() {
    super.initState();
    var indexOfSelectedLang = -1;
    for(int i = 0; i < Language.values.length; i++) {
      if(Language.values[i] == getIt<Localize>().selectedLanguage.value) {
        indexOfSelectedLang = i;
        break;
      }
    }
    if(indexOfSelectedLang != -1) {
      btnTitle =
      '${widget.langs[indexOfSelectedLang].title} / ${widget.currencies[0].subTitle.split('-').first}';
      _selectedLang = indexOfSelectedLang;
    }
  }

  @override
  Widget body(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: 135,
        child: LayoutBuilder(
          builder: (context, limits) => OverlayPortal(
            controller: widget.controller,
            overlayChildBuilder: (context) => Stack(
              children: [
                ModalBarrier(
                  onDismiss: () {
                    widget.controller.hide();
                  },
                ),
                CompositedTransformFollower(
                  link: _link,
                  offset: widget.offset,
                  targetAnchor: Alignment.centerLeft,
                  child: Container(
                      width: context.isRegularSmartphoneOrLess ? 320 : 480,
                      height: 396,
                      decoration: BoxDecoration(
                        color: Theme.of(context).appColors.bgSecondary,
                        border: Border.all(
                            color: Theme.of(context).appColors.borderSecondary,
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
                      child: DefaultTabController(
                        length: 2,
                        child: Scaffold(
                          backgroundColor:
                              Theme.of(context).appColors.bgSecondary,
                          appBar: AppBar(
                            backgroundColor:
                                Theme.of(context).appColors.bgSecondary,
                            toolbarHeight: 10,
                            bottom: TabBar(
                              dividerColor:
                                  Theme.of(context).appColors.fgQuinary400,
                              indicatorColor:
                                  Theme.of(context).appColors.fgBrandPrimaryAlt,
                              labelColor: Theme.of(context)
                                  .appColors
                                  .textBrandSecondary700,
                              unselectedLabelColor:
                                  Theme.of(context).appColors.textQuaternary500,
                              overlayColor:
                                  WidgetStateProperty.all(Colors.transparent),
                              automaticIndicatorColorAdjustment: true,
                              labelStyle:
                                  Theme.of(context).appTexts.textMdSemiBold,
                              unselectedLabelStyle:
                                  Theme.of(context).appTexts.textMdSemiBold,
                              tabs: [
                                Tab(text: getString("language_and_region")),
                                Tab(text: getString("currency"))
                              ],
                            ),
                          ),
                          body: TabBarView(
                            children: [
                              _tabBody(
                                  title: getString("change_a_language_and_region"),
                                  items: widget.langs.map((Language lang) {
                                    return LangCurrencyModel(
                                        title: lang.title,
                                        subTitle: lang.subTitle);
                                  }).toList(),
                                  groupValue: _selectedLang,
                                  onChanged: _handleLangValueChange,
                                  selectedIndex: _selectedLang,
                                  onTapApply: () {
                                    setState(() {
                                      btnTitle =
                                          '${widget.langs[_selectedLang].title} / ${widget.currencies[_selectedCurreny].subTitle.split('-').first}';
                                    });

                                    widget.onChangeLang(LangCurrencyModel(
                                        title:
                                            widget.langs[_selectedLang].title,
                                        subTitle: widget
                                            .langs[_selectedLang].subTitle));
                                    widget.onChangeCurrency(
                                        widget.currencies[_selectedCurreny]);
                                    widget.controller.hide();
                                  },
                                  onTapCancel: () {
                                    widget.controller.hide();
                                  }),
                              _tabBody(
                                  title: getString("change_a_currency"),
                                  items: widget.currencies,
                                  groupValue: _selectedCurreny,
                                  onChanged: _handleCurrenyValueChange,
                                  selectedIndex: _selectedCurreny,
                                  onTapApply: () {
                                    setState(() {
                                      btnTitle =
                                          '${widget.langs[_selectedLang].title} / ${widget.currencies[_selectedCurreny].subTitle.split('-').first}';
                                    });

                                    widget.onChangeLang(LangCurrencyModel(
                                        title:
                                        widget.langs[_selectedLang].title,
                                        subTitle: widget
                                            .langs[_selectedLang].subTitle));
                                    widget.onChangeCurrency(
                                        widget.currencies[_selectedCurreny]);
                                    widget.controller.hide();
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return EmptyModal.show(
                                            context: context);
                                      },
                                    );
                                  },
                                  onTapCancel: () {
                                    widget.controller.hide();
                                  }),
                            ],
                          ),
                        ),
                      )),
                ),
              ],
            ),
            child: CompositedTransformTarget(
              link: _link,
              child: AppButton.buttonTertiary(
                  text: btnTitle,
                  context: context,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  onTap: () {
                    widget.controller.toggle();
                  }),
            ),
          ),
        ),
      ),
    );
  }

  int _selectedLang = 0;
  int _selectedCurreny = 0;

  Widget _tabBody({
    required String title,
    required List<LangCurrencyModel> items,
    required groupValue,
    required int selectedIndex,
    required void Function(dynamic)? onChanged,
    required Function() onTapApply,
    required Function() onTapCancel,
  }) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 32, left: 24, right: 24, bottom: 20),
            child: Text(
              title,
              style: Theme.of(context)
                  .appTexts
                  .textLgSemiBold
                  .copyWith(color: Theme.of(context).appColors.textPrimary900),
            ),
          ),
          // radois btns
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                items[0] != null
                    ? Expanded(
                        child: AppButton.radio(
                            Radio(
                              value: 0,
                              activeColor:
                                  Theme.of(context).appColors.borderBrand,
                              groupValue: groupValue,
                              onChanged: onChanged,
                            ),
                            text: items[0].title,
                            subText: items[0].subTitle,
                            textStyle: Theme.of(context)
                                .appTexts
                                .textSmMedium
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
                            border: Border.all(
                                color: selectedIndex == 0
                                    ? Theme.of(context).appColors.borderBrand
                                    : Theme.of(context)
                                        .appColors
                                        .borderSecondary),
                            padding: const EdgeInsets.all(16),
                            bgColor: Colors.transparent,
                            bgHoverColor: Colors.transparent,
                            textColor:
                                Theme.of(context).appColors.textSecondary700,
                            context: context, onTap: () {
                          onChanged!(0);
                        }),
                      )
                    : Container(),
                items[1] != null
                    ? Expanded(
                        child: AppButton.radio(
                            Radio(
                              value: 1,
                              activeColor:
                                  Theme.of(context).appColors.borderBrand,
                              groupValue: groupValue,
                              onChanged: onChanged,
                            ),
                            text: items[1].title,
                            subText: items[1].subTitle,
                            textStyle: Theme.of(context)
                                .appTexts
                                .textSmMedium
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
                            border: Border.all(
                                color: selectedIndex == 1
                                    ? Theme.of(context).appColors.borderBrand
                                    : Theme.of(context)
                                        .appColors
                                        .borderSecondary),
                            padding: const EdgeInsets.all(16),
                            bgColor: Colors.transparent,
                            bgHoverColor: Colors.transparent,
                            textColor:
                                Theme.of(context).appColors.textSecondary700,
                            context: context, onTap: () {
                          onChanged!(1);
                        }),
                      )
                    : Container(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                items[2] != null
                    ? Expanded(
                        child: AppButton.radio(
                            Radio(
                              value: 2,
                              activeColor:
                                  Theme.of(context).appColors.borderBrand,
                              groupValue: groupValue,
                              onChanged: onChanged,
                            ),
                            text: items[2].title,
                            subText: items[2].subTitle,
                            textStyle: Theme.of(context)
                                .appTexts
                                .textSmMedium
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
                            border: Border.all(
                                color: selectedIndex == 2
                                    ? Theme.of(context).appColors.borderBrand
                                    : Theme.of(context)
                                        .appColors
                                        .borderSecondary),
                            padding: const EdgeInsets.all(16),
                            bgColor: Colors.transparent,
                            bgHoverColor: Colors.transparent,
                            textColor:
                                Theme.of(context).appColors.textSecondary700,
                            context: context, onTap: () {
                          onChanged!(2);
                        }),
                      )
                    : Container(),
                items[3] != null
                    ? Expanded(
                        child: AppButton.radio(
                            Radio(
                              value: 3,
                              activeColor:
                                  Theme.of(context).appColors.borderBrand,
                              groupValue: groupValue,
                              onChanged: onChanged,
                            ),
                            text: items[3].title,
                            subText: items[3].subTitle,
                            textStyle: Theme.of(context)
                                .appTexts
                                .textSmMedium
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
                            border: Border.all(
                                color: selectedIndex == 3
                                    ? Theme.of(context).appColors.borderBrand
                                    : Theme.of(context)
                                        .appColors
                                        .borderSecondary),
                            padding: const EdgeInsets.all(16),
                            bgColor: Colors.transparent,
                            bgHoverColor: Colors.transparent,
                            textColor:
                                Theme.of(context).appColors.textSecondary700,
                            context: context, onTap: () {
                          onChanged!(3);
                        }),
                      )
                    : Container()
              ],
            ),
          ),
          // botton btns
          Padding(
            padding:
                const EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 12),
            child: Row(
              children: [
                Expanded(
                  child: AppButton.buttonTertiary(
                      context: context,
                      text: getString("cancel"),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      border: Border.all(
                        color: Theme.of(context).appColors.borderPrimary,
                      ),
                      onTap: onTapCancel),
                ),
                Expanded(
                  child: AppButton.buttonPrimary(
                      context: context,
                      text: getString("apply"),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      onTap: onTapApply),
                )
              ],
            ),
          )
        ],
      );

  void _handleLangValueChange(dynamic value) {
    setState(() {
      _selectedLang = value ?? 0;
    });
  }

  void _handleCurrenyValueChange(dynamic value) {
    setState(() {
      _selectedCurreny = value ?? 0;
    });
  }
}
