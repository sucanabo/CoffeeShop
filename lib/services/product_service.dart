import 'dart:convert';

import 'package:coffee_shop/models/api_response.dart';
import 'package:coffee_shop/models/product.dart';
import 'package:coffee_shop/services/user_service.dart';
import 'package:coffee_shop/values/api_end_point.dart';
import 'package:http/http.dart' as http;

//Get all products
Future<ApiResponse> getProducts() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(productsURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['products']
            .map((p) => ProductModel.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
        final List<dynamic> a = apiResponse.data;
        print(a[0]);
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}

//Favourite or unfavourite
Future<ApiResponse> favouriteOrUnfavourite(int productId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http
        .post(Uri.parse('$productsURL/$productId/favourites'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

//Post rating
Future<ApiResponse> postRating({int productId, int star, String review}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(
        Uri.parse('$productsURL/$productId/ratings'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{'star': star, 'review': review}));
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['rating'];
        break;

      case 401:
        apiResponse.error = unauthorized;
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

//Get product with condition
Future<ApiResponse> getProductWithCondition(
    {String condition, int limit}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(
        Uri.parse('$productsURL/condition?condition=$condition&limit=$limit'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['products']
            .map((p) => ProductModel.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}
