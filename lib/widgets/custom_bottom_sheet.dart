import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:coffee_shop/widgets/close_bottom_sheet.dart';
import 'package:coffee_shop/widgets/pill_button.dart';
import 'package:flutter/material.dart';

Widget openBottomSheet(
    {@required context, @required Widget child, rewardPoint}) {
  return DraggableScrollableSheet(
    initialChildSize: 0.956,
    maxChildSize: 0.956,
    minChildSize: 0.85,
    builder: (_, controller) => ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          child: Container(
            height: SizeConfig.screenHeigh,
            child: SingleChildScrollView(
              controller: controller,
              child: child,
            ),
          ),
        ),
        Align(
            alignment: Alignment.topRight,
            child: CloseBottomSheet(context: context)),
        if (rewardPoint != null) _buildRewardBottom(rewardPoint)
      ]),
    ),
  );
}

Align _buildRewardBottom(rewardPoint) {
  return Align(
      alignment: Alignment.bottomCenter - Alignment(0, 0.05),
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(10.0)),
        width: SizeConfig.screenWidth * 0.9,
        height: SizeConfig.screenHeigh * 0.07,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Use $rewardPoint points ',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
                Text(
                  'to get this reward',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              width: SizeConfig.screenWidth * 0.3,
              child: PillButton(
                onPressed: () {},
                child: Text(
                  'Redeem',
                  style: TextStyle(color: primaryColor),
                ),
                elevation: 0,
                color: Colors.white,
              ),
            )
          ],
        ),
      ));
}
