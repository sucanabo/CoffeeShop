import 'package:coffee_shop/providers/navigation_provider.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  List<Widget> _pageOption;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _pageOption =
        Provider.of<NavigationProvider>(context, listen: false).menuItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);
    return Scaffold(
      body: SafeArea(child: _pageOption[provider.currentIndex]),
      key: _scaffoldKey,
      bottomNavigationBar: CurvedNavigationBar(
        height: 60.0,
        index: provider.currentIndex,
        color: darkColor,
        buttonBackgroundColor: primaryColor,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (int index) {
          provider.currentIndex = index;
        },
        letIndexChange: (index) => true,
        items: [
          Icon(Icons.home_outlined, color: Colors.white),
          Icon(Icons.free_breakfast_outlined, color: Colors.white),
          Icon(Icons.note_outlined, color: Colors.white),
          Icon(Icons.more_horiz, color: Colors.white),
        ],
      ),
    );
  }
}
