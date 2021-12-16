import 'package:coffee_shop/values/color_theme.dart';
import 'package:flutter/material.dart';

class DiscountBadge extends StatelessWidget {
  final String discount;
  DiscountBadge({this.discount});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        left: 0,
        child: SizedBox(
          width: 40.0,
          height: 30.0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.redColor,
            ),
            child: Center(
              child: Text(
                '-' + discount + '%',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}
