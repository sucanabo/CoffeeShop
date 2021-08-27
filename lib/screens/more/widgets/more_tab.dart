import 'package:coffee_shop/values/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icon.dart';

class MoreTab extends StatelessWidget {
  final String imgPath;
  final String title;
  final Function onPressed;
  MoreTab({this.imgPath, this.title, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        splashColor: primaryMediumColor,
        focusColor: primaryMediumColor,
        onTap: onPressed,
        child: Row(
          children: [
            SvgPicture.asset(
              imgPath,
              width: 20.0,
              height: 20.0,
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Text(title,
                  style:
                      (TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500))),
            ),
            LineIcon.arrowRight(
              color: primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
