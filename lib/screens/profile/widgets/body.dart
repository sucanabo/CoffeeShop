part of screens;
class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  String imPath;

  @override
  Widget build(BuildContext context) {
    return ScreenBody(
      appBar: AppBar(title: Text(LocaleKeys.update_profile.tr())),
      child: ListView(padding: EdgeInsets.all(20.0), children: [
        ProfileAvatar(onChanged: (value) {
          setState(() {
            imPath = value;
          });
        }),
        SizedBox(
          height: SizeConfig.screenHeigh * 0.05,
        ),
        ProfileForm(imgPath: imPath),
      ]),
    );
  }
}
