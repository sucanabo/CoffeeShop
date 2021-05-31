import 'package:coffee_shop/pages/cart.dart';
import 'package:coffee_shop/pages/product.dart';
import 'package:coffee_shop/pages/register.dart';
import 'package:coffee_shop/pages/voucher.dart';
import 'package:coffee_shop/services/my_color.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop/pages/home.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:coffee_shop/widgets/menu/my_drawer.dart';
import 'package:coffee_shop/pages/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedPage = 0;
  final _pageOption = [Home(), Voucher(), Product(), Cart()];
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/home': (context) => Home(),
      },
      home: Scaffold(
        body: _pageOption[selectedPage],
        key: _scaffoldKey,
        drawer: MyDrawer(),
        appBar: AppBar(
          brightness: Brightness.dark,
          elevation: 0.0,
          backgroundColor: colorPrimary,
          leading: GestureDetector(
            onTap: () => _scaffoldKey.currentState.openDrawer(),
            child: Container(
                padding: const EdgeInsets.only(left: 14),
                child: SvgPicture.asset('assets/images/icon/menu.svg')),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorDark,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SvgPicture.asset(
                          'assets/images/icon/notification.svg'),
                    )),
              ),
            )
          ],
        ),
        bottomNavigationBar: ConvexAppBar(
          initialActiveIndex: 0,
          backgroundColor: colorDark,
          activeColor: colorPrimary,
          onTap: (int index) => {
            setState(() {
              selectedPage = index;
            })
          },
          items: [
            TabItem(icon: Icon(Icons.home_outlined, color: Colors.white)),
            TabItem(icon: Icon(Icons.note_outlined, color: Colors.white)),
            TabItem(
                icon: Icon(Icons.free_breakfast_outlined, color: Colors.white)),
            TabItem(
                icon:
                    Icon(Icons.shopping_basket_outlined, color: Colors.white)),
            TabItem(icon: Icon(Icons.more_horiz_outlined, color: Colors.white)),
          ],
        ),
      ),
      theme: ThemeData(
        primaryColor: colorPrimary,
        scaffoldBackgroundColor: colorPrimary,
        bottomAppBarColor: colorPrimary,
      ),
      color: colorDark,
    );
  }
}
