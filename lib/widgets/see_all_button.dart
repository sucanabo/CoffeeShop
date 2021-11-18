import 'package:flutter/material.dart';
import 'package:coffee_shop/values/color_theme.dart';
class SeeAllButton extends StatelessWidget {
  const SeeAllButton({@required this.onPressed});
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextButton(
      onPressed: onPressed,
      child: Text(
        'See all',
        style: TextStyle(color: AppColors.primaryColor),
      ),
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: AppColors.primaryColor),
            ),
          )),
    ));
  }
}
