import 'package:coffee_shop/providers/voucher_provider.dart';
import 'package:coffee_shop/screens/voucher/widgets/accumulate/accumulate_info_card.dart';
import 'package:coffee_shop/widgets/haeding_underline.dart';
import 'package:coffee_shop/widgets/voucher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccumulateTab extends StatelessWidget {
  const AccumulateTab({
    @required this.cardList,
  });

  final List cardList;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VoucherProvider>(context, listen: false);
    return ListView(children: [
      Container(
        clipBehavior: Clip.none,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccumulateInfoCard(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15.0),
              child: Wrap(
                spacing: 10.0,
                runSpacing: 15.0,
                children: cardList.map((
                  item,
                ) {
                  return CardItem(item: item);
                }).toList(),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadingUnderline(
                  text: 'Available',
                ),
                if (provider.voucherItems.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text('No voucher available'),
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
    ]);
  }
}
