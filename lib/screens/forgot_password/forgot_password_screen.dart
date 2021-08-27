import 'package:flutter/material.dart';
import './widgets/body.dart';
class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = '/forgot_password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Forgot password',
          ),
        ),
        body: Body());
  }
}