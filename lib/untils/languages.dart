import 'package:flutter/cupertino.dart';

class Languages {
  Languages._();
  static const vi = Locale('vi', 'VN');
  static const en = Locale('en', 'US');
  static final localizations = const <Locale>[
    Locale('vi', 'VN'),
    Locale('en', 'US'),
  ];
  static String getFlag(String code) {
    switch (code) {
      case 'en':
        return '🇺🇸';
      case 'vi':
        return '🇻🇳';
      default:
        return '🇻🇳';
    }
  }
}
