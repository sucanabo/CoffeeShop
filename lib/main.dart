import 'package:coffee_shop/providers/auth_provider.dart';
import 'package:coffee_shop/providers/cart_provider.dart';
import 'package:coffee_shop/providers/category_provider.dart';
import 'package:coffee_shop/providers/navigation_provider.dart';
import 'package:coffee_shop/providers/product_provider.dart';
import 'package:coffee_shop/providers/voucher_provider.dart';
import 'package:coffee_shop/routes.dart';
import 'package:coffee_shop/screens/loading/loading_screen.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationProvider>(
            create: (_) => NavigationProvider()),
        ChangeNotifierProvider<ProductProvider>(
            create: (_) => ProductProvider()),
        ChangeNotifierProvider<CategoryProvider>(
            create: (_) => CategoryProvider()),
        ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<VoucherProvider>(
            create: (_) => VoucherProvider()),
      ],
      child: MaterialApp(
        initialRoute: LoadingScreen.routeName,
        routes: routes,
        theme: theme(),
        color: darkColor,
      ),
    );
  }
}
