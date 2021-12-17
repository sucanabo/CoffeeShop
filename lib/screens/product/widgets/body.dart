import 'package:coffee_shop/providers/category_provider.dart';
import 'package:coffee_shop/providers/product_provider.dart';
import 'package:coffee_shop/screens/product/widgets/product_header.dart';
import 'package:coffee_shop/screens/product/widgets/tab_category.dart';
import 'package:coffee_shop/widgets/product.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  final Function onRefresh;
  Body({this.onRefresh});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  TabController _drinkTabController;
  TabController _foodTabController;
  int _indexTab;
  int userId = 0;
  List<dynamic> _drinkCate;
  List<dynamic> _foodCate;

  List<dynamic> _getCate(String type) {
    return Provider.of<CategoryProvider>(context, listen: false)
        .categoryList
        .where((c) => c.type == type)
        .toList();
  }

  void setTabIndex(int index) {
    setState(() {
      _indexTab = index;
    });
  }

  @override
  // ignore: must_call_super
  void initState() {
    _indexTab = 0;
    _drinkCate = _getCate('drink');
    _foodCate = _getCate('food');
    _drinkTabController = TabController(vsync: this, length: _drinkCate.length);
    _foodTabController = TabController(vsync: this, length: _foodCate.length);
  }
  void setTabActive() {}
  @override
  Widget build(BuildContext context) {
    return ScreenBody(
      margin: EdgeInsets.only(top: 50.0),
      child: Column(
        children: [
          ProductHeader(indexTab: _indexTab, setIndex: setTabIndex),
          Expanded(
            child: IndexedStack(
              index: _indexTab,
              children: [
                buildTabView(
                    listCate: _drinkCate, controller: _drinkTabController),
                buildTabView(
                    listCate: _foodCate, controller: _foodTabController),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Consumer buildTabView({List<dynamic> listCate, TabController controller}) {
    return Consumer<ProductProvider>(
      builder: (_, provider, __) => Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TabCategory(controller: controller, listCate: listCate),
          ),
          Expanded(
            child: Container(
                child: TabBarView(
                    controller: controller,
                    children: listCate.map((cate) {
                      List<dynamic> list = provider.productList
                          .where((product) => product.cateId == cate.id)
                          .toList();
                      return RefreshIndicator(
                        color: Theme.of(context).primaryColor,
                        onRefresh: this.widget.onRefresh,
                        child: ListView(
                          padding: EdgeInsets.only(bottom: 25.0),
                          children: list
                              .map((item) => ProductWidget(
                                    product: item,
                                    isLarge: true,
                                  ))
                              .toList(),
                        ),
                      );
                    }).toList())),
          ),
        ],
      ),
    );
  }
}
