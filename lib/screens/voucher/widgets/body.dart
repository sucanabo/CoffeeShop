part of screens;

class VoucherBody extends StatefulWidget {
  @override
  _VoucherBodyState createState() => _VoucherBodyState();
}

class _VoucherBodyState extends State<VoucherBody> with TickerProviderStateMixin {
  final List<String> tabList = [
    LocaleKeys.accumulate.tr(),
    LocaleKeys.reward.tr(),
    'Voucher'
  ];

  TabController _tabController;
  @override
  // ignore: must_call_super
  void initState() {
    _tabController = TabController(vsync: this, length: tabList.length);
  }

  _setTab(int index) {
    _tabController.index = index;
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
        Widget>[
      SizedBox(height: 30.0),
      Expanded(
          child: Container(
        clipBehavior: Clip.none,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            color: Colors.white),
        child: Column(children: <Widget>[
          TabBar(
            controller: _tabController,
            labelColor: AppColors.primaryColor,
            unselectedLabelColor: Colors.grey[500],
            labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator:
                CircleTabIndicator(color: AppColors.primaryColor, radius: 3),
            tabs: tabList.map((item) => Tab(text: item)).toList(),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: <Widget>[
              AccumulateTab(
                onChangedTab: (val) {
                  _setTab(val);
                },
              ),
              RewardTab(),
              VoucherTab(),
            ]),
          ),
        ]),
      ))
    ]);
  }
}
