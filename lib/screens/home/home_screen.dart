import 'package:coffee_shop/models/api_response.dart';
import 'package:coffee_shop/providers/category_provider.dart';
import 'package:coffee_shop/providers/product_provider.dart';
import 'package:coffee_shop/services/category_service.dart';
import 'package:coffee_shop/services/product_service.dart';
import 'package:coffee_shop/services/user_service.dart';
import 'package:coffee_shop/widgets/loading.dart';
import 'package:coffee_shop/widgets/my_appbar.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widgets/body.dart';
import '../../values/api_end_point.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//Get all product and category
  Future<void> retriveData() async {
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    if (productProvider.isLoading == true) {
      ApiResponse productResponse = await getProducts();
      ApiResponse categoryResponse = await getCategories();

      if (productResponse.error == null && categoryResponse.error == null) {
        productProvider.setProductList(productResponse.data);
        categoryProvider.setCategoryList(categoryResponse.data);
      } else if (categoryResponse.error == unauthorized ||
          productResponse.error == unauthorized) {
        logout(context);
      }
      productProvider.setLoading(false);
    }
  }

  @override
  void initState() {
    retriveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          appBar: AppBar(),
        ),
        body: ScreenBody(
            isHomeScreen: true,
            padding: EdgeInsets.all(20.0),
            child: Consumer<ProductProvider>(
              builder: (context, provider, child) =>
                  provider.isLoading ? Center(child: Loading()) : Body(),
            )));
  }
}
