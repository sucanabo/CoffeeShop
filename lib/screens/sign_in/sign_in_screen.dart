import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';
import 'widgets/body.dart';
import 'package:easy_localization/easy_localization.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = '/sign_in';
  SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenBody(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            LocaleKeys.sign_in.tr(),
          ),
        ),
        child: Body());
  }
}
