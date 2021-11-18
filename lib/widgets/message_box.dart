import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/styles.dart';
import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  const MessageBox(
      {@required this.formKey,
      @required this.controller,
      this.maxLine,
      this.fillColor});
  final Key formKey;
  final TextEditingController controller;
  final int maxLine;
  final Color fillColor;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        controller: controller,
        maxLines: maxLine ?? 8,
        validator: (value) =>
            value.length > 255 ? 'Message length is 255 char.' : null,
        decoration: InputDecoration(
            filled: fillColor != null,
            fillColor: fillColor,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(10.0),
            hintStyle: TextStyle(
              fontSize: AppStyles.textSize14,
              color: AppColors.blackColor.withOpacity(0.6),
            ),
            hintText: "Enter your message to special request (not requied)."),
      ),
    );
  }
}
