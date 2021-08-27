import 'package:coffee_shop/values/color_theme.dart';
import 'package:flutter/material.dart';
import 'size_config.dart';

final otpInputDecoration = InputDecoration(
    contentPadding:
        EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15.0)),
    enabledBorder: otpOulineInputBorder(),
    focusedBorder: otpOulineInputBorder(),
    border: otpOulineInputBorder()
    );

OutlineInputBorder otpOulineInputBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: BorderSide(color: textColor),
      );
}
