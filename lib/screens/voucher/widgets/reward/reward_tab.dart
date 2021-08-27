import 'package:coffee_shop/providers/voucher_provider.dart';
import 'package:coffee_shop/widgets/haeding_underline.dart';
import 'package:coffee_shop/widgets/reward.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RewardTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<VoucherProvider>(
      builder: (context, provider, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeadingUnderline(
                      text: 'Featured',
                    ),
                  ],
                ),
                Container(
                  height: 280.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: provider
                        .getFeaturedReward()
                        .map((reward) => RewardWidget(
                              reward: reward,
                              isLarge: true,
                            ))
                        .toList(),
                  ),
                ),
                _buildRewardContainer(
                    list: provider.getShopReward(), heading: 'Kofeeholic'),
                _buildRewardContainer(
                    list: provider.getBrandReward(), heading: 'Other brand')
              ],
            )
          ],
        ),
      ),
    );
  }

  Column _buildRewardContainer({List list, String heading}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadingUnderline(
          text: heading,
        ),
        Container(
            height: list.isNotEmpty ? 300 : 50,
            margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: list.isNotEmpty
                ? GridView(
                    padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 100,
                        childAspectRatio: 1 / 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    scrollDirection: Axis.horizontal,
                    children: list
                        .map((reward) => RewardWidget(reward: reward))
                        .toList(),
                  )
                : Text(
                    'No reward this time.',
                    style: TextStyle(fontSize: 16.0),
                  ))
      ],
    );
  }
}
