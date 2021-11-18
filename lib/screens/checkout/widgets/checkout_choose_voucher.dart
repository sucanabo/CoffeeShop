import 'package:coffee_shop/models/cart_item.dart';
import 'package:coffee_shop/models/voucher.dart';
import 'package:coffee_shop/providers/cart_provider.dart';
import 'package:coffee_shop/providers/category_provider.dart';
import 'package:coffee_shop/providers/voucher_provider.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:coffee_shop/widgets/screen_body_loading.dart';
import 'package:coffee_shop/widgets/voucher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseVoucher extends StatefulWidget {
  final bool isDeliveryMethod;
  final bool isEdit;
  const ChooseVoucher({@required this.isDeliveryMethod, this.isEdit});
  @override
  _ChooseVoucherState createState() => _ChooseVoucherState();
}

class _ChooseVoucherState extends State<ChooseVoucher> {
  VoucherProvider _vouchersProvider;
  CategoryProvider _categoryProvider;
  List<dynamic> _shippingVouchers = [];
  List<dynamic> _discountVouchers = [];
  VoucherModel _shippingSelected;
  VoucherModel _discountSelected;
  List<CartItemModel> _cartItemValid;

  getVouchers() {
    _shippingVouchers = _vouchersProvider.userVoucherItems
        .where((element) => element.applyFor == 'shipping')
        .toList();
    _discountVouchers = _vouchersProvider.userVoucherItems
        .where((element) =>
            element.applyFor != 'shipping' &&
            element.applyFor != '' &&
            element.applyFor != null)
        .toList();
  }

  fetchData() async {
    final result = await _vouchersProvider.fetchData();
    if (result == null) {
      getVouchers();
    } else {
      showMess(context: context, text: 'Fetch data fail.');
    }
    _vouchersProvider.setLoading(false);
  }

  void returnData() {
    Navigator.pop(context, {
      'shippingVoucher': _shippingSelected,
      'discountVoucher': _discountSelected,
      'cartItemValid': _cartItemValid,
    });
    print({
      'shippingVoucher': _shippingSelected,
      'discountVoucher': _discountSelected,
      'cartItemValid': _cartItemValid,
    });
  }

