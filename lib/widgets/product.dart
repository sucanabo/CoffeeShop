import 'package:coffee_shop/models/product.dart';
import 'package:coffee_shop/providers/cart_provider.dart';
import 'package:coffee_shop/screens/product_detail/product_detail_screen.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:coffee_shop/widgets/discount_badge.dart';
import 'package:coffee_shop/widgets/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;
  final bool isLarge;
  const ProductWidget({this.product, this.isLarge = false});

  void _navigateToDetail(context) {
    Navigator.pushNamed(context, ProductDetailScreen.routeName,
        arguments: {'product_id': product.id});
  }

  void quickAddCart(CartProvider cart) {
    Map productExtend = {
      'options':
          product.options.isNotEmpty ? cart.setOptionDefault(product) : {},
      'toppings': [],
    };
    cart.addItem(product, quickAdd: true, productExtend: productExtend);
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    if (isLarge) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: InkWell(
          onTap: () {
            _navigateToDetail(context);
          },
          child: Column(children: [
            RoundedContainer(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Stack(
                          children: [
                            Hero(
                              tag: product.title,
                              child: Container(
                                  height: 135.0,
                                  width: 115.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image(
                                      gaplessPlayback: true,
                                      image:
                                          base64StringToImage(product.imgPath),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ),
                            product.discount != null && product.discount != 0
                                ? Positioned(
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
                                : SizedBox()
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              product.discount != 0
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(LocaleKeys.price.tr() + ' ',
                                                style: TextStyle(
                                                    color:
                                                        AppColors.mutedColor)),
                                            Text(
                                              convertVND(product.price),
                                              style: TextStyle(
                                                  color: AppColors.mutedColor,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          ],
                                        ),
                                        Text(
                                            convertVND(caculatePrice(
                                                price: product.price,
                                                discount: product.discount)),
                                            style: TextStyle(
                                                color: AppColors.primaryColor,
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.w600))
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Text(LocaleKeys.price.tr() + ' ',
                                            style: TextStyle(
                                                color: AppColors.mutedColor)),
                                        Text(
                                            convertVND(caculatePrice(
                                                price: product.price,
                                                discount: product.discount)),
                                            style: TextStyle(
                                                color: AppColors.primaryColor,
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                              SizedBox(height: 5.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: IconButton(
                                      onPressed: () {},
                                      padding: EdgeInsets.all(0.0),
                                      icon: product.selfFavourited
                                          ? Icon(
                                              LineIcons.heartAlt,
                                              size: 20.0,
                                              color: Colors.red[500],
                                            )
                                          : Icon(
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
                                    child: product.selfRating.star != 0
                                        ? Icon(
                                            LineIcons.starAlt,
                                            size: 20.0,
                                            color: Colors.yellow[700],
                                          )
                                        : Icon(
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
                              onPressed: () {
                                quickAddCart(cart);
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  primary: AppColors.darkColor,
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
              ),
            )
          ]),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
        child: InkWell(
          onTap: () {
            _navigateToDetail(context);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Container(
              width: getWidth(160),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4.0,
                      spreadRadius: 5.0)
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: <Widget>[
                        Container(
                          child: Hero(
                              tag: product.title,
                              child: Image(
                                image: base64StringToImage(product.imgPath),
                                fit: BoxFit.fitWidth,
                              )),
                        ),
                        Positioned(
                            top: 5.0,
                            right: 5.0,
                            child: ClipOval(
                              child: Material(
                                color: AppColors.darkColor,
                                child: InkWell(
                                  splashColor: AppColors.primaryMediumColor,
                                  child: SizedBox(
                                    width: 30.0,
                                    height: 30.0,
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onTap: () {
                                    quickAddCart(cart);
                                  },
                                ),
                              ),
                            )),
                        if (product.discount != 0)
                          DiscountBadge(
                            discount: product.discount.toString(),
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                              child: Text(product.title,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Text(LocaleKeys.price.tr() + ' ',
                                      style: TextStyle(
                                          color: AppColors.mutedColor)),
                                  if (product.discount != 0)
                                    Text(
                                      convertVND(product.price),
                                      style: TextStyle(
                                          color: AppColors.mutedColor,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                  if (product.discount == 0)
                                    Text(
                                        convertVND(caculatePrice(
                                            price: product.price,
                                            discount: product.discount)),
                                        style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w600))
                                ],
                              ),
                              if (product.discount != 0)
                                Text(
                                    convertVND(caculatePrice(
                                        price: product.price,
                                        discount: product.discount)),
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w600))
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 0.0),
                            width: 25.0,
                            child: Icon(Icons.favorite_border,
                                color: Colors.red[400], size: 20.0),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 35.0,
                                child: Icon(Icons.star_border,
                                    color: Colors.yellow[600], size: 20.0),
                              ),
                              Text(
                                product.star.toString(),
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
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
        ),
      );
    }
  }
}
