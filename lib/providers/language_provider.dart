import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier{
  static final localizations = const<Locale>[
    Locale('en','US'),
    Locale('vi','VN'),
  ];
  changeLanguage(BuildContext context, Locale locale){
    context.setLocale(locale);
    notifyListeners();
  }
}