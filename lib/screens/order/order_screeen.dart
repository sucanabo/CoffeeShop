import 'dart:async';

import 'package:coffee_shop/models/api_response.dart';
import 'package:coffee_shop/models/transaction.dart';
import 'package:coffee_shop/providers/transaction_provider.dart';
import 'package:coffee_shop/screens/order/widgets/transaction.dart';
import 'package:coffee_shop/services/order_service.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:coffee_shop/values/styles.dart';
import 'package:coffee_shop/widgets/loading.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static String routeName = '/order';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  TabController filterTabController;
  List<String> transactionStatus = [
    '',
    'pending',
    'cancelled',
    'packing',
    'shipping',
    'success'
  ];
  int tabSelected = 0;
  int page = 0;
  int totalRow = 0;
  bool _loading = true;

  Future fetchData({String status}) async {
    setState(() {
      _loading = true;
    });

    final ApiResponse response = await getTransactions(status: status);
    if (response.error == null) {
      final data = response.data as TransactionPagingModel;
      final provider = Provider.of<TransactionProvider>(context, listen: false);
      provider.setTransactionList(data.data);
      setState(() {
        totalRow = data.totalRow;
      });
    } else {
      showToast('Get data failed.');
    }
    setState(() {
      _loading = false;
    });
  }

  onChangeFilter({bool isNextPage = false}) async {
    final provider = Provider.of<TransactionProvider>(context, listen: false);

    setLoading(context, loading: true);
    if (isNextPage) {
      page++;
    } else {
      page = 0;
      totalRow = 0;
      provider.clear();
    }

    final ApiResponse response = await getTransactions(
      status: transactionStatus[tabSelected],
      page: page,
    );
    if (response.error == null) {
      final data = response.data as TransactionPagingModel;
      provider.setTransactionList(data.data);
      setState(() {
        totalRow = data.totalRow;
      });
    }
    setLoading(context, loading: false);
  }

  @override
  void initState() {
    filterTabController =
        TabController(length: transactionStatus.length, vsync: this);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        onChangeFilter(isNextPage: true);
      }
    });
    Provider.of<TransactionProvider>(context, listen: false).clear();
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBody(
      padding: EdgeInsets.zero,
      appBar: AppBar(
        title: Text('Your transaction'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TabBar(
              controller: filterTabController,
              labelPadding: EdgeInsets.only(right: getWidth(8)),
              labelColor: AppColors.whiteColor,
              isScrollable: true,
              onTap: (index) {
                tabSelected = index;
                onChangeFilter();
              },
              indicator: const BoxDecoration(),
              unselectedLabelColor: AppColors.blackColor.withOpacity(0.6),
              tabs: List.generate(transactionStatus.length,
                  (index) => _buidTab(transactionStatus[index], index)),
            ),
          ),
          SizedBox(height: getHeight(20.0)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              '$totalRow result',
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: AppStyles.textSize14,
                  decoration: TextDecoration.underline),
            ),
          ),
          SizedBox(height: getHeight(10.0)),
          _loading
              ? Center(child: Loading())
              : Consumer<TransactionProvider>(
                  builder: (context, provider, child) => Expanded(
                      child: RefreshIndicator(
                    color: AppColors.primaryMediumColor,
                    onRefresh: () => onChangeFilter(),
                    child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        controller: scrollController,
                        itemCount: provider.getTransaction.length + 1,
                        separatorBuilder: (context, index) => SizedBox(
                              height: getHeight(15.0),
                            ),
                        itemBuilder: (context, index) {
                          if (index < provider.getTransaction.length) {
                            return Transaction(
                              model: provider.getTransaction[index],
                            );
                          } else if (provider.getTransaction.length <
                              totalRow) {
                            return Center(
                                child: SizedBox(
                                    height: getHeight(30), child: Loading()));
                          } else {
                            return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: getHeight(15.0)),
                                child: const Text(
                                  'No more resul.',
                                  textAlign: TextAlign.center,
                                ));
                          }
                        }),
                  )),
                )
        ],
      ),
    );
  }

  Widget _buidTab(String title, int index) {
    return Container(
      height: getHeight(32),
      padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
      decoration: BoxDecoration(
          color: tabSelected == index
              ? AppColors.primaryColor
              : AppColors.whiteColor,
          border: tabSelected != index
              ? Border.all(color: AppColors.primaryMediumColor)
              : null,
          borderRadius: BorderRadius.circular(getHeight(50))),
      child: Tab(
        text: index != 0 ? title.capitalize() : 'All',
      ),
    );
  }
}