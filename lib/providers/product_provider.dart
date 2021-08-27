import 'package:coffee_shop/models/product.dart';
import 'package:coffee_shop/models/rating.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  List<dynamic> _productList = [];
  bool _loading = true;
  //getter
  bool get isLoading => _loading;
  List<dynamic> get productList => _productList;

  //setter
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setProductList(List<dynamic> list) {
    _productList = list;
    notifyListeners();
    print(_productList[0]);
  }

  ProductModel getProductByIndex(int index) => _productList[index];

  ProductModel getProductById(int id) =>
      _productList.firstWhere((element) => element.id == id);

  RatingModel getProductRating(int id) {
    ProductModel instance = getProductById(id);
    RatingModel rating = instance.selfRating;
    return rating;
  }

  setProductRating({int productId, RatingModel rating}) {
    ProductModel product = getProductById(productId);
    product.selfRating = rating;
    notifyListeners();
  }

  setProductFavourite(int productId) {
    ProductModel product =
        _productList.firstWhere((item) => item.id == productId);
    product.selfFavourited = !product.selfFavourited;
    notifyListeners();
  }

  List<dynamic> get getFavouriteProducts {
    return _productList.where((product) => product.selfFavourited).toList();
  }
}
