part of screens;

class SignUpScreen extends StatefulWidget {
  static String routeName = '/sign_up';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final provider = Provider.of<FirebaseProvider>(context, listen: false);
        if (provider.user != null) {
          final User user = FirebaseAuth.instance.currentUser;
          user.delete();
          provider.clearUser();
        }
        return true;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              LocaleKeys.sign_up.tr(),
            ),
          ),
          body: SignUpBody()),
    );
  }
}
