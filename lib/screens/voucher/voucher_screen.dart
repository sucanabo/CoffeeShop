import 'package:coffee_shop/constants.dart';
import 'package:coffee_shop/models/api_response.dart';
import 'package:coffee_shop/providers/voucher_provider.dart';
import 'package:coffee_shop/screens/sign_in/sign_in_screen.dart';
import 'package:coffee_shop/services/user_service.dart';
import 'package:coffee_shop/services/voucher_service.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/widgets/my_appbar.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widgets/body.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({Key key}) : super(key: key);

  @override
  _VoucherScreenState createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  Future<void> retriveData() async {
    final VoucherProvider voucherProvider =
        Provider.of<VoucherProvider>(context, listen: false);
    if (voucherProvider.isLoading) {
      ApiResponse apiUserVoucher = await getAllUserVoucher();
      ApiResponse apiVoucher = await getAllVoucher();
      ApiResponse apiReward = await getAllReward();
      if (apiVoucher.error == null &&
          apiVoucher.error == null &&
          apiReward.error == null) {
        voucherProvider.setVouchers(apiVoucher.data);
        voucherProvider.setUserVouchers(apiUserVoucher.data);
        voucherProvider.setRewards(apiReward.data);
      } else if (apiVoucher.error == unauthorized ||
          apiReward.error == unauthorized) {
        logout().then((value) => {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                  (route) => false)
            });
      }
      voucherProvider.setLoading(false);
    }
  }

  @override
  void initState() {
    retriveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          appBar: AppBar(),
        ),
        body: Consumer<VoucherProvider>(
            builder: (context, vouchers, child) => vouchers.isLoading
                ? ScreenBody(
                    margin: EdgeInsets.only(top: 50.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    ),
                  )
                : Body()));
  }
}
