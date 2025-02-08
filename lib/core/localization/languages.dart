import 'package:billit_now/core/localization/layout_direction.dart';

enum Language {
  en_us(
      layoutDirection: LayoutDirection.ltr,
      title: "English",
      subTitle: "United States"),
  ar(layoutDirection: LayoutDirection.rtl, title: "العربیة", subTitle: "العام"),
  de(
      layoutDirection: LayoutDirection.ltr,
      title: "Deutsch",
      subTitle: "Österreich"),
  fa(layoutDirection: LayoutDirection.rtl, title: "فارسی", subTitle: "ایران"),
  ;

  final LayoutDirection layoutDirection;
  final String title;
  final String subTitle;

  const Language({
    required this.layoutDirection,
    required this.title,
    required this.subTitle,
  });

  static bool hasValue(String value) {
    return indexOfValue(value) != -1;
  }

  static int indexOfValue(String value) {
    for(int i = 0; i < Language.values.length; i++) {
      if(Language.values[i].name() == value) {
        return i;
      }
    }
    return -1;
  }

  String name() {
    return toString().split('.')[1];
  }

}