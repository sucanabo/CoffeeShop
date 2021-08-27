import 'package:coffee_shop/services/google_service.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/widgets/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class SignInWith extends StatelessWidget {
  const SignInWith({
    Key key,
  }) : super(key: key);
  Future signinGoogle() async {
    print('google');
    await GoogleSignInApi.login();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PillButton(
          elevation: 1,
          color: Colors.white,
          onPressed: () => signinGoogle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LineIcon.googlePlusG(
                color: Colors.red[500],
                size: 30.0,
              ),
              Text(
                'Sign in with Google',
                style: TextStyle(color: textColor, fontSize: 16.0),
              ),
              LineIcon.arrowRight(
                color: textColor,
                size: 25.0,
              )
            ],
          ),
        ),
        SizedBox(height: 10.0),
        PillButton(
          elevation: 1,
          color: Colors.white,
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LineIcon.facebookF(
                color: Colors.blue[500],
                size: 25.0,
              ),
              Text(
                'Sign in with Facebook',
                style: TextStyle(color: textColor, fontSize: 16.0),
              ),
              LineIcon.arrowRight(
                color: textColor,
                size: 25.0,
              )
            ],
          ),
        ),
      ],
    );
  }
}
