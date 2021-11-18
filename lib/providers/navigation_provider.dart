import 'package:coffee_shop/screens/home/home_screen.dart';
import 'package:coffee_shop/screens/more/more_screen.dart';
import 'package:coffee_shop/screens/product/product_screen.dart';
import 'package:coffee_shop/screens/voucher/voucher_screen.dart';
import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _curentIndex = 0;
  bool _loading = false;
  List<Widget> _menuItems = [
    HomeScreen(),
    ProductScreen(),
    VoucherScreen(),
    MoreScreen()
  ];
  get menuItems => _menuItems;
  get currentIndex => _curentIndex;
  get loading => _loading;

  setCurrentIndex(int index) {
    _curentIndex = index;
    notifyListeners();
  }

  void redirectScreen(Widget screen) {
    int index = -1;
    for (var item in _menuItems) {
      if (item.toString() == screen.toString()) {
        index = _menuItems.indexOf(item);
        break;
      }
    }
    if (index != -1) {
      setCurrentIndex(index);
    }
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
