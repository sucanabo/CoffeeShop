import 'package:coffee_shop/models/user.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:coffee_shop/widgets/pill_button.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import './otp_form.dart';
import 'package:flutter_otp/flutter_otp.dart';
import './otp_form_2.dart';
import 'package:flutter/material.dart';

FlutterOtp otp = FlutterOtp();

class Body extends StatefulWidget {
  final UserModel user;
  Body({this.user});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isResendOTP;
  @override
  void initState() {
    super.initState();
    _isResendOTP = false;
    print(widget.user);
    otp.sendOtp('0837695292', 'OTP is : 8888 ', 1000, 9999, '+84');
  }

  void submitOTP(String otpString) {
    print(otpString);
  }

  @override
  Widget build(BuildContext context) {
    String otpString = '';
    // print(widget.user.phone);
    return ScreenBody(
        child: ListView(
      padding: EdgeInsets.all(getProportionateScreenWidth(20.0)),
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            'OTP Verification',
            style: TextStyle(
                color: primaryColor,
                fontSize: getProportionateScreenWidth(28.0),
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: SizeConfig.screenHeigh * 0.025),
          Text('We sent your code to ${widget.user.phone}'),
          !_isResendOTP
              ? buildTimer()
              : Text(
                  'OTP code was expired.',
                  style: TextStyle(color: Colors.red[300]),
                ),
          SizedBox(height: SizeConfig.screenHeigh * 0.15),
          // OTPForm(),
          OTPForm2(onChange: (value) => otpString = value),
          SizedBox(height: SizeConfig.screenHeigh * 0.1),
          SizedBox(
            width: double.infinity,
            child: PillButton(
                child: Text('Continue'),
                onPressed: () => submitOTP(otpString),
                color: primaryColor),
          ),
          SizedBox(height: SizeConfig.screenHeigh * 0.1),
          TextButton(
              style: TextButton.styleFrom(onSurface: Colors.transparent),
              onPressed: () {
                setState(() {
                  _isResendOTP = false;
                });
              },
              child: Text(
                'Resend OTP',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 20.0,
                    color: Colors.grey),
              ))
        ]),
      ],
    ));
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('This code will expired in '),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0),
          duration: Duration(seconds: 30),
          builder: (context, value, child) => Text(
            '00:${value.toInt()}',
            style: TextStyle(color: Colors.red[300]),
          ),
          onEnd: () {
            setState(() {
              print('end');
              _isResendOTP = true;
              print(_isResendOTP);
            });
          },
        ),
      ],
    );
  }
}
