import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:flutter/material.dart';

class DividerCustom extends StatelessWidget {
  const DividerCustom({this.height});
  final double height;
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height != null ? height * 2 : getHeight(20),
      color: AppColors.blackColor.withOpacity(0.12),
      thickness: 1,
    );
  }
}
