import 'package:coffee_shop/screens/screens.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  NotificationScreen.routeName: (context) => NotificationScreen(),
  NotificationDetailScreen.routeName: (context) => NotificationDetailScreen(),
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
  NewPasswordScreen.routeName: (context) => NewPasswordScreen(),
  OrderScreen.routeName: (context) => OrderScreen(),
  GoogleMapScreen.routeName: (context) => GoogleMapScreen(),
  ChangePassword.routeName: (context) => ChangePassword(),
  EnterPassword.routeName: (context) => EnterPassword(),
  ContactUsScreen.routeName: (context) => ContactUsScreen(),
};
