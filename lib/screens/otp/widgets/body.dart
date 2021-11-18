import 'dart:async';

import 'package:coffee_shop/models/user.dart';
import 'package:coffee_shop/screens/password/new_password/new_password_screen.dart';
import 'package:coffee_shop/services/firebase_auth.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:coffee_shop/widgets/pill_button.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:coffee_shop/widgets/screen_body_loading.dart';
import 'package:flutter/material.dart';

import 'otp_form.dart';

class Body extends StatefulWidget {
  final UserModel user;
  Body({this.user});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _loading = false;
  bool _buttonEnable = false;
  TextEditingController _otpController = TextEditingController();
  int secondCounter = 0;
  int defaultSecond = 60;
  Timer timer;
  @override
  void initState() {
    super.initState();
    startTimmer();
    sendOTP();
  }

  @override
  void dispose() { 
    timer.cancel();
     _otpController.dispose();
    super.dispose();
  }

  void sendOTP() {
    setState(() {
      _loading = true;
    });
    String convertPhone =
        widget.user.phone.toString().trim().replaceRange(0, 1, '+84');
    print(convertPhone);
    FireBaseAuthService.sendOTP(
      phoneNumber: convertPhone,
      verificationFailed: () {},
      codeSent: () {},
    );
    setState(() {
      setState(() {
        _loading = false;
      });
    });
  }

  void verifyOTP(String otp) {
    FireBaseAuthService.verifyOTP(
        otp: otp,
        verification: (type) {
          if (type == VerificationType.SUCCESS) {
            print("VerifyRegisterController - verifyOTP - SUCCESS");
            Navigator.pushNamed(context, NewPasswordScreen.routeName,
                arguments: widget.user);
          } else {
            print("VerifyRegisterController - verifyOTP - ERROR");
            //show error OTP invalid
          }
        });
  }

  void startTimmer() {
    secondCounter = defaultSecond;
    const onsec = Duration(seconds: 1);
    timer = Timer.periodic(onsec, (timer) {
      if (secondCounter == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          secondCounter--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBody(
        child: Container(
      padding: EdgeInsets.all(20.0),
      height: SizeConfig.screenHeigh,
      child: _loading
          ? ScreenBodyLoading()
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                  Column(
                    children: [
                      Text(
                        'OTP Verification',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: getWidth(28.0),
                            fontWeight: FontWeight.w600),
                      ),
                      Text('We sent your code to ${widget.user.phone}'),
                      SizedBox(height: getHeight(20.0)),
                      Text('Send OTP again in 00:$secondCounter second.'),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OTPForm(
                          otpController: _otpController,
                          onChanged: (value) {
                            setState(() {
                              _buttonEnable = value.length == 6;
                            });
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: PillButton(
                              child: Text(secondCounter != 0
                                  ? 'Continue'
                                  : 'Resend OTP'),
                              onPressed: () => secondCounter != 0
                                  ? _buttonEnable
                                      ? verifyOTP(_otpController.text)
                                      : null
                                  : startTimmer(),
                              color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ]),
    ));
  }
}