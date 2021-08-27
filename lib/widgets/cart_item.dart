import 'package:coffee_shop/models/cart_item.dart';
import 'package:coffee_shop/screens/product_detail/product_detail_screen.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:coffee_shop/widgets/quantity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_shop/providers/cart_provider.dart';

class CartItem extends StatefulWidget {
  final CartItemModel item;
  const CartItem({@required this.item});

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  List<String> getOptions() {
    Map itemOptions = widget.item.productExtend['options'];
    List<String> result = [];
    itemOptions.forEach((key, value) {
      String item = '$key(${value['option_title']})';
      result.add(item);
    });
    return result;
  }

  List<String> getToppings() {
    List itemToppings = widget.item.productExtend['toppings'];
    List<String> result = [];
    itemToppings.forEach((element) {
      String item = element['title'];
      result.add(item);
    });
    return result;
  }

  void editQuantity(int quantity) {
    CartItemModel instance = CartItemModel(
      key: widget.item.key,
      product: widget.item.product,
      productExtend: widget.item.productExtend,
      message: widget.item.message,
      quantity: quantity,
      price: quantity * widget.item.price / widget.item.quantity,
    );
    Provider.of<CartProvider>(context, listen: false).editItem(instance);
  }

  @override
  Widget build(BuildContext context) {
    List<String> options = getOptions();
    List<String> toppings = getToppings();
    print(widget.item.productExtend);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1.0,
                blurRadius: 2.0,
                offset: Offset(2, 2))
          ]),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, ProductDetailScreen.routeName,
              arguments: {
                'product_id': widget.item.product.id,
                'cart_key': widget.item.key
              });
        },
        splashColor: primaryLightColor,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: SizeConfig.screenWidth * 0.22,
                height: SizeConfig.screenWidth * 0.35,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image(
                        gaplessPlayback: true,
                        fit: BoxFit.cover,
                        image: base64StringToImage(
                            widget.item.product.imgPath))),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.product.title,
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: SizeConfig.screenWidth * 0.015,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Options: ',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  for (var item in options)
                                    Text(
                                      options.last == item ? item : '$item, ',
                                      style: TextStyle(fontSize: 12.0),
                                    )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Toppings: ',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  toppings.isNotEmpty
                                      ? Row(
                                          children: [
                                            for (var item in toppings)
                                              Text(
                                                toppings.last == item
                                                    ? item
                                                    : '$item, ',
                                                style:
                                                    TextStyle(fontSize: 12.0),
                                              ),
                                          ],
                                        )
                                      : Text(
                                          'no toping.',
                                          style: TextStyle(fontSize: 12.0),
                                        )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 8,
                              child: Text(
                                convertVND(widget.item.price),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: darkColor),
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Quantity(
                                  cicleStyle: true,
                                  initValue: widget.item.quantity,
                                  onChange: (value) {
                                    editQuantity(value);
                                  },
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
