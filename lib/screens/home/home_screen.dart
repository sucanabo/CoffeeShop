import 'package:coffee_shop/models/api_response.dart';
import 'package:coffee_shop/screens/sign_in/sign_in_screen.dart';
import 'package:coffee_shop/services/product_service.dart';
import 'package:coffee_shop/services/user_service.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/widgets/my_appbar.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/body.dart';
import '../../constants.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _newList = [];
  bool _loading = true;

//Get all product and category
  Future<void> retriveData() async {
    ApiResponse newListResponse =
        await getProductWithCondition(condition: 'new', limit: 5);

    if (newListResponse.error == null) {
      setState(() {
        _loading = !_loading;
        _newList = newListResponse.data as List<dynamic>;
      });
    } else if (newListResponse.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => SignInScreen()),
                (route) => false)
          });
    }
  }

  @override
  void initState() {
    retriveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBar: AppBar(),
      ),
      body: ScreenBody(
          isHomeScreen: true,
          padding: EdgeInsets.all(20.0),
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor)),
                )
              : Body(
                  newProduct: _newList,
                )),
    );
  }
}
