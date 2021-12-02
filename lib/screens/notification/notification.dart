import 'package:coffee_shop/screens/notification/widgets/display_notifications.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  static String routeName = '/notification';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Notification'),
          centerTitle: true,
        ),
        body: ScreenBody(child: DisplayNotifications()));
  }
}
