import 'package:flutter/material.dart';
import 'widgets/body.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = '/sign_up';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Sign up',
          ),
        ),
        body: Body());
  }
}
