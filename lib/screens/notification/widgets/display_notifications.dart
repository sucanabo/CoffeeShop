part of screens;

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
      defaultChild: Center(child: Loading()),
      itemBuilder: (BuildContext context, DataSnapshot snapshot,
          Animation<double> animation, int index) {
        return NotificationItem(
          title: snapshot.value['title'],
          body: snapshot.value['body'],
          onTap: () {
            Navigator.of(context).pushNamed(
              NotificationDetailScreen.routeName,
              arguments: NotificationViewModel(
                title: snapshot.value['title'],
                content: snapshot.value['body'],
                date: snapshot.value['created_at'],
                imgPath: snapshot.value['image'],
              ),
            );
          },
        );
      },
    );
  }
}
