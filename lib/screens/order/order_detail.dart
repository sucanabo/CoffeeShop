import 'package:coffee_shop/models/models.dart';
import 'package:coffee_shop/providers/provider.dart';
import 'package:coffee_shop/services/services.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/values/values.dart';
import 'package:coffee_shop/widgets/divider_custom.dart';
import 'package:coffee_shop/widgets/loading.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
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
      appBar: AppBar(title: Text(LocaleKeys.order_detail.tr())),
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
                          textLeft: LocaleKeys.subtotal.tr(),
                          textRight:
                              '${convertVND(double.parse(widget.model.order.subtotal))}'),
                      _buildRow(
                          textLeft: LocaleKeys.shipping.tr(),
                          textRight:
                              '${convertVND(double.parse(widget.model.order.shipping))}'),
                      _buildRow(
                          textLeft: LocaleKeys.voucher_discount.tr(),
                          textRight:
                              '- ${convertVND(double.parse(widget.model.order.voucherDiscount))}'),
                      _buildRow(
                          textLeft: LocaleKeys.shipping_discount.tr(),
                          textRight:
                              '- ${convertVND(double.parse(widget.model.order.shippingDiscount))}'),
                      DividerCustom(
                        height: getHeight(15.0),
                      ),
                      _buildRow(
                          isLarge: true,
                          textLeft: LocaleKeys.order_total.tr(),
                          textRight:
                              '${convertVND(double.parse(widget.model.order.grandtotal))}'),
                      DividerCustom(
                        height: getHeight(15.0),
                      ),
                      _buildRow(
                          isLarge: true,
                          textLeft: LocaleKeys.payment_by.tr(),
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
                                Text(LocaleKeys.order_code.tr(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(height: 8.0),
                                Text(LocaleKeys.receiver_name.tr(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(height: 8.0),
                                Text(LocaleKeys.phone.tr(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(height: 8.0),
                                Text(LocaleKeys.address.tr(),
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

    String getAddOn(int productId, TransactionItemDetail itemDetail) {
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
            LocaleKeys.can_load_order_item.tr());
  }
}
