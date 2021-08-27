import 'package:coffee_shop/values/styles.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:flutter/material.dart';

class OTPForm extends StatefulWidget {
  @override
  _OTPFormState createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  @override
  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: getProportionateScreenWidth(60),
            child: TextFormField(
              autofocus: true,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
              decoration: otpInputDecoration,
              onChanged: (value) => nextField(value, pin2FocusNode),
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(60),
            child: TextFormField(
              focusNode: pin2FocusNode,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
              decoration: otpInputDecoration,
              onChanged: (value) => nextField(value, pin3FocusNode),
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(60),
            child: TextFormField(
              focusNode: pin3FocusNode,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
              decoration: otpInputDecoration,
              onChanged: (value) => nextField(value, pin4FocusNode),
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(60),
            child: TextFormField(
              focusNode: pin4FocusNode,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
              decoration: otpInputDecoration,
              onChanged: (value) => pin4FocusNode.unfocus(),
            ),
          ),
        ],
      ),
    );
  }
}
