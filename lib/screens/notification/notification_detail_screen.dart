part of screens;
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
    final data =
        ModalRoute.of(context).settings.arguments as NotificationViewModel;

    return ScreenBody(
      appBar: AppBar(title: Text(LocaleKeys.notification.tr())),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                image: base64StringToImage(data.imgPath),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeigh * 0.025,
            ),
            Text(
              data.title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeigh * 0.05,
            ),
            Text(
              LocaleKeys.desciption.tr(),
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              data.content,
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
