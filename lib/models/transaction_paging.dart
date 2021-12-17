part of models;

TransactionPagingModel pagingModelFromJson(String str) =>
    TransactionPagingModel.fromJson(json.decode(str));

String pagingModelToJson(TransactionPagingModel data) =>
    json.encode(data.toJson());

class TransactionPagingModel {
  TransactionPagingModel({
    this.message,
    this.totalRow,
    this.limit,
    this.page,
    this.data,
  });

  final String message;
  final int totalRow;
  final String limit;
  final String page;
  final List<TransactionModel> data;

  factory TransactionPagingModel.fromJson(Map<String, dynamic> json) =>
      TransactionPagingModel(
        message: json["message"] == null ? null : json["message"],
        totalRow: json["totalRow"] == null ? null : json["totalRow"],
        data: json["data"] == null
            ? null
            : List<TransactionModel>.from(
                json["data"].map((x) => TransactionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "totalRow": totalRow == null ? null : totalRow,
        "limit": limit == null ? null : limit,
        "page": page == null ? null : page,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}



class Order {
  Order({
    this.id,
    this.tableNumber,
    this.staffId,
    this.userId,
    this.addressId,
    this.subtotal,
    this.voucherDiscount,
    this.shippingDiscount,
    this.shipping,
    this.promo,
    this.grandtotal,
    this.content,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.orderItems,
  });

  final int id;
  final dynamic tableNumber;
  final int staffId;
  final int userId;
  final int addressId;
  final String subtotal;
  final String voucherDiscount;
  final String shippingDiscount;
  final String shipping;
  final dynamic promo;
  final String grandtotal;
  final String content;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final AddressModel address;
  final List<OrderItem> orderItems;
  factory Order.fromJson(Map<String, dynamic> json) => Order(
      id: json["id"] == null ? null : json["id"],
      tableNumber: json["table_number"],
      staffId: json["staff_id"] == null ? null : json["staff_id"],
      userId: json["user_id"] == null ? null : json["user_id"],
      addressId: json["address_id"] == null ? null : json["address_id"],
      subtotal: json["subtotal"] == null ? null : json["subtotal"],
      voucherDiscount:
          json["voucher_discount"] == null ? null : json["voucher_discount"],
      shippingDiscount:
          json["shipping_discount"] == null ? null : json["shipping_discount"],
      shipping: json["shipping"] == null ? null : json["shipping"],
      promo: json["promo"],
      grandtotal: json["grandtotal"] == null ? null : json["grandtotal"],
      content: json["content"] == null ? null : json["content"],
      status: json["status"] == null ? null : json["status"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      orderItems: json["order_items"] == null
          ? null
          : List<OrderItem>.from(
              json["order_items"].map((x) => OrderItem.fromJson(x))),
      address: json["address"] == null
          ? null
          : AddressModel.fromJson(json["address"]));

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "table_number": tableNumber,
        "staff_id": staffId == null ? null : staffId,
        "user_id": userId == null ? null : userId,
        "address_id": addressId == null ? null : addressId,
        "subtotal": subtotal == null ? null : subtotal,
        "voucher_discount": voucherDiscount == null ? null : voucherDiscount,
        "shipping_discount": shippingDiscount == null ? null : shippingDiscount,
        "shipping": shipping == null ? null : shipping,
        "promo": promo,
        "grandtotal": grandtotal == null ? null : grandtotal,
        "content": content == null ? null : content,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class OrderItem {
  OrderItem({
    this.id,
    this.productId,
    this.itemDetail,
    this.orderId,
    this.quantity,
    this.price,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final int productId;
  final TransactionItemDetail itemDetail;
  final int orderId;
  final String price;
  final int quantity;
  final dynamic content;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"] == null ? null : json["id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        itemDetail: json["item_detail"] == null
            ? null
            : TransactionItemDetail.fromJson(jsonDecode(json["item_detail"])),
        orderId: json["order_id"] == null ? null : json["order_id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        price: json["price"] == null ? null : json["price"],
        content: json["content"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "product_id": productId == null ? null : productId,
        "item_detail": itemDetail == null ? null : itemDetail,
        "order_id": orderId == null ? null : orderId,
        "quantity": quantity == null ? null : quantity,
        "content": content,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class TransactionItemDetail {
  TransactionItemDetail({
    this.options,
    this.toppings,
  });

  final List<int> options;
  final List<int> toppings;

  factory TransactionItemDetail.fromJson(Map<String, dynamic> json) => TransactionItemDetail(
        options: json["options"] == null
            ? null
            : List<int>.from(json["options"].map((x) => x)),
        toppings: json["toppings"] == null
            ? null
            : List<int>.from(json["toppings"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "options":
            options == null ? null : List<dynamic>.from(options.map((x) => x)),
        "toppings": toppings == null
            ? null
            : List<dynamic>.from(toppings.map((x) => x)),
      };
}

class TransactionRequest {
  final int page;
  final int limit;
  final String status;
  TransactionRequest({this.page, this.limit, this.status});
  Map toJson() => {
        "page": page == null ? 1 : page,
        "limit": limit == null ? 10 : limit,
        "status": status == null ? "" : status,
      };
}
