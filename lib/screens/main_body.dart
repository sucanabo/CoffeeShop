import 'package:coffee_shop/providers/navigation_provider.dart';
import 'package:coffee_shop/providers/notification_provider.dart';
import 'package:coffee_shop/res.dart';
import 'package:coffee_shop/screens/notification/notification_detail_screen.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  List<Widget> _pageOption;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseNotifications firebaseNotifications = new FirebaseNotifications();

  @override
  void initState() {
    final naviProvider =
        Provider.of<NavigationProvider>(context, listen: false);
    _pageOption = naviProvider.menuItems;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      firebaseNotifications.setupFirebase(context);
    });
    listenNotifications();
    super.initState();
  }

  void listenNotifications() =>
      NotificationHandler.onNotifications.stream.listen(onClickNotification);
  void onClickNotification(String payload) => Navigator.of(context)
      .pushNamed(NotificationDetailScreen.routeName, arguments: payload);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context);
    return Scaffold(
      body: SafeArea(child: _pageOption[provider.currentIndex]),
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: CurvedNavigationBar(
        height: 60.0,
        index: provider.currentIndex,
        color: AppColors.darkColor,
        buttonBackgroundColor: AppColors.primaryColor,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (int index) {
          provider.setCurrentIndex(index);
        },
        letIndexChange: (index) => true,
        items: [
          SvgPicture.asset(
            Res.ic_home,
            color: AppColors.whiteColor,
          ),
          SvgPicture.asset(
            Res.ic_coffee,
            color: AppColors.whiteColor,
          ),
          SvgPicture.asset(
            Res.ic_voucher,
            color: AppColors.whiteColor,
          ),
          SvgPicture.asset(
            Res.ic_more,
            color: AppColors.whiteColor,
          )
        ],
      ),
    );
  }
}