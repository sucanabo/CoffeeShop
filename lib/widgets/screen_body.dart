import 'package:flutter/material.dart';

class ScreenBody extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final bool isHomeScreen;
  const ScreenBody(
      {@required this.child,
      this.margin,
      this.padding,
      this.isHomeScreen = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isHomeScreen)
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Welcome to',
                    style: TextStyle(fontSize: 26.0, color: Colors.white)),
                Text('KOFEHOLIC',
                    style: TextStyle(
                        fontSize: 36.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        Expanded(
          child: Container(
            margin: margin,
            padding: padding,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                color: Colors.white),
            child: child,
          ),
        ),
      ],
    );
  }
}
