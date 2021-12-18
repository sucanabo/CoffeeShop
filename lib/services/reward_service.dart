part of services;

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
    print('error reward');
  }
  return apiResponse;
}

Future<ApiResponse> redeemRewardRequest(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse('$rewardsURL/$id/redeem'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 400:
        apiResponse.error = 'You not enough point to redeem this reward';
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
    print('error redeem reward');
  }
  return apiResponse;
}
