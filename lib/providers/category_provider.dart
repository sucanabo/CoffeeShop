part of providers;
class CategoryProvider with ChangeNotifier {
  List<dynamic> _categoryList = [];

  List<dynamic> get categoryList => _categoryList;

  setCategoryList(List<dynamic> list) {
    _categoryList = list;
    notifyListeners();
  }
}
