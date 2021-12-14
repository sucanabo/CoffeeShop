import 'package:coffee_shop/values/color_theme.dart';
import 'package:flutter/material.dart';

enum RoundedButtonType { normal, outline }

class RoundedButton extends StatelessWidget {
  final Function onPressed;
  final Color color;
  final String title;
  final Color textColor;
  final RoundedButtonType _buttonType;
  RoundedButton(
      {Key key, this.onPressed, this.color, this.title, this.textColor})
      : _buttonType = RoundedButtonType.normal,
        super(key: key);
  RoundedButton.outline(
      {Key key, this.onPressed, this.color, this.title, this.textColor})
      : _buttonType = RoundedButtonType.outline,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: _buttonType == RoundedButtonType.outline
                ? AppColors.transparentColor
                : color,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: _buttonType == RoundedButtonType.normal ? 0 : 1,
                    color: color ?? AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10.0))),
        child: Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w600)));
  }
}
