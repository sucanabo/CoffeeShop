import 'package:coffee_shop/providers/auth_provider.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Text title;
  final AppBar appBar;
  final List<Widget> widgets;
  const MyAppBar(
      {Key key, this.backgroundColor, this.title, this.appBar, this.widgets})
      : super(key: key);

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).getUser;
    return PreferredSize(
      preferredSize: Size.fromHeight(100.0),
      child: AppBar(
        centerTitle: false,
        title: greeting(user.firstName),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor:
            backgroundColor != null ? backgroundColor : Colors.transparent,
        actions: <Widget>[
          _buildAcitonButton(
              icon: LineIcon.bell(
                color: primaryColor,
              ),
              onPress: () => Navigator.pushNamed(context, '/notification')),
          _buildAcitonButton(
              icon: LineIcon.shoppingBasket(
                color: primaryColor,
              ),
              onPress: () => Navigator.pushNamed(context, '/cart'))
        ],
      ),
    );
  }

  Widget _buildAcitonButton({Function onPress, Icon icon}) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      height: 40.0,
      width: 40.0,
      child: ElevatedButton(
        onPressed: onPress,
        child: icon,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: Colors.white,
            shape: CircleBorder(),
            padding: const EdgeInsets.all(0.0)),
      ),
    );
  }
}
