import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';

import './widgets/body.dart';
import 'package:easy_localization/easy_localization.dart';
class SearchScreen extends StatelessWidget {
  static String routeName = '/search';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.search_product.tr()),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
