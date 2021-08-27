import 'package:coffee_shop/models/notification.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Notification'),
          centerTitle: true,
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
            Widget>[
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                color: Colors.grey[100]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: ListView(
                  children: notifications
                      .map((noti) => Container(
                            height: 70,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10.0)),
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Center(
                              child: ListTile(
                                onTap: () {},
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Image(
                                    image: AssetImage('assets/images/logo.jpg'),
                                  ),
                                ),
                                title: Text(noti.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                                subtitle: Text(noti.subTitle,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                trailing: Icon(Icons.close),
                                dense: true,
                              ),
                            ),
                          ))
                      .toList(),
                ))
              ],
            ),
          ))
        ]));
  }
}
