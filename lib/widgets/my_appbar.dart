import 'package:coffee_shop/providers/auth_provider.dart';
import 'package:coffee_shop/providers/cart_provider.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        title: greeting(user.displayName ?? ' '),
        elevation: 0.0,
        backgroundColor:
            backgroundColor != null ? backgroundColor : Colors.transparent,
        actions: [
          _buildAcitonButton(
              icon: LineIcon.bell(
                color: AppColors.primaryColor,
              ),
              onPress: () => Navigator.pushNamed(context, '/notification')),
          Consumer<CartProvider>(
              builder: (context, provider, child) => _buildAcitonButton(
                  quantity: provider.itemCount,
                  icon: LineIcon.shoppingBasket(
                    color: AppColors.primaryColor,
                  ),
                  onPress: () => Navigator.pushNamed(context, '/cart')))
        ], systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
    );
  }

  Widget _buildAcitonButton({Function onPress, Icon icon, int quantity = 0}) {
    return Align(
      child: Container(
        margin: const EdgeInsets.only(right: 10.0),
        height: 40.0,
        width: 40.0,
        child: Stack(
          children: [
            ElevatedButton(
              onPressed: onPress,
              child: icon,
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.white,
                  shape: CircleBorder(),
                  padding: const EdgeInsets.all(0.0)),
            ),
            if (quantity > 0)
              Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.redColor,
                          borderRadius: BorderRadius.circular(50.0)),
                      height: 13,
                      width: 13,
                      child: Center(
                          child: Text(
                        quantity.toString(),
                        style: TextStyle(
                            fontSize: 10, color: AppColors.whiteColor),
                      ))))
          ],
        ),
      ),
    );
  }
}
