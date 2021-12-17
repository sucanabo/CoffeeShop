part of models;

class VoucherModel {
  final int id;
  final String title;
  final String content;
  final String couponCode;
  final String image;
  final String qrCode;
  final DateTime startDate;
  final DateTime expiryDate;
  final String discountUnit;
  final int discount;
  final String applyFor;
  final String displayApplyFor;
  final List discountObj;
  final int quantityRule;
  final int maxQuantity;
  final double priceRule;
  final double maxPrice;
  final String sizeRule;
  final String deliveryRule;
  final String locationRule;

  bool isUserUsed;

  VoucherModel({
    @required this.id,
    @required this.title,
    @required this.couponCode,
    @required this.qrCode,
    @required this.startDate,
    @required this.expiryDate,
    @required this.discountUnit,
    @required this.discount,
    @required this.applyFor,
    this.displayApplyFor,
    this.content,
    this.image,
    this.quantityRule,
    this.priceRule,
    this.isUserUsed,
    this.discountObj,
    this.locationRule,
    this.sizeRule,
    this.deliveryRule,
    this.maxQuantity,
    this.maxPrice,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      couponCode: json['user_code'] ?? json['coupon_code'],
      image: json['image'],
      qrCode: json['qr_code'],
      startDate: DateTime.parse(json['start_date']),
      expiryDate: DateTime.parse(json['expiry_date']),
      discountUnit: json['discount_unit'],
      discount: json['discount'] != null ? json['discount'] : 0,
      applyFor: json['apply_for'],
      displayApplyFor: _getDpApplyFor(json['apply_for']),
      maxQuantity: json['max_quantity'],
      quantityRule: json['quantity_rule'] != null ? json['quantity_rule'] : 0,
      maxPrice: json['max_price'] != null ? double.parse(json['max_price']) : 0,
      priceRule:
          json['price_rule'] != null ? double.parse(json['price_rule']) : 0,
      isUserUsed: json['status'] == 1,
      discountObj: json['discount_object'] != null
          ? json['discount_object']
              .split(',')
              .toList()
              .map((e) => int.parse(e))
              .toList()
          : null,
      locationRule: json['location_rule'],
      sizeRule: json['size_rule'],
      deliveryRule: json['delivery_rule'],
    );
  }
  static _getDpApplyFor(String str) {
    switch (str) {
      case 'order':
        return LocaleKeys.order.tr();
        break;

      case 'product':
        return LocaleKeys.product.tr();
        break;

      case 'category':
        return LocaleKeys.category.tr();
        break;

      case 'shipping':
        return LocaleKeys.shipping_type.tr();
        break;

      default:
        return str;
    }
  }
}
