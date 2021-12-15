import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class Validate {
  static String passwordValidate(String pwd) {
    if (pwd.isEmpty || pwd == null || pwd == '') {
      return LocaleKeys.validate_enter_pwd.tr();
    }
    if (pwd.length < 6) return LocaleKeys.validate_least_6_char.tr();
    return null;
  }

  static String phoneValidate(String value) {
    if (value.trim().isEmpty ||
        value.trim() == '' ||
        value.trim().length == 0) {
      return LocaleKeys.validate_enter_phone.tr();
    }
    if (value.trim().length < 9 || value.trim().length > 11) {
      return LocaleKeys.validate_phone_char.tr();
    }
    return null;
  }

  static String notEmptyValidate(String value) {
    return value.trim().isEmpty ? LocaleKeys.validate_not_null.tr() : null;
  }

  static String reEnterPasswordValidate(String value, String value2) {
    if (value.trim().isEmpty) return LocaleKeys.validate_not_null.tr();

    if (value.trim().length < 6) return LocaleKeys.validate_least_6_char.tr();
    if (value.trim() != value2.trim())
      return LocaleKeys.validate_pwd_not_match.tr();
    return null;
  }

  static String emailValidate(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return LocaleKeys.validate_enter_valid_email.tr();
    else
      return null;
  }

  static String displayNameValidate(String value) {
    if (value.isEmpty)
      return LocaleKeys.validate_displayname_required.tr();
    else if (value.length > 16)
      return LocaleKeys.validate_displayname_length.tr();
    return null;
  }
}
