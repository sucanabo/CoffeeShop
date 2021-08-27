import 'dart:convert';

import 'package:coffee_shop/constants.dart';
import 'package:coffee_shop/models/address.dart';
import 'package:coffee_shop/models/api_response.dart';
import 'package:coffee_shop/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//Login
Future<ApiResponse> login(String phone, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(loginURL),
        headers: {'Accept': 'application/json'},
        body: {'phone': phone, 'password': password});
    switch (response.statusCode) {
      case 200:
        apiResponse.data = UserModel.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
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

//Register
Future<ApiResponse> register(
    {String phone,
    String email,
    String password,
    String firstName,
    String lastName}) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(Uri.parse(registerURL), headers: {
      'Accept': 'application/json'
    }, body: {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'password': password,
      'password_confirmation': password
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = UserModel.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
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

//Get user information
Future<ApiResponse> getUserInformation() async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(userURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = UserModel.fromJson(jsonDecode(response.body));
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
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

Future<ApiResponse> updateUser(
    {String phone,
    String email,
    String password,
    String firstName,
    String lastName,
    String image}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.put(Uri.parse(userURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (password != null) 'password': password,
      if (image != null) 'image': image,
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

//crate address
Future<ApiResponse> createAddress({AddressModel address}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse('$addressesURL/create'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'content-type': 'application/json'
        },
        body: jsonEncode({
          'title': address.title,
          'address': address.address,
          'receiver_name': address.receiverName,
          'receiver_phone': address.receiverPhone,
          'description': address.description,
          'coordinates': address.coordinates,
        }));
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['address']['id'];
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

//update address
Future<ApiResponse> updateAddress({AddressModel address, int id}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.put(Uri.parse('$addressesURL/$id/edit'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'content-type': 'application/json'
        },
        body: jsonEncode({
          'title': address.title,
          'address': address.address,
          'receiver_name': address.receiverName,
          'receiver_phone': address.receiverPhone,
          'description': address.description,
          'coordinates': address.coordinates,
        }));
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

//delete user address
Future<ApiResponse> deleteAddress(int id) async {
  ApiResponse apiResponse = ApiResponse();
  print('$addressesURL/$id/delete');
  try {
    String token = await getToken();
    final response =
        await http.delete(Uri.parse('$addressesURL/$id/delete'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
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
  } catch (e) {}
  return apiResponse;
}

//Get user addresses
Future<ApiResponse> getUserAddresses() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse('$addressesURL'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['addresses']
            .map((a) => AddressModel.fromJson(a))
            .toList();
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    print('error address');
    apiResponse.error = serverError;
  }
  return apiResponse;
}

//Get token
Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}

//Get user id
Future<int> getUserId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('id') ?? 0;
}

//Logout
Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance(); 
  return await pref.clear();
}
