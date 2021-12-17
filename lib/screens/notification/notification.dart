part of screens;

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
