part of providers;

class LanguageProvider extends ChangeNotifier {
  Locale _locale;
  Locale get locale => _locale;
  void setLocale(Locale locale) {}
  changeLanguage(BuildContext context, Locale locale) {
    context.setLocale(locale);
    
    notifyListeners();
  }
}
