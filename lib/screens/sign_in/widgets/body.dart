import 'package:coffee_shop/screens/sign_in/widgets/sign_in_with.dart';
import 'package:coffee_shop/screens/sign_up/sign_up_screen.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'signin_form.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: ListView(
      shrinkWrap: true,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.hint_let_sign_in.tr(),
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: getWidth(28.0),
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              child: Text(
                LocaleKeys.welcome_back.tr(),
                style: TextStyle(fontSize: 16.0, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        SignForm(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(LocaleKeys.dont_have_account.tr()),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, SignUpScreen.routeName);
              },
              style: TextButton.styleFrom(
                  alignment: Alignment.topCenter, padding: EdgeInsets.zero),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(LocaleKeys.sign_up.tr(),
                    style: TextStyle(color: AppColors.primaryMediumColor)),
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.primaryMediumColor,
                )
              ]),
            ),
          ],
        ),
        SignInWith()
      ],
    ));
  }
}
