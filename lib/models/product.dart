import 'package:coffee_shop/models/rating.dart';

class ProductModel {
  int id;
  int cateId;
  double price;
  String title;
  String content;
  String imgPath;
  int discount;
  double star;
  bool selfFavourited;
  dynamic selfRating;
  dynamic options;
  dynamic toppings;
  ProductModel(
      {this.id,
      this.cateId,
      this.price,
      this.imgPath,
      this.content,
      this.title,
      this.discount = 0,
      this.star,
      this.selfFavourited,
      this.selfRating,
      this.options,
      this.toppings});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        cateId: json['category_id'],
        title: json['title'],
        content: json['content'],
        imgPath: json['image'],
        star: json['avgRating'] != null ? double.parse(json['avgRating']) : 0,
        options: json['options'],
        toppings: json['product_toppings'],
        selfFavourited: json['favourites'].length > 0,
        selfRating: json['selfRating'] != null
            ? RatingModel(
                star: json['selfRating']['star'],
                review: json['selfRating']['review'])
            : RatingModel(),
        price: double.parse(
          json['price'],
        ),
        discount: json['discount'].length > 0
            ? json['discount']
                .fold(0, (pre, index) => pre + index['discount'])
            : 0
            );
  }
}