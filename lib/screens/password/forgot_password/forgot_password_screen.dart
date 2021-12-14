import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import './widgets/body.dart';
import 'package:easy_localization/easy_localization.dart';
class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = '/forgot_password';

  @override
  Widget build(BuildContext context) {
    final String phone = ModalRoute.of(context).settings.arguments as String;
    print(phone);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            LocaleKeys.forgot_password.tr(),
          ),
        ),
        body: Body(
          phone: phone,
        ));
  }
}
