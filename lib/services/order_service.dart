import 'dart:convert';

import 'package:coffee_shop/models/api_response.dart';
import 'package:coffee_shop/models/cart_item.dart';
import 'package:coffee_shop/models/order_request.dart';
import 'package:coffee_shop/models/transaction.dart';
import 'package:coffee_shop/services/user_service.dart';
import 'package:coffee_shop/values/api_end_point.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> createOrder(
    {int addressId,
    double shippingCost,
    double subtotal,
    double voucherDiscount,
    double shippingDiscount,
    String promo,
    double grandtotal,
    String content,
    String deliveryMethod,
    List<CartItemModel> items}) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    String firebaseToken = await FirebaseMessaging.instance.getToken();
    print('request order data');
    print(jsonEncode(OrderRequestModel(
            firebaseToken: firebaseToken,
            addressId: addressId,
            content: content,
            deliveryMethod: deliveryMethod,
            grandtotal: grandtotal,
            promo: promo,
            shipping: shippingCost,
            shippingDiscount: shippingDiscount,
            subtotal: subtotal,
            voucherDiscount: voucherDiscount,
            items: items)
        .toJson()));
    final response = await http.post(Uri.parse(order),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'content-type': 'application/json'
        },
        body: jsonEncode(OrderRequestModel(
                firebaseToken: firebaseToken,
                addressId: addressId,
                content: content,
                deliveryMethod: deliveryMethod,
                grandtotal: grandtotal,
                promo: promo,
                shipping: shippingCost,
                shippingDiscount: shippingDiscount,
                subtotal: subtotal,
                voucherDiscount: voucherDiscount,
                items: items)
            .toJson()));
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
    print(e);
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> getTransactions(
    {int page = 1, int limit = 10, String status}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final token = await getToken();
    final response = await http.post(Uri.parse(transaction),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'content-type': 'application/json'
        },
        body: jsonEncode(TransactionRequest(
          limit: limit,
          page: page,
          status: status,
        ).toJson()));

    switch (response.statusCode) {
      case 200:
        apiResponse.data =
            TransactionPagingModel.fromJson(jsonDecode(response.body));
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    print(e);
    showToast(apiResponse.error);
  }

  return apiResponse;
}
