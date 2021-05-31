import 'package:flutter/material.dart';
import 'package:coffee_shop/model/product.dart';
import 'package:coffee_shop/services/my_color.dart';
import 'package:coffee_shop/widgets/discount_badge.dart';
import 'package:line_icons/line_icons.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;
  final bool isLarge;
  const ProductWidget({this.product, this.isLarge = false});
  @override
  Widget build(BuildContext context) {
    if (isLarge) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: InkWell(
          onTap: () {
            print('hi');
          },
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(2, 5),
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 4.0,
                      spreadRadius: 2.5)
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Stack(
                        children: [
                          Hero(
                            tag: product.imgPath,
                            child: Container(
                              height: 120.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image: AssetImage(product.imgPath),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          Positioned(
                              top: 0,
                              left: 0,
                              child: SizedBox(
                                height: 30.0,
                                width: 40.0,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.red[400],
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Text(
                                    '- ${product.discount.toString()}%',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w500),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                Text('price ',
                                    style: TextStyle(color: colorMuted)),
                                product.discount != 0
                                    ? Text(
                                        product.price.toString(),
                                        style: TextStyle(
                                            color: colorMuted,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      )
                                    : Text(''),
                                SizedBox(width: 3.0),
                                Text(
                                    '\$' +
                                        num.parse((product.price *
                                                    ((100 - product.discount) /
                                                        100))
                                                .toStringAsFixed(2))
                                            .toString(),
                                    style: TextStyle(
                                        color: colorPrimary,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                            SizedBox(height: 13.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: IconButton(
                                    onPressed: () {},
                                    padding: EdgeInsets.all(0.0),
                                    icon: Icon(
                                      LineIcons.heart,
                                      size: 20.0,
                                      color: Colors.red[500],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                SizedBox(
                                  height: 20.0,
                                  width: 20.0,
                                  child: Icon(
                                    LineIcons.star,
                                    size: 20.0,
                                    color: Colors.yellow[700],
                                  ),
                                ),
                                SizedBox(width: 3.0),
                                Text(
                                  product.star.toString(),
                                  style: TextStyle(fontSize: 16.0),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                primary: colorDark,
                                padding: EdgeInsets.all(5.0)),
                            child: Icon(
                              Icons.add,
                              size: 30.0,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
        child: InkWell(
          onTap: () {},
          child: Container(
            width: 150.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 4.0,
                    spreadRadius: 5.0)
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 270.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white),
                  ),
                  Hero(
                    tag: product.imgPath,
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          image: DecorationImage(
                              image: AssetImage(product.imgPath),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Positioned(
                      top: 5.0,
                      right: 5.0,
                      child: ClipOval(
                        child: Material(
                          color: colorDark,
                          child: InkWell(
                            splashColor: colorPrimary_medium,
                            child: SizedBox(
                              width: 30.0,
                              height: 30.0,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                      )),
                  product.discount != 0
                      ? DiscountBadge(
                          discount: product.discount.toString(),
                        )
                      : Text(''),
                  Positioned(
                    top: 150.0,
                    width: 150.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                              height: 40.0,
                              child: Text(product.title,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis)),
                          SizedBox(height: 5.0),
                          Row(
                            children: [
                              Text('price ',
                                  style: TextStyle(color: colorMuted)),
                              product.discount != 0
                                  ? Text(
                                      product.price.toString(),
                                      style: TextStyle(
                                          color: colorMuted,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    )
                                  : Text(''),
                              SizedBox(width: 3.0),
                              Text(
                                  '\$' +
                                      num.parse((product.price *
                                                  ((100 - product.discount) /
                                                      100))
                                              .toStringAsFixed(2))
                                          .toString(),
                                  style: TextStyle(
                                      color: colorPrimary,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 210.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 0.0),
                          width: 25.0,
                          child: IconButton(
                            icon: Icon(Icons.favorite_border,
                                color: Colors.red[400], size: 20.0),
                            onPressed: () {},
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 35.0,
                              child: IconButton(
                                icon: Icon(Icons.star_border,
                                    color: Colors.yellow[600], size: 20.0),
                                onPressed: () {},
                              ),
                            ),
                            Text(
                              product.star.toString(),
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
