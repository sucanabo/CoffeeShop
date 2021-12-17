part of models;

class CategoryModel {
  final int id;
  final String title;
  final String titleDisplay;
  final String type;

  const CategoryModel({this.id, this.title, this.titleDisplay, this.type});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'],
        type: json['type'],
        title: json['title'],
        titleDisplay: _getTitleDisplay(json['title']));
  }
  static _getTitleDisplay(String str) {
    switch (str) {
      case 'Cà phê':
        return LocaleKeys.cate_coffee.tr();
        break;
      case 'Trà sữa':
        return LocaleKeys.cate_milk_tea.tr();
        break;
      case 'Trà':
        return LocaleKeys.cate_tea.tr();
        break;
      case 'Đá xay':
        return LocaleKeys.cate_ice_blended.tr();
        break;
      default:
        return str;
    }
  }
}
