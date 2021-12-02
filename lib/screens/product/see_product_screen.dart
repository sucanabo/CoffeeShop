import 'package:coffee_shop/widgets/product.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';

class SeeProductScreen extends StatelessWidget {
  const SeeProductScreen({this.data});
  final List<dynamic> data;
  @override
  Widget build(BuildContext context) {
    return ScreenBody(
      appBar: AppBar(
        title: Text('See all'),
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
