import 'package:billit_now/core/localization/languages.dart';
import 'package:billit_now/core/localization/layout_direction.dart';
import 'package:flutter/cupertino.dart';

extension on List<Widget> {
  applyLayoutDirection(LayoutDirection layoutDirection) {
    if(layoutDirection == LayoutDirection.rtl) {
      reversed.toList();
    }
  }
}

extension PersianNumberStringExtension on String {
  String toNumberString(Language language) {
    if(language == Language.de || language == Language.en_us) {
      return this;
    }
    const persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    return replaceAllMapped(RegExp(r'\d'), (match) {
      final number = int.parse(match.group(0)!); // Extract the matched digit
      return persianDigits[number]; // Replace with Persian equivalent
    });
  }
}

extension NumberIntExtension on int {
  /// Converts the integer to a Persian string representation with Persian digits.
  String toNumberString(Language language) {
    if(language == Language.de || language == Language.en_us) {
      return toString();
    }
    const persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    final numberString = toString();
    return numberString.split('').map((char) {
      final digit = int.tryParse(char);
      if (digit != null) {
        return persianDigits[digit];
      } else {
        return char;
      }
    }).join();
  }
}