import 'package:coffee_shop/models/user.dart';
import 'package:flutter/material.dart';
import './widgets/body.dart';

class OTPScreen extends StatelessWidget {
  static String routeName = '/otp';

  @override
  Widget build(BuildContext context) {
    final UserModel user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'OTP Verification',
          ),
        ),
        body: Body(user: user));
  }
}
