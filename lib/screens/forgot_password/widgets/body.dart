import 'package:coffee_shop/screens/sign_up/sign_up_screen.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:coffee_shop/widgets/sign_button.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ScreenBody(
      child: ListView(
        padding: EdgeInsets.all(getProportionateScreenWidth(20.0)),
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'Forgot Password',
              style: TextStyle(
                  color: primaryColor,
                  fontSize: getProportionateScreenWidth(28.0),
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'Please enter your email and we will\nsend you a link to return to your account',
              textAlign: TextAlign.center,
            )
          ]),
          SizedBox(height: SizeConfig.screenHeigh * 0.1),
          ForgotPassForm(),
          SizedBox(height: SizeConfig.screenHeigh * 0.1),
          SignButton(text: 'Continue', onSubmit: () {}),
          SizedBox(height: SizeConfig.screenHeigh * 0.1),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Don\'t you have an account ?'),
              TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, SignUpScreen.routeName);
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
        ],
      ),
    ));
  }
}

class ForgotPassForm extends StatefulWidget {
  ForgotPassForm({Key key}) : super(key: key);

  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  List<String> errors = [];
  String email;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                setState(() {
                  errors.add('Please enter your email');
                });
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(fontSize: 14.0),
            decoration: InputDecoration(
                helperText: 'Erorr',
                prefixIcon: LineIcon.user(
                  size: 26.0,
                  color: primaryMediumColor,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: 'Enter your email',
                labelText: 'Email'),
            textInputAction: TextInputAction.next,
          )
        ],
      ),
    );
  }
}
