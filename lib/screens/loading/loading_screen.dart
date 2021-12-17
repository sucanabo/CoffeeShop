part of screens;

class LoadingScreen extends StatefulWidget {
  static String routeName = '/loading';
  const LoadingScreen({Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void _loadUserInfo() async {
    String token = await getToken();

    if (token == '') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SignInScreen()),
          (route) => false);
    } else {
      ApiResponse response = await getUserInformation();
      if (response.error == null) {
        Provider.of<AuthProvider>(context, listen: false)
            .setUser(response.data);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MainBody()),
            (route) => false);
      } else if (response.error == unauthorized) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SignInScreen()),
            (route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SignInScreen()),
            (route) => false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${response.error}')));
      }
    }
  }

  @override
  void initState() {
    _loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Image.asset(
          Res.logo,
          width: SizeConfig.screenWidth * 0.3,
          fit: BoxFit.fitWidth,
        )),
      ),
    );
  }
}
