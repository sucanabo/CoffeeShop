import 'package:coffee_shop/models/address.dart';
import 'package:coffee_shop/models/api_response.dart';
import 'package:coffee_shop/models/user.dart';
import 'package:coffee_shop/services/user_service.dart' as sv;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  UserModel _user;
  List<dynamic> _addresses = [];
  bool _addressLoading = true;

  Map levelPoint = {
    'New': 100, //lv0
    'Bzone': 300, //lv1
    'Silver': 600, //lv2
    'Gold': 1000, //lv3
    'Platinum': 3000 //lv4
  };

  //getter
  bool get isAuth => _user.token != null;
  List<dynamic> get addresses => _addresses;
  UserModel get getUser => _user;
  int get getUserId => _user.id;
  String get getToken => _user.token;
  bool get addressLoading => _addressLoading;
  //setter
  setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  setAddresses(List<dynamic> list) {
    _addresses = list;
    notifyListeners();
  }

  setAddressLoading(bool value) {
    _addressLoading = value;
    notifyListeners();
  }

  Future<String> fetAddresses() async {
    ApiResponse response = await sv.getUserAddresses();
    if (response.error == null) {
      setAddresses(response.data);
      notifyListeners();
      return null;
    }
    return response.error;
  }

  Future<String> updateAddress(AddressModel address, int id) async {
    ApiResponse response = await sv.updateAddress(address: address, id: id);
    if (response.error == null) {
      int index = _addresses
          .indexOf(_addresses.firstWhere((element) => element.id == id));
      print(index);
      _addresses[index] = AddressModel(
        id: id,
        title: address.title,
        address: address.address,
        receiverName: address.receiverName,
        receiverPhone: address.receiverPhone,
        coordinates: address.coordinates,
        description: address.description,
      );
      notifyListeners();
      return null;
    }
    return response.error;
  }

  Future<String> createAddress(AddressModel address) async {
    ApiResponse response = await sv.createAddress(address: address);
    if (response.error == null) {
      _addresses.add(AddressModel(
          id: response.data,
          address: address.address,
          title: address.title,
          description: address.description,
          receiverName: address.receiverName,
          receiverPhone: address.receiverPhone));
      notifyListeners();
      return null;
    }
    return response.error;
  }

  Future<String> deleteAddress(int id) async {
    ApiResponse response = await sv.deleteAddress(id);
    if (response.error == null) {
      _addresses.removeWhere((element) => element.id == id);
      notifyListeners();
      return null;
    }
    return response.error;
  }

  updateUser(UserModel user) {
    _user.firstName = user.firstName ?? _user.firstName;
    _user.lastName = user.lastName ?? _user.lastName;
    _user.email = user.email ?? _user.email;
    _user.phone = user.phone ?? _user.phone;
    _user.image = user.image ?? _user.image;
    notifyListeners();
  }

  int caculateNextLevel() {
    return levelPoint.values.toList()[_user.level] - _user.point;
  }

  String getLevelString({int level}) {
    int curentPoint =
        level != null ? levelPoint.values.toList()[level] : _user.point;
    String result;
    for (var key in levelPoint.keys) {
      if (curentPoint <= levelPoint[key]) {
        result = key;
        break;
      }
    }
    return result != null ? result : 'V.I.P';
  }

  Future<String> login({String phone, String password}) async {
    ApiResponse response = await sv.login(phone, password);
    if (response.error == null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      final UserModel user = response.data as UserModel;
      setUser(user);
      
      pref.setString('token', user.token ?? '');
      pref.setInt('id', user.id ?? 0);
      return null;
    }
    return response.error;
  }
  
}
