import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';

class NotificationDetailScreen extends StatefulWidget {
  static String routeName = '/notification_detail';

  @override
  _NotificationDetailScreenState createState() =>
      _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mess = ModalRoute.of(context).settings.arguments;
    print('mess');
    print(mess);
    return ScreenBody(
        appBar: AppBar(title: Text('Notification')), child: Text('hi'));
  }
}
