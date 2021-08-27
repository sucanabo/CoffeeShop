import 'package:coffee_shop/screens/home/home_screen.dart';
import 'package:coffee_shop/screens/more/more_screen.dart';
import 'package:coffee_shop/screens/product/product_screen.dart';
import 'package:coffee_shop/screens/voucher/voucher_screen.dart';
import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _curentIndex = 0;
  List<Widget> _menuItems = [
    HomeScreen(),
    ProductScreen(),
    VoucherScreen(),
    MoreScreen()
  ];
  get menuItems => _menuItems;
  get currentIndex => _curentIndex;

  set currentIndex(int index) {
    _curentIndex = index;
    notifyListeners();
  }
  void redirectScreen(Widget screen){
    int index = -1;
    for (var item in _menuItems) {
      if(item.toString() == screen.toString()){
        index = _menuItems.indexOf(item);
        break;
      }
    }
    if(index != -1){
      currentIndex = index;
    }

  }
}
