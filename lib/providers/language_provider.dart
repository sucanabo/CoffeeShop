import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  
  Locale _locale;
  Locale get locale => _locale;
  void setLocale(Locale locale) {}
  changeLanguage(BuildContext context, Locale locale) {
    context.setLocale(locale);
    notifyListeners();
  }
}
