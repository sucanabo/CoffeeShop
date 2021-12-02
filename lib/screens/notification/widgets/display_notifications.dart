import 'package:coffee_shop/screens/notification/widgets/notification_item.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class DisplayNotifications extends StatefulWidget {
  @override
  _DisplayNotificationsState createState() => _DisplayNotificationsState();
}

class _DisplayNotificationsState extends State<DisplayNotifications> {
  final databaseRef =
      FirebaseDatabase.instance.reference().child('notifications');

  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
      query: databaseRef,
      sort: (a, b) => b.value['created_at'].compareTo(a.value['created_at']),
      itemBuilder: (BuildContext context, DataSnapshot snapshot,
          Animation<double> animation, int index) {
        return NotificationItem(
          title: snapshot.value['title'],
          body: snapshot.value['body'],
        );
      },
    );
  }
}
