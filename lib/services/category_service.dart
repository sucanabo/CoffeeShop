import 'dart:convert';
import 'package:coffee_shop/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:coffee_shop/models/api_response.dart';
import 'package:coffee_shop/services/user_service.dart';

import '../values/api_end_point.dart';

//get all category
Future<ApiResponse> getCategories() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(categoriesURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['categories']
            .map((c) => CategoryModel.fromJson(c))
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
