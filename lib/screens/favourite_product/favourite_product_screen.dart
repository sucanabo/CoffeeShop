import 'package:coffee_shop/models/api_response.dart';
import 'package:coffee_shop/providers/product_provider.dart';
import 'package:coffee_shop/services/product_service.dart';
import 'package:coffee_shop/services/user_service.dart';
import 'package:coffee_shop/values/api_end_point.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widgets/body.dart';

class FavouriteProductScreen extends StatefulWidget {
  static String routeName = '/favourite_product';
  @override
  _FavouriteProductScreenState createState() => _FavouriteProductScreenState();
}

class _FavouriteProductScreenState extends State<FavouriteProductScreen> {
  Future<void> _retriveData() async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    ApiResponse products = await getProducts();
    if (products.error == null) {
      productProvider.setProductList(products.data);
    } else if (products.error == unauthorized ||
        products.error == unauthorized) {
       logout(context);
    }
    productProvider.setLoading(false);
  }

  @override
  void initState() {
    _retriveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your favourite product'),
          centerTitle: true,
        ),
        body: Consumer<ProductProvider>(
            builder: (_, products, __) => ScreenBody(
                  child: products.isLoading
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                        )
                      : Body(),
                )));
  }
}
