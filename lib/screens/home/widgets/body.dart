import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/widgets/haeding_underline.dart';
import 'package:coffee_shop/widgets/product.dart';
import 'package:coffee_shop/widgets/see_all_button.dart';
import 'package:flutter/material.dart';

import 'home_carousel.dart';

class Body extends StatelessWidget {
  final List<dynamic> newProduct;
  Body({this.newProduct});
  @override
  Widget build(BuildContext context) {
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
        Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [HeadingUnderline(text: 'New'), SeeAllButton()],
            ),
            Container(
              height: 275.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: newProduct.map((product) {
                  return ProductWidget(product: product);
                }).toList(),
              ),
            )
          ],
        )),
        SizedBox(height: 15.0),
        Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HeadingUnderline(text: 'On Sale'),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See all',
                    style: TextStyle(color: primaryColor),
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: primaryColor),
                        ),
                      )),
                )
              ],
            ),
            // Container(
            //   height: 275.0,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: saleProduct.map((product) {
            //       return ProductWidget(product: product);
            //     }).toList(),
            //   ),
            // )
          ],
        )),
      ],
    );
  }
}
