//Get all voucher of user
import 'dart:convert';

import 'package:coffee_shop/constants.dart';
import 'package:coffee_shop/models/api_response.dart';
import 'package:coffee_shop/models/reward.dart';
import 'package:coffee_shop/models/voucher.dart';
import 'package:coffee_shop/services/user_service.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> getAllUserVoucher() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(uservouchersURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['vouchers']
            .map((v) => VoucherModel.fromJson(v))
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
    print('error uservoucher');

    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> getAllVoucher() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(vouchersURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['vouchers']
            .map((v) => VoucherModel.fromJson(v))
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
    print('error voucher');

    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> saveVoucher(int voucherId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(
        Uri.parse('$uservouchersURL/$voucherId/save'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['voucher'];
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

Future<ApiResponse> getAllReward() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(rewardsURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['rewards']
            .map((v) => RewardModel.fromJson(v))
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
