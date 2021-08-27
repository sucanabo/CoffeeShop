import 'package:coffee_shop/models/cart_item.dart';
import 'package:coffee_shop/providers/cart_provider.dart';
import 'package:coffee_shop/providers/navigation_provider.dart';
import 'package:coffee_shop/screens/product/product_screen.dart';
import 'package:coffee_shop/screens/product_detail/product_detail_screen.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:coffee_shop/widgets/cart_item.dart';
import 'package:coffee_shop/widgets/hint.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  void onDissmissed(int index, CartItemAction action) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final cartItem = cart.items.values.toList()[index];
    switch (action) {
      case CartItemAction.edit:
        Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: {
          'product_id': cartItem.product.id,
          'cart_key': cartItem.key
        });
        break;
      case CartItemAction.delete:
        cart.removeItem(cartItem.key);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) => ScreenBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 20.0),
              child: Text(
                '${cart.itemCount} item${cart.itemCount > 1 ? 's' : ''}',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                  shadows: [Shadow(color: primaryColor, offset: Offset(0, -3))],
                  color: Colors.transparent,
                  decoration: TextDecoration.underline,
                  decorationColor: primaryColor,
                ),
              ),
            ),
            Hint(title: 'You can swipe item right to Edit or Delete.'),
            Expanded(
                child: cart.itemCount > 0
                    ? buildCartItem(context)
                    : buildGoShop()),
          ],
        ),
      ),
    );
  }

  Widget buildGoShop() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            'You don\'t have any item in cart :(',
            style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Container(
              width: SizeConfig.screenWidth * 0.5,
              height: SizeConfig.screenHeigh * 0.3,
              child: SvgPicture.asset(
                'assets/images/empty_cart.svg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Provider.of<NavigationProvider>(context, listen: false)
                        .redirectScreen(ProductScreen());
                  },
                  style: ElevatedButton.styleFrom(
                      primary: primaryMediumColor,
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 22.0)),
                  child: Text(
                    'GO SHOP NOW',
                    style: TextStyle(fontSize: 18.0),
                  )),
            ),
          )
        ],
      ),
    );
  }

  ListView buildCartItem(context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(height: 10.0);
        },
        itemCount: cartProvider.itemCount,
        padding: EdgeInsets.only(bottom: 80.0, left: 20.0, right: 20.0),
        itemBuilder: (context, index) => Slidable(
              key: Key(cartProvider.items.values
                  .toList()[index]
                  .product
                  .id
                  .toString()),
              dismissal: SlidableDismissal(
                child: SlidableDrawerDismissal(),
                onDismissed: (type) {
                  final action = CartItemAction.delete;
                  onDissmissed(index, action);
                },
              ),
              actionPane: SlidableDrawerActionPane(),
              child: Consumer<CartProvider>(
                  builder: (_, cart, __) =>
                      CartItem(item: cart.items.values.toList()[index])),
              actionExtentRatio: 0.2,
              secondaryActions: [
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: IconSlideAction(
                      onTap: () => onDissmissed(index, CartItemAction.edit),
                      caption: 'Edit',
                      color: primaryMediumColor,
                      icon: Icons.edit,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: IconSlideAction(
                        onTap: () => onDissmissed(index, CartItemAction.delete),
                        caption: 'Delete',
                        color: darkColor,
                        icon: Icons.delete),
                  ),
                )
              ],
            ));
  }
}
