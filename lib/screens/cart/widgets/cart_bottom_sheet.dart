import 'package:coffee_shop/providers/cart_provider.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeigh * 0.08,
      decoration: BoxDecoration(
          color: AppColors.darkColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Consumer<CartProvider>(
              builder: (context, cart, child) => Text(
                    'Subtotal: ${convertVND(cart.totalAmount)}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: AppColors.primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            onPressed: () => Navigator.pushNamed(context, '/checkout'),
            child: Text(
              'Checkout',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
