import 'package:coffee_shop/values/color_theme.dart';
import 'package:flutter/material.dart';

class PillButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final Color color;
  final double elevation;
  const PillButton(
      {@required this.child, this.onPressed, this.color, this.elevation = 0});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          primary: color ?? AppColors.primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
        child: child);
  }
}
