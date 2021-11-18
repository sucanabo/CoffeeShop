import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';
import 'widgets/body.dart';

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
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Sign in',
          ),
        ),
        child: Body());
  }
}
