import 'package:coffee_shop/values/color_theme.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String body;
  NotificationItem({this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
          color: AppColors.blackColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10.0)),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Center(
        child: ListTile(
          onTap: () {},
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image(
              image: AssetImage('assets/images/logo.png'),
            ),
          ),
          title: Text(title,
              maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(body,
              maxLines: 2, overflow: TextOverflow.ellipsis),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          trailing: Icon(Icons.close),
          dense: true,
        ),
      ),
    );
  }
}
