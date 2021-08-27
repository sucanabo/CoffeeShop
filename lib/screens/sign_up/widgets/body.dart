import 'package:coffee_shop/screens/sign_up/widgets/signup_form.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenBody(
        child: ListView(
      padding: EdgeInsets.all(getProportionateScreenWidth(20.0)),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Great to see you here!',
              style: TextStyle(
                  color: primaryColor,
                  fontSize: getProportionateScreenWidth(28.0),
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'Let’s set up your account in just a couple of steps.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.screenHeigh * 0.015,
        ),
        SignUpForm(),
        SizedBox(
          height: SizeConfig.screenHeigh * 0.015,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Already have account ?'),
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                  alignment: Alignment.topCenter, padding: EdgeInsets.zero),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Sign in', style: TextStyle(color: primaryMediumColor)),
                Icon(
                  Icons.chevron_right_rounded,
                  color: primaryMediumColor,
                )
              ]),
            )
          ],
        ),
      ],
    ));
  }
}
