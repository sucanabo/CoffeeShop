import 'package:coffee_shop/screens/address/address_screen.dart';
import 'package:coffee_shop/screens/cart/cart_screen.dart';
import 'package:coffee_shop/screens/checkout/checkout_screen.dart';
import 'package:coffee_shop/screens/enter_code.dart';
import 'package:coffee_shop/screens/favourite_product/favourite_product_screen.dart';
import 'package:coffee_shop/screens/forgot_password/forgot_password_screen.dart';
import 'package:coffee_shop/screens/home/home_screen.dart';
import 'package:coffee_shop/screens/loading/loading_screen.dart';
import 'package:coffee_shop/screens/more/more_screen.dart';
import 'package:coffee_shop/screens/notification.dart';
import 'package:coffee_shop/screens/otp/otp_screen.dart';
import 'package:coffee_shop/screens/product_detail/product_detail_screen.dart';
import 'package:coffee_shop/screens/profile/profile_screen.dart';
import 'package:coffee_shop/screens/search/search_screen.dart';
import 'package:coffee_shop/screens/sign_in/sign_in_screen.dart';
import 'package:coffee_shop/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  '/notification': (context) => NotificationScreen(),
  'enterCode': (context) => EnterCodeScreen(),
  CheckoutScreen.routeName: (context) => CheckoutScreen(),
  SearchScreen.routeName: (context) => SearchScreen(),
  ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  LoadingScreen.routeName: (context) => LoadingScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  OTPScreen.routeName: (context) => OTPScreen(),
  MoreScreen.routeName: (context) => MoreScreen(),
  FavouriteProductScreen.routeName: (context) => FavouriteProductScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  AddressScreen.routeName: (context) => AddressScreen(),
};
