import 'package:coffee_shop/res.dart';
import 'package:coffee_shop/screens/sign_up/sign_up_screen.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:coffee_shop/values/validate.dart';
import 'package:coffee_shop/widgets/rounded_text_field.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:coffee_shop/widgets/sign_button.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ScreenBody(
      child: ListView(
        padding: EdgeInsets.all(getWidth(20.0)),
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'Forgot Password',
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: getWidth(28.0),
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
                  Text('Sign up',
                      style: TextStyle(color: AppColors.primaryMediumColor)),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.primaryMediumColor,
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
  TextEditingController _txtMail = TextEditingController();
  GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _fromKey,
      child: Column(
        children: [
          RoundedTextField(
            hintText: 'Enter your email',
            controller: _txtMail,
            prefixIcon: Res.ic_sms,
            validator: (value) => Validate.emailValidate(value),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
          )
        ],
      ),
    );
  }
}
