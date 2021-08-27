import 'package:flutter/material.dart';

class PillButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final Color color;
  final double elevation;
  const PillButton(
      {@required this.child, @required this.onPressed, @required this.color, this.elevation = 0});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          primary: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
        child: child);
  }
}
