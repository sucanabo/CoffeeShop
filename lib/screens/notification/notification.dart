import 'package:coffee_shop/screens/notification/widgets/display_notifications.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationScreen extends StatelessWidget {
  static String routeName = '/notification';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(LocaleKeys.notification.tr()),
          centerTitle: true,
        ),
        body: ScreenBody(child: DisplayNotifications()));
  }
}
