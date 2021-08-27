import 'package:coffee_shop/providers/product_provider.dart';
import 'package:coffee_shop/widgets/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
        builder: (_, products, __) => products.getFavouriteProducts.length == 0
            ? _buildEmptyProduct()
            : ListView.builder(
                padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                itemCount: products.getFavouriteProducts.length,
                itemBuilder: (context, index) => ProductWidget(
                  isLarge: true,
                  product: products.getFavouriteProducts[index],
                ),
              ));
  }

  Widget _buildEmptyProduct() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          'Your have not favourite any product yet.',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
