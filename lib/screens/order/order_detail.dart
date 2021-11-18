import 'package:coffee_shop/models/api_response.dart';
import 'package:coffee_shop/models/product.dart';
import 'package:coffee_shop/models/transaction.dart';
import 'package:coffee_shop/providers/category_provider.dart';
import 'package:coffee_shop/providers/product_provider.dart';
import 'package:coffee_shop/services/category_service.dart';
import 'package:coffee_shop/services/product_service.dart';
import 'package:coffee_shop/services/user_service.dart';
import 'package:coffee_shop/values/api_end_point.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:coffee_shop/values/styles.dart';
import 'package:coffee_shop/widgets/divider_custom.dart';
import 'package:coffee_shop/widgets/loading.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({@required this.model});
  final TransactionModel model;

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  void initState() {
    super.initState();
    retriveData();
  }

  Future<void> retriveData() async {
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    if (productProvider.isLoading == true) {
      ApiResponse productResponse = await getProducts();
      ApiResponse categoryResponse = await getCategories();

      if (productResponse.error == null && categoryResponse.error == null) {
        productProvider.setProductList(productResponse.data);
        categoryProvider.setCategoryList(categoryResponse.data);
      } else if (categoryResponse.error == unauthorized ||
          productResponse.error == unauthorized) {
        logout(context);
      }
      productProvider.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBody(
      appBar: AppBar(title: Text('Order detail')),
      child: Consumer<ProductProvider>(builder: (_, provider, child) {
        return provider.isLoading
            ? Center(child: Loading())
            : SingleChildScrollView(
                child: Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(getHeight(15.0)),
                    border:
                        Border.all(width: 2, color: AppColors.primaryColor)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildOrderItem(),
                      DividerCustom(),
                      _buildRow(
                          textLeft: 'Subtotal',
                          textRight:
                              '${convertVND(double.parse(widget.model.order.subtotal))}'),
                      _buildRow(
                          textLeft: 'Shipping',
                          textRight:
                              '${convertVND(double.parse(widget.model.order.shipping))}'),
                      _buildRow(
                          textLeft: 'Voucher discount',
                          textRight:
                              '- ${convertVND(double.parse(widget.model.order.voucherDiscount))}'),
                      _buildRow(
                          textLeft: 'Shipping discount',
                          textRight:
                              '- ${convertVND(double.parse(widget.model.order.shippingDiscount))}'),
                      DividerCustom(
                        height: getHeight(15.0),
                      ),
                      _buildRow(
                          isLarge: true,
                          textLeft: 'Order total',
                          textRight:
                              '${convertVND(double.parse(widget.model.order.grandtotal))}'),
                      DividerCustom(
                        height: getHeight(15.0),
                      ),
                      _buildRow(
                          isLarge: true,
                          textLeft: 'Payment by',
                          textRight: '${widget.model.type.capitalize()}'),
                      DividerCustom(
                        height: 40.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Order code',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(height: 8.0),
                                Text('Name',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(height: 8.0),
                                Text('Phone',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(height: 8.0),
                                Text('Address',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${widget.model.code}',
                                    style: TextStyle(
                                        color: AppColors.darkColor,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(height: 8.0),
                                Text(
                                    '${widget.model.order.address.receiverName}'),
                                SizedBox(height: 8.0),
                                Text(
                                    '${widget.model.order.address.receiverPhone}'),
                                SizedBox(height: 8.0),
                                Text('${widget.model.order.address.address}'),
                              ],
                            ),
                          ),
                        ],
                      )
                    ]),
              ));
      }),
    );
  }

  Widget _buildRow({String textLeft, String textRight, bool isLarge = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          textLeft,
          style: isLarge
              ? TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600)
              : null,
        ),
        Text(textRight,
            style: isLarge
                ? TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600)
                : null)
      ],
    );
  }

  Widget _buildOrderItem() {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    ProductModel getProduct(int id) {
      return productProvider.getProductById(id);
    }

    String getAddOn(int productId, ItemDetail itemDetail) {
      final ProductModel product = getProduct(productId);

      String addOnStr = '';

      if (itemDetail.options != null) {
        itemDetail.options.forEach((element) {
          Map options = product.options;
          options.forEach((key, value) {
            final optionItem = value as List<dynamic>;

            optionItem.forEach((oi) {
              if (oi['option_id'] == element)
                addOnStr += '$key: ${oi['option_title']}';
            });
          });
        });
      }
      if (itemDetail.toppings != null) {
        itemDetail.toppings.forEach((element) {
          final toppingItem = product.toppings as List<dynamic>;
          toppingItem.forEach((oi) {
            if (oi['topping_id'] == element) addOnStr += '${oi['title']}';
          });
        });
      }

      return addOnStr;
    }

    final List<OrderItem> items = widget.model.order.orderItems;
    return items.length != 0
        ? Column(
            children: List.generate(
                items.length,
                (index) => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${items[index].quantity} x'),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${getProduct(items[index].productId).title}',
                                      style: TextStyle(
                                          fontSize: AppStyles.textSize15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                        '${getAddOn(items[index].productId, items[index].itemDetail)}'),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                                '${convertVND(double.parse(items[index].price))}')
                          ],
                        ),
                        SizedBox(
                          height: getHeight(15.0),
                        )
                      ],
                    )))
        : Text(
            'Can\'t load order items. Please contact us to slove this prolem.');
  }
}
