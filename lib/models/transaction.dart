part of models;
class TransactionModel {
  TransactionModel({
    this.id,
    this.token,
    this.userId,
    this.orderId,
    this.code,
    this.type,
    this.mode,
    this.deliveryMethod,
    this.status,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.order,
  });

  final int id;
  final String token;
  final int userId;
  final int orderId;
  final String code;
  final String type;
  final String mode;
  final String deliveryMethod;
  final String status;
  final dynamic content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Order order;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"] == null ? null : json["id"],
        token: json["token"] == null ? null : json["token"],
        userId: json["user_id"] == null ? null : json["user_id"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        code: json["code"] == null ? null : json["code"],
        type: json["type"] == null ? null : json["type"],
        mode: json["mode"] == null ? null : json["mode"],
        deliveryMethod:
            json["delivery_method"] == null ? null : json["delivery_method"],
        status: json["status"] == null ? null : json["status"],
        content: json["content"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        order: json["order"] == null
            ? null
            : Order.fromJson(
                json["order"],
              ),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "token": token == null ? null : token,
        "user_id": userId == null ? null : userId,
        "order_id": orderId == null ? null : orderId,
        "code": code == null ? null : code,
        "type": type == null ? null : type,
        "mode": mode == null ? null : mode,
        "delivery_method": deliveryMethod == null ? null : deliveryMethod,
        "status": status == null ? null : status,
        "content": content,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "order": order == null ? null : order.toJson(),
      };
}