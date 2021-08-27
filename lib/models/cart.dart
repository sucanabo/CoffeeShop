import 'package:coffee_shop/models/cart_item.dart';
class CartModel {
  final List<CartItemModel> items;
  final double subTotal;
  final double discount;
  final double shipping;
  final double orderTotal;
  CartModel(
      {this.items,
      this.orderTotal,
      this.shipping,
      this.subTotal,
      this.discount});
}