  @override
  void initState() {
    super.initState();
    _vouchersProvider = Provider.of<VoucherProvider>(context, listen: false);
    _categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    if (_vouchersProvider.isLoading == true) {
      fetchData();
    } else {
      getVouchers();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      final data = ModalRoute.of(context).settings.arguments as Map;
      if (data != null) {
        _shippingSelected = _shippingSelected != null
            ? _shippingSelected
            : data['shippingVoucher'];
        _discountSelected = _discountSelected != null
            ? _discountSelected
            : data['discountVoucher'];
      }
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Choose voucher'),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  returnData();
                },
                child: Text(
                  'Done',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ))
          ],
        ),
        body: WillPopScope(
          onWillPop: () async {
            returnData();
            return true;
          },
          child: Consumer<VoucherProvider>(
            builder: (context, provider, child) => _vouchersProvider.isLoading
                ? ScreenBodyLoading()
                : ScreenBody(
                    child: ListView(
                    padding: EdgeInsets.all(20.0),
                    children: [
                      Text(
                        'Shipping',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10.0),
                      _shippingVouchers.isEmpty
                          ? Text('You don\'t have any shipping voucher.')
                          : !widget.isDeliveryMethod
                              ? Text(
                                  'Shipping vouchers are only apply with delivery method.')
                              : _buildShippingList(_shippingVouchers),
                      SizedBox(height: 20.0),
                      Text(
                        'Discount',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10.0),
                      _discountVouchers.isEmpty
                          ? Text('You don\'t have any discount voucher.')
                          : _buildDiscountList(_discountVouchers),
                    ],
                  )),
          ),
        ));
  }

  Column _buildShippingList(List<dynamic> list) {
    return Column(
        children: list.map((v) {
      final validate = voucherValidate(v);
      return Stack(children: [
        VoucherWidget(
          voucher: v,
          isUserVoucher: true,
          enable: validate['valid'] && widget.isDeliveryMethod,
          initChoose:
              _shippingSelected == null ? false : _shippingSelected.id == v.id,
          chooseVoucherPress: (voucher) => setShippingVoucher(v),
        ),
        if (validate['valid'])
          Positioned(
            bottom: 0,
            right: 0,
            child: Radio(
                activeColor: AppColors.primaryColor,
                value: v,
                groupValue: _shippingSelected,
                onChanged: (val) => setShippingVoucher(val)),
          )
      ]);
    }).toList());
  }

  Column _buildDiscountList(List<dynamic> list) {
    return Column(
        children: list.map((v) {
      final validate = voucherValidate(v);
      return Stack(children: [
        VoucherWidget(
          voucher: v,
          isUserVoucher: true,
          enable: validate['valid'],
          initChoose:
              _discountSelected == null ? false : _discountSelected.id == v.id,
          chooseVoucherPress: (voucher) {
            _cartItemValid = validate['validList'];
            setDiscountVoucher(voucher);
          },
        ),
        if (validate['valid'])
          Positioned(
            bottom: 0,
            right: 0,
            child: Radio(
                activeColor: AppColors.primaryColor,
                value: v,
                groupValue: _discountSelected,
                onChanged: (val) {
                  _cartItemValid = validate['validList'];
                  setDiscountVoucher(val);
                }),
          )
      ]);
    }).toList());
  }

  Map<String, dynamic> voucherValidate(VoucherModel voucher) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final cartItems = cartProvider.items;

    bool checkObj(List<dynamic> obj, String type, CartItemModel cartItem) {
      if (obj != null) {
        if (type == 'product') {
          return obj.any((element) => element == cartItem.product.id);
        } else if (type == 'category') {
          return obj.any((element) => element == cartItem.product.cateId);
        }
      }

      return true;
    }

    bool checkQuantity(CartItemModel cartItem, String type) {
      final list = cartProvider.items;
      bool result;
      switch (type) {
        case 'order':
          result = list.length >= voucher.quantityRule;
          break;
        case 'category':
          result = cartItem.quantity >= voucher.quantityRule &&
              _categoryProvider.categoryList
                  .any((element) => element.id == cartItem.product.cateId);
          break;
        case 'product':
          result = cartItem.quantity >= voucher.quantityRule;
          break;

        default:
          result = true;
      }
      return result;
    }

    bool checkPrice(CartItemModel cartItem, String type) {
      bool result;
      switch (type) {
        case 'category':
          result = cartItem.price >= voucher.priceRule &&
              _categoryProvider.categoryList
                  .any((element) => element.id == cartItem.product.cateId);
          break;
        case 'product':
          result = cartItem.price >= voucher.priceRule;
          break;
        case 'order':
          result = cartProvider.totalAmount >= voucher.priceRule * 1000;
          break;
        default:
          result = true;
      }
      return result;
    }

    bool checkSize(CartItemModel cartItem, String type) {
      if (voucher.sizeRule == null) return true;
      bool result;
      switch (type) {
        case 'category':
          result = cartItem.productExtend['options']['size']['option_title'] >=
                  voucher.sizeRule &&
              _categoryProvider.categoryList
                  .any((element) => element.id == cartItem.product.cateId);
          break;
        case 'product':
          result = cartItem.productExtend['options']['size']['option_title'] ==
              voucher.sizeRule;
          break;
        case 'order':
          result = cartProvider.items.values.any((element) =>
              element.productExtend['options']['size']['option_title'] ==
              voucher.sizeRule);
          break;
        default:
          result = true;
      }
      return result;
    }

    bool checkDelivery() {
      if (voucher.deliveryRule != null && voucher.deliveryRule != '') {
        if (voucher.deliveryRule == 'both') {
          return true;
        } else if (voucher.deliveryRule == 'pickup' &&
            widget.isDeliveryMethod == false)
          return true;
        else if (voucher.deliveryRule == 'delivery' &&
            widget.isDeliveryMethod == true)
          return true;
        else
          return false;
      }
      return true;
    }

    String type = voucher.applyFor;
    List<CartItemModel> validList = [];
    for (var item in cartItems.values) {
      if (checkObj(voucher.discountObj, type, item) &&
          checkQuantity(item, type) &&
          checkPrice(item, type) &&
          checkSize(item, type) &&
          checkDelivery()) {
        validList.add(item);
      }
    }
    return {'valid': validList.isNotEmpty, 'validList': validList};
  }

  void setDiscountVoucher(voucher) {
    if (_discountSelected != null) {
      if (_discountSelected.id == voucher.id) {
        setState(() {
          _discountSelected = null;
        });
      } else {
        setState(() {
          _discountSelected = voucher;
        });
      }
    } else {
      setState(() {
        _discountSelected = voucher;
      });
    }
  }

  setShippingVoucher(voucher) {
    if (_shippingSelected != null) {
      if (_shippingSelected.id == voucher.id) {
        setState(() {
          _shippingSelected = null;
        });
      } else {
        setState(() {
          _shippingSelected = voucher;
        });
      }
    } else {
      setState(() {
        _shippingSelected = voucher;
      });
    }
  }
}