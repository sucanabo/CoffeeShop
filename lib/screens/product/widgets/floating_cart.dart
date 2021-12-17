import 'package:coffee_shop/providers/provider.dart';
import 'package:coffee_shop/screens/cart/cart_screen.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/values/values.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';

class FloatingCart extends StatefulWidget {
  @override
  _FloatingCartState createState() => _FloatingCartState();
}

class _FloatingCartState extends State<FloatingCart>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this)
          ..repeat(reverse: true);
    _animation = Tween(begin: Offset(0, -0.1), end: Offset(0, 0.1))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.itemCount > 0) {
            return child;
          }
          return Container();
        },
        child: FloatingActionButton.extended(
            backgroundColor: AppColors.primaryLightColor,
            splashColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            icon: LineIcon.shoppingBasket(
              size: 20.0,
              color: AppColors.darkColor,
            ),
            label: Row(
              children: [
                Consumer<CartProvider>(
                  builder: (context, cart, child) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plural(LocaleKeys.product_item_args, cart.itemCount),
                          style: TextStyle(color: AppColors.textColor, fontSize: 12.0),
                        ),
                        Text('${convertVND(cart.totalAmount)}',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600))
                      ]),
                ),
                SizedBox(width: 10.0),
                LineIcon.arrowRight(
                  color: AppColors.textColor,
                  size: 15.0,
                )
              ],
            ),
            onPressed: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            }),
      ),
    );
  }
}
