import 'package:coffee_shop/providers/voucher_provider.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/widgets/haeding_underline.dart';
import 'package:coffee_shop/widgets/voucher.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class VoucherTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'enterCode'),
          child: Container(
            clipBehavior: Clip.none,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: Offset(3, 5),
                      blurRadius: 8.0,
                      spreadRadius: 1.0)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LineIcon.alternateTicket(
                  size: 30.0,
                  color: AppColors.primaryColor,
                ),
                Text(
                  LocaleKeys.enter_code.tr(),
                  style: TextStyle(fontSize: 16.0),
                ),
                LineIcon.angleRight()
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadingUnderline(
                text: LocaleKeys.available.tr(),
              ),
              Consumer<VoucherProvider>(
                builder: (context, vouchers, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: vouchers.userVoucherItems
                        .map((voucher) => VoucherWidget(
                              voucher: voucher,
                              isUserVoucher: true,
                            ))
                        .toList()),
              )
            ],
          ),
        )
      ],
    );
  }
}
