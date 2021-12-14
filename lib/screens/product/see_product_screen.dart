import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/widgets/product.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class SeeProductScreen extends StatelessWidget {
  const SeeProductScreen({this.data});
  final List<dynamic> data;
  @override
  Widget build(BuildContext context) {
    return ScreenBody(
      appBar: AppBar(
        title: Text(LocaleKeys.update_profile.tr()),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
              data.length,
              (index) => ProductWidget(
                    product: data[index],
                    isLarge: true,
                  )),
        ),
      ),
    );
  }
}
