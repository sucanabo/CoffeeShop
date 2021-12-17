part of models;
class RewardModel {
  int id;
  int point;
  String title;
  String content;
  DateTime expiryDate;
  DateTime startDate;
  String brandName;
  String image;
  int exchangeCount;
  RewardModel({
    this.id,
    this.point,
    this.title,
    this.content,
    this.image,
    this.brandName,
    this.exchangeCount
  });
  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      id: json['id'],
      point: json['point'],
      title: json['title'],
      content: json['content'],
      image: json['image'],
      brandName: json['brand_name'],
      exchangeCount:  json['exchangeCount']
    );
  }
}
