import 'package:coffee_shop/providers/provider.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/widgets/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<dynamic> list =
        Provider.of<ProductProvider>(context, listen: false)
            .getFavouriteProducts;
    return Consumer<ProductProvider>(
        builder: (_, products, __) => list.length == 0
            ? _buildEmptyProduct()
            : ListView.builder(
                padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                itemCount: list.length,
                itemBuilder: (context, index) => ProductWidget(
                  isLarge: true,
                  product: list[index],
                ),
              ));
  }

  Widget _buildEmptyProduct() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          LocaleKeys.dont_have_favourite_yet.tr(),
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
