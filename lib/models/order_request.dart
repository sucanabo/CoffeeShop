part of models;

class OrderRequestModel {
  OrderRequestModel(
      {this.addressId,
      this.deliveryMethod,
      this.shipping,
      this.subtotal,
      this.voucherDiscount,
      this.shippingDiscount,
      this.promo,
      this.grandtotal,
      this.content,
      this.items,
      this.firebaseToken});
  int addressId;
  String deliveryMethod;
  double shipping;
  double subtotal;
  double voucherDiscount;
  double shippingDiscount;
  String promo;
  double grandtotal;
  String content;
  List<CartItemModel> items;
  String firebaseToken;

  Map toJson() => {
        "token": firebaseToken,
        "address_id": addressId,
        "delivery_method": deliveryMethod,
        "shipping": shipping,
        "subtotal": subtotal,
        "voucher_discount": voucherDiscount,
        "shipping_discount": shippingDiscount,
        "promo": promo ?? " ",
        "grandtotal": grandtotal,
        "content": content ?? " ",
        "items": itemToJson()
      };
  List<Map<String, dynamic>> itemToJson() => items
      .map((item) => {
            'product_id': item.product.id,
            'quantity': item.quantity,
            'price': item.price,
            'content': item.message,
            'item_detail': ItemDetail(
                    options: item.productExtend['options'].entries
                        .map((element) => element.value['option_id'] as int)
                        .toList(),
                    toppings: item.productExtend['toppings']
                        .map((element) => element['topping_id'] as int)
                        .toList())
                .itemDetailToJson()
          })
      .toList();
}

class ItemDetail {
  ItemDetail({this.options, this.toppings});
  final List options;
  final List toppings;
  Map itemDetailToJson() => {'options': options, 'toppings': toppings};
}
