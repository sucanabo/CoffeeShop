import 'package:coffee_shop/providers/cart_provider.dart';
import 'package:coffee_shop/screens/main_body.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:provider/provider.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key key}) : super(key: key);
  buttonClick(BuildContext context) async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MainBody()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Thank you'),
          centerTitle: true,
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  child: Container(
                padding: const EdgeInsets.only(
                    bottom: 60.0, left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                    color: Colors.grey[100]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage('assets/images/Success.gif'),
                      height: 200.0,
                    ),
                    Text(
                      'Successfull',
                      style: TextStyle(
                          fontSize: 26.0,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Your payment was done successfully.',
                      style:
                          TextStyle(fontSize: 16.0, color: AppColors.textColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30.0),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            primary: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0))),
                        onPressed: () => buttonClick(context),
                        child: Text('OK'))
                  ],
                ),
              ))
            ]));
  }
}
