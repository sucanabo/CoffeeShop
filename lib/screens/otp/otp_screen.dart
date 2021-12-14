import 'package:coffee_shop/models/user.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import './widgets/body.dart';

class OTPScreen extends StatelessWidget {
  static String routeName = '/otp';
  @override
  Widget build(BuildContext context) {
    final UserModel user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
           LocaleKeys.otp_verification.tr(),
          ),
        ),
        body: Body(user: user));
  }
}
