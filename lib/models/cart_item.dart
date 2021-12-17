part of models;
class CartItemModel {
  final String key;
  final ProductModel product;
  final dynamic productExtend;
  final int quantity;
  final double price;
  final String message;

  CartItemModel(
      {this.key,
      @required this.product,
      @required this.quantity,
      @required this.price,
      @required this.productExtend,
      this.message});
}
enum CartItemAction {edit,delete}
