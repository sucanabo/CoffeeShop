import 'package:coffee_shop/screens/sign_in/widgets/sign_in_with.dart';
import 'package:coffee_shop/screens/sign_up/sign_up_screen.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:flutter/material.dart';

import 'signin_form.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Let\'s sign you in',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: getWidth(28.0),
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
        ),
        SignForm(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
                  Text('Sign up',
                      style: TextStyle(color: AppColors.primaryMediumColor)),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.primaryMediumColor,
                  )
                ]),
              ),
            ],
          ),
        ),
        SignInWith()
      ],
    );
  }
}
