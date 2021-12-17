part of models;
class RatingModel {
  int star;
  String review;

  RatingModel({this.star = 0, this.review = ''});

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(star: json['star'], review: json['review']);
  }
}
