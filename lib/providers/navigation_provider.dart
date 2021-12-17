import 'package:coffee_shop/screens/home/home_screen.dart';
import 'package:coffee_shop/screens/more/more_screen.dart';
import 'package:coffee_shop/screens/product/product_screen.dart';
import 'package:coffee_shop/screens/voucher/voucher_screen.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/widgets/pop_up_notify.dart';
import 'package:coffee_shop/widgets/rounded_button.dart';
import 'package:easy_localization/easy_localization.dart';
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

  clear() {
    _curentIndex = 0;
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

  Future<bool> onWillPop(BuildContext context) async {
    if (currentIndex != 0) {
      setCurrentIndex(currentIndex - 1);
    } else {
      return (await showDialog(
              context: context,
              builder: (context) => new PopUpNotify(
                    title: LocaleKeys.are_your_sure.tr(),
                    content: Text(
                      LocaleKeys.exit_app.tr(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    actions: [
                      RoundedButton.outline(
                        title: LocaleKeys.no.tr(),
                        textColor: AppColors.primaryColor,
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      RoundedButton(
                        title: LocaleKeys.yes.tr(),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ))) ??
          false;
    }
    return false;
  }
}
