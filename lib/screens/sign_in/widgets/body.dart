import 'package:coffee_shop/screens/sign_up/sign_up_screen.dart';
import 'package:coffee_shop/screens/sign_in/widgets/sign_in_with.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';

import 'signin_form.dart';
import 'package:coffee_shop/values/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScreenBody(
          child: ListView(
        padding: EdgeInsets.all(getProportionateScreenWidth(20.0)),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Let\'s sign you in',
                style: TextStyle(
                    color: primaryColor,
                    fontSize: getProportionateScreenWidth(28.0),
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                child: Text(
                  'Welcome back, you have been missed.',
                  style: TextStyle(fontSize: 16.0, height: 1.5),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: 25.0),
          SignForm(),
          SizedBox(height: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Don\'t you have an account ?'),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignUpScreen.routeName);
                },
                style: TextButton.styleFrom(
                    alignment: Alignment.topCenter, padding: EdgeInsets.zero),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Sign up', style: TextStyle(color: primaryMediumColor)),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: primaryMediumColor,
                  )
                ]),
              )
            ],
          ),
          SignInWith()
        ],
      )),
    );
  }
}
