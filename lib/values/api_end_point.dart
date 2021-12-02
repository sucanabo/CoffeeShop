//----------STRINGS----------
import 'package:coffee_shop/untils/app_information.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const baseURL = '${AppInformation.baseURL}/api';
//auth
const loginURL = baseURL + '/login';
const registerURL = baseURL + '/register';
const logoutURL = baseURL + '/logout';
const userURL = baseURL + '/user';
const checkPhone = baseURL + '/check_phone';
const userChangePassword = userURL + '/changepassword';
//product
const productsURL = baseURL + '/products';
const categoriesURL = baseURL + '/categories';
const ratingsURL = baseURL + '/ratings';
const uservouchersURL = baseURL + '/uservouchers';
const vouchersURL = baseURL + '/vouchers';
const rewardsURL = baseURL + '/rewards';
const addressesURL = baseURL + '/addresses';
//order
const order = baseURL + '/orders';
//transactions
const transaction = baseURL + '/transactions';
//tomtom api
const String tomtomBaseURL = 'https://api.tomtom.com';
const String mapvietBaseURL = 'https://maps.vietmap.vn';
String tomtomAutoComplete(String query) {
  return '$tomtomBaseURL/search/2/search/$query.json?key=${AppInformation.tomtomAPIKey}&language=vi-VN&limit=10&countrySet=VN';
}

String mapvietAutoComlete(String query) {
  return '$mapvietBaseURL/api/autocomplete?api-version=1.1&apikey=${AppInformation.mapvietAPIKey}&text=$query';
}

String mapVietDistance(LatLng latlong1, LatLng latlong2) {
  return '$mapvietBaseURL/api/route?api-version=1.1&apikey=${AppInformation.mapvietAPIKey}&point=${latlong1.latitude},${latlong1.longitude}&point=${latlong2.latitude},${latlong2.longitude}';
}

String tomtomDistance(LatLng latlong1, LatLng latlong2) {
  return '$tomtomBaseURL/routing/1/calculateRoute/${latlong1.latitude},${latlong1.longitude}:${latlong2.latitude},${latlong2.longitude}/json?key=${AppInformation.tomtomAPIKey}';
}

//----------ERROR----------
const serverError = 'Server Error.';
const unauthorized = 'Unauthorized.';
const somethingWentWrong = 'Some thing went wrong, try again!';
