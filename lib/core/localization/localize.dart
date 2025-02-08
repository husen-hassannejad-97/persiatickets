import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'languages.dart';

@injectable // TODO Check why it's not working with singleton
class Localize {

  Localize._();

  static final Localize _localize = Localize._();

  factory Localize() {
    return _localize;
  }

  static final Language _defaultLanguage = Language.en_us;
  static final String _languageKey = 'lang-key';
  final ValueNotifier<Language> selectedLanguage = ValueNotifier(_defaultLanguage);
  Map<String, dynamic> values = <String, dynamic>{};

  bool isLoadInternal() {
    return kIsWeb;
  }

  Future<void> setSelectedLanguage(Language language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, language.name());
    await initValues();
  }

  Future<Language> getSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final defaultLang = prefs.getString(_languageKey) ?? _defaultLanguage.name();
    final indexOfLang = Language.indexOfValue(defaultLang);
    if(indexOfLang == -1) {
      setSelectedLanguage(_defaultLanguage);
      return Future.value(Language.values[Language.values.indexOf(_defaultLanguage)]);
    }
    else {
      return Future.value(Language.values[indexOfLang]);
    }
  }

  Future<void> initValues() async {
    final selectedLang = await getSelectedLanguage();
    String jsonString = await rootBundle.loadString('assets/locales/${selectedLang.name()}.json');
    values = json.decode(jsonString) ?? <String, dynamic>{};
    selectedLanguage.value = selectedLang;
  }

}