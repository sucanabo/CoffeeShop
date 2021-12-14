import 'package:coffee_shop/providers/auth_provider.dart';
import 'package:coffee_shop/services/user_service.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/values/api_end_point.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:coffee_shop/widgets/screen_body_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import './widgets/body.dart';

class AddressScreen extends StatefulWidget {
  static String routeName = '/address';
  final bool isChooseAddress;
  AddressScreen({this.isChooseAddress = false});
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  bool _loading;

  void retriveData() async {
    String result =
        await Provider.of<AuthProvider>(context, listen: false).fetAddresses();
    if (result != null) {
      if (result == unauthorized) {
        logout(context);
      } else {
        showMess(context: context, text: result);
      }
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    retriveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.your_address.tr()),
        ),
        body: _loading
            ? ScreenBodyLoading()
            : Body(
                isChooseAddress: widget.isChooseAddress,
              ));
  }
}
