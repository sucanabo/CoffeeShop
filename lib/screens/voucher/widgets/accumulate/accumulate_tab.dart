import 'package:coffee_shop/providers/provider.dart';
import 'package:coffee_shop/screens/order/order_screeen.dart';
import 'package:coffee_shop/screens/voucher/widgets/accumulate/accumulate_info_card.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/untils/app_information.dart';
import 'package:coffee_shop/untils/url_laucher.dart';
import 'package:coffee_shop/values/values.dart';
import 'package:coffee_shop/widgets/haeding_underline.dart';
import 'package:coffee_shop/widgets/voucher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccumulateTab extends StatefulWidget {
  AccumulateTab({this.onChangedTab});
  final Function(int) onChangedTab;
  @override
  State<AccumulateTab> createState() => _AccumulateTabState();
}

class _AccumulateTabState extends State<AccumulateTab> {
  _rewardPressed() {
    widget.onChangedTab(1);
  }

  _voucherPressed() {
    widget.onChangedTab(2);
  }

  _transactionPressed() {
    Navigator.pushNamed(context, OrderScreen.routeName);
  }

  _privacyPolicyPressed() {
    URLLaucher.openLink(url: AppInformation.privacyPolicy);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VoucherProvider>(context, listen: false);

    return ListView(
      children: [
        Container(
          clipBehavior: Clip.none,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AccumulateInfoCard(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15.0),
                child: Wrap(spacing: 10.0, runSpacing: 15.0, children: [
                  CardItem(
                    text: LocaleKeys.reward.tr(),
                    icon: 'transfer.svg',
                    onPressed: _rewardPressed,
                  ),
                  CardItem(
                    text: LocaleKeys.your_voucher.tr(),
                    icon: 'voucher.svg',
                    onPressed: _voucherPressed,
                  ),
                  CardItem(
                    text: LocaleKeys.transaction_history.tr(),
                    icon: 'history_2.svg',
                    onPressed: _transactionPressed,
                  ),
                  CardItem(
                    text: LocaleKeys.privacy_policy.tr(),
                    icon: 'policy.svg',
                    onPressed: _privacyPolicyPressed,
                  ),
                ]),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadingUnderline(
                    text: 'Voucher ${LocaleKeys.available.tr().toLowerCase()}',
                  ),
                  SizedBox(
                    height: getHeight(15.0),
                  ),
                  if (provider.voucherItems.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(LocaleKeys.no_voucher.tr()),
                    ),
                  Consumer<VoucherProvider>(
                    builder: (context, vouchers, child) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: vouchers.voucherItems
                            .map((voucher) => VoucherWidget(
                                  voucher: voucher,
                                  isUserVoucher: false,
                                ))
                            .toList()),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
