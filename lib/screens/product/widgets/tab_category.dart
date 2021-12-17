part of screens;

class TabCategory extends StatelessWidget {
  final TabController controller;
  final List<dynamic> listCate;
  const TabCategory({this.controller, this.listCate});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      labelColor: AppColors.primaryColor,
      unselectedLabelColor: Colors.grey[500],
      labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
      isScrollable: true,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: CircleTabIndicator(color: AppColors.primaryColor, radius: 3),
      tabs: listCate.map((item) => Tab(text: item.titleDisplay)).toList(),
    );
  }
}
