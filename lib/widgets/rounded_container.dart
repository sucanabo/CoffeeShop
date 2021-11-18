import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const RoundedContainer({@required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
              offset: Offset(2, 5),
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 4.0,
              spreadRadius: 2.5)
        ],
      ),
      child: child,
    );
  }
}
