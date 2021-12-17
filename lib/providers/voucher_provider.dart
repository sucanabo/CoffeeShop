part of providers;

class VoucherProvider with ChangeNotifier {
  bool _isLoading = true;
  List<dynamic> _vouchers = [];
  List<dynamic> _userVouchers = [];
  List<dynamic> _rewards = [];

  //getter
  bool get isLoading => _isLoading;
  List get voucherItems => _vouchers;
  List get userVoucherItems => _userVouchers;
  List get rewardItems => _rewards;

  //setter
  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  setVouchers(List<dynamic> list) {
    _vouchers = list;
    notifyListeners();
  }

  setUserVouchers(List<dynamic> list) {
    _userVouchers = list;
    notifyListeners();
  }

  setRewards(List<dynamic> list) {
    _rewards = list;
    notifyListeners();
  }

  bool isVoucherSaved(int id) {
    return _userVouchers.any((element) => element.id == id);
  }

  List<dynamic> getFeaturedReward() {
    List<dynamic> tmpList = _rewards;
    tmpList.sort((a, b) => b.exchangeCount.compareTo(a.exchangeCount));
    if (tmpList.length >= 5) return tmpList.take(5).toList();
    return tmpList;
  }

  List<dynamic> getShopReward() {
    return _rewards
        .where((element) => element.brandName.toLowerCase() == 'kofeeholic')
        .toList();
  }

  List<dynamic> getBrandReward() {
    return _rewards
        .where((element) => element.brandName.toLowerCase() != 'kofeeholic')
        .toList();
  }

  Future<bool> saveVoucher(int id) async {
    ApiResponse response = await saveVoucherRequest(id);
    if (response.error == null) {
      final voucher = _vouchers.firstWhere((element) => element.id == id);
      _userVouchers.add(voucher);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<String> fetchData() async {
    ApiResponse apiUserVoucher = await getAllUserVoucher();
    ApiResponse apiVoucher = await getAllVoucher();
    ApiResponse apiReward = await getAllReward();
    if (apiVoucher.error == null &&
        apiVoucher.error == null &&
        apiReward.error == null) {
      _userVouchers = apiUserVoucher.data;
      _vouchers = apiVoucher.data;
      _rewards = apiReward.data;
      notifyListeners();
      return null;
    }
    return LocaleKeys.fetch_data_fail.tr();
  }
}
