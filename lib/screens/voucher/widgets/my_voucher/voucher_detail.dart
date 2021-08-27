import 'package:coffee_shop/models/voucher.dart';
import 'package:coffee_shop/providers/navigation_provider.dart';
import 'package:coffee_shop/screens/product/product_screen.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VoucherDetail extends StatelessWidget {
  final VoucherModel voucher;
  VoucherDetail({this.voucher});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            'Kofeeholic',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            voucher.title ?? 'null',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
          ),
          Divider(height: 20.0),
          Image(
            image: base64StringToImage(voucher.qrCode ?? voucher.image),
            height: SizeConfig.screenWidth * 0.8,
            width: SizeConfig.screenWidth * 0.8,
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                voucher.couponCode,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22.0, color: Colors.grey[700]),
              ),
              TextButton(
                  onPressed: () {
                    coppyClipBoard(voucher.couponCode, context);
                  },
                  child: Text(
                    'Copy',
                    style: TextStyle(fontSize: 18.0),
                  )),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          if (voucher.discount != null) _buildOrderButton(context),
          SizedBox(height: 15.0),
          Divider(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Expired date:',
                style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
              ),
              Text(formartDate(voucher.expiryDate) ?? 'null',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey[700]))
            ],
          ),
          Divider(
            height: 20.0,
          ),
          Text(
            voucher.content ?? 'No content',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Align _buildOrderButton(BuildContext context) {
    return Align(
      child: ElevatedButton(
        child: Text('ORDER NOW'),
        onPressed: () {
          Navigator.of(context).pop();
          Provider.of<NavigationProvider>(context, listen: false)
              .redirectScreen(ProductScreen());
        },
        style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            primary: primaryMediumColor,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            textStyle: TextStyle(fontSize: 16.0)),
      ),
    );
  }
}
