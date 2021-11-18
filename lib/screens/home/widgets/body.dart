import 'package:coffee_shop/providers/product_provider.dart';
import 'package:coffee_shop/screens/product/see_product_screen.dart';
import 'package:coffee_shop/widgets/haeding_underline.dart';
import 'package:coffee_shop/widgets/product.dart';
import 'package:coffee_shop/widgets/see_all_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_carousel.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    var newList = provider.newProducts(limit: 10);
    var saleList = provider.saleProducts(limit: 10);
    return ListView(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: SizedBox(
            height: 200.0,
            width: double.infinity,
            child: HomeCarousel(),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeadingUnderline(text: 'New'),
            SeeAllButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SeeProductScreen(
                          data: provider.newProducts(limit: 20),
                        )));
              },
            )
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: List.generate(newList.length,
                  (index) => ProductWidget(product: newList[index]))),
        ),
        SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeadingUnderline(text: 'Sale'),
            SeeAllButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SeeProductScreen(
                          data: provider.saleProducts(),
                        )));
              },
            )
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            child: Row(
                children: List.generate(saleList.length,
                    (index) => ProductWidget(product: saleList[index]))),
          ),
        ),
      ],
    );
  }
}
