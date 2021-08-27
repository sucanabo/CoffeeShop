import 'package:coffee_shop/screens/voucher/widgets/accumulate/accumulate_tab.dart';
import 'package:coffee_shop/screens/voucher/widgets/my_voucher/voucher_tab.dart';
import 'package:coffee_shop/screens/voucher/widgets/reward/reward_tab.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/widgets/custom.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  // Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  final List<String> tabList = ['Accumulate', 'Reward', 'Voucher'];
  final List cardList = [
    {'text': 'Reward', 'icon': 'transfer.svg'},
    {'text': 'Your Voucher', 'icon': 'voucher.svg'},
    {'text': 'Transfer History', 'icon': 'history_2.svg'},
    {'text': 'Policies', 'icon': 'policy.svg'},
  ];
  TabController _tabController;
  int indexTab;
  @override
  // ignore: must_call_super
  void initState() {
    indexTab = 0;
    _tabController = TabController(vsync: this, length: tabList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 30.0),
          Expanded(
              child: Container(
            clipBehavior: Clip.none,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                color: Colors.white),
            child: Column(children: <Widget>[
              TabBar(
                controller: _tabController,
                labelColor: primaryColor,
                unselectedLabelColor: Colors.grey[500],
                labelStyle:
                    TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: CircleTabIndicator(color: primaryColor, radius: 3),
                tabs: tabList.map((item) => Tab(text: item)).toList(),
              ),
              Expanded(
                child:
                    TabBarView(controller: _tabController, children: <Widget>[
                  AccumulateTab(cardList: cardList),
                  RewardTab(),
                  VoucherTab(),
                ]),
              ),
            ]),
          ))
        ]);
  }
}
