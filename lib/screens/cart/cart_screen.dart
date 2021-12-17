import 'package:coffee_shop/providers/provider.dart';
import 'package:coffee_shop/screens/cart/widgets/cart_bottom_sheet.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';
import './widgets/body.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class CartScreen extends StatefulWidget {
  static String routeName = '/cart';
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final CartProvider cart = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
        bottomSheet: cart.itemCount > 0 ? CartBottomSheet() : null,
        appBar: AppBar(
          title: Text(LocaleKeys.cart.tr()),
        ),
        body: Body());
  }
}
