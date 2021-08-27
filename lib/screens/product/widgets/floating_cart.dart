import 'package:coffee_shop/providers/cart_provider.dart';
import 'package:coffee_shop/screens/cart/cart_screen.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/function.dart';
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
            backgroundColor: primaryLightColor,
            splashColor: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            icon: LineIcon.shoppingBasket(
              size: 20.0,
              color: darkColor,
            ),
            label: Row(
              children: [
                Consumer<CartProvider>(
                  builder: (context, cart, child) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${cart.itemCount.toString()} item${cart.itemCount > 1 ? 's' : ''}',
                          style: TextStyle(color: textColor, fontSize: 12.0),
                        ),
                        Text('${convertVND(cart.totalAmount)}',
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600))
                      ]),
                ),
                SizedBox(width: 10.0),
                LineIcon.arrowRight(
                  color: textColor,
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
