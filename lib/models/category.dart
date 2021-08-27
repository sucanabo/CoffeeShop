class CategoryModel {
  final int id;
  final String title;
  final String type;

  const CategoryModel({this.id, this.title, this.type});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      type: json['type'],
      title: json['title'],
    );
  }
}
