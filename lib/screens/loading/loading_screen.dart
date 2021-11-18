import 'package:coffee_shop/models/api_response.dart';
import 'package:coffee_shop/providers/auth_provider.dart';
import 'package:coffee_shop/screens/main_body.dart';
import 'package:coffee_shop/screens/sign_in/sign_in_screen.dart';
import 'package:coffee_shop/services/user_service.dart';
import 'package:coffee_shop/values/api_end_point.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}
