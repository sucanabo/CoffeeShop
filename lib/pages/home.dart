import 'package:coffee_shop/model/product.dart';
import 'package:coffee_shop/widgets/haeding_underline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop/services/my_color.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:coffee_shop/widgets/product.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<ProductModel> new_products = newProductList;
  final List<ProductModel> sale_products = saleProductList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Welcome to',
                  style: TextStyle(fontSize: 26.0, color: Colors.white)),
              Text('KOFEHOLIC',
                  style: TextStyle(
                      fontSize: 36.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                color: Colors.white),
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: SizedBox(
                    height: 200.0,
                    width: double.infinity,
                    child: Carousel(
                      dotBgColor: Colors.transparent,
                      indicatorBgPadding: 5.0,
                      dotIncreasedColor: colorPrimary_medium,
                      dotColor: Colors.grey[400],
                      dotPosition: DotPosition.bottomRight,
                      images: [
                        Image.asset(
                            'assets/images/banner/16280TheCoffeeHouse_1534905202.png',
                            fit: BoxFit.cover),
                        Image.asset(
                          'assets/images/banner/20200316_AppVinID_BannerWeb_TCH_25.jpg',
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          'assets/images/banner/20200316_AppVinID_BannerWeb_TCH_30k.jpg',
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
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
                      children: [
                        HeadingUnderline(text: 'New'),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'See all',
                            style: TextStyle(color: colorPrimary),
                          ),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(0)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: colorPrimary),
                                ),
                              )),
                        )
                      ],
                    ),
                    Container(
                      height: 275.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: new_products.map((product) {
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
                            style: TextStyle(color: colorPrimary),
                          ),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(0)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: colorPrimary),
                                ),
                              )),
                        )
                      ],
                    ),
                    Container(
                      height: 275.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: sale_products.map((product) {
                          return ProductWidget(product: product);
                        }).toList(),
                      ),
                    )
                  ],
                )),
              ],
            ),
          ),
        )
      ],
    );
  }
}
