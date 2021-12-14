import 'package:coffee_shop/models/address.dart';
import 'package:coffee_shop/models/cart_item.dart';
import 'package:coffee_shop/models/tomtom_routes.dart';
import 'package:coffee_shop/models/voucher.dart';
import 'package:coffee_shop/providers/auth_provider.dart';
import 'package:coffee_shop/providers/cart_provider.dart';
import 'package:coffee_shop/res.dart';
import 'package:coffee_shop/screens/address/address_screen.dart';
import 'package:coffee_shop/screens/checkout/widgets/checkout_choose_voucher.dart';
import 'package:coffee_shop/screens/checkout/widgets/checkout_popup.dart';
import 'package:coffee_shop/screens/success.dart';
import 'package:coffee_shop/services/location_service.dart';
import 'package:coffee_shop/services/order_service.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:coffee_shop/widgets/message_box.dart';
import 'package:coffee_shop/widgets/pill_button.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class CheckoutScreen extends StatefulWidget {
  static String routeName = '/checkout';
  CheckoutScreen({Key key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  CartProvider _cartProvider;
  AuthProvider _addressProvider;
  AddressModel _address;
  Map<String, dynamic> _voucherData;
  bool _isDeleverySelected = true;
  double _deliveryPrice = 0;
  Map _orderInfo;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _txtMessage = TextEditingController();
  @override
  void initState() {
    _cartProvider = Provider.of<CartProvider>(context, listen: false);
    _addressProvider = Provider.of<AuthProvider>(context, listen: false);
    if (_addressProvider.addressLoading) {
      fetchAddress();
    } else {
      _address = _addressProvider.addresses[0];
      caculateShipping();
    }

    _voucherData = {
      'shippingVoucher': null,
      'discountVoucher': null,
      'cartItemValid': null
    };
    _orderInfo = caculateOrder();
    super.initState();
  }

  placeOrder() async {
    bool addressCheck = _address != null;
    if (!addressCheck) {
      _addressProvider.setAddressLoading(true);
      fetchAddress();
      return;
    }
    String promoStr = _voucherData['shippingVoucher'] != null
        ? _voucherData['shippingVoucher'].id.toString()
        : '';
    promoStr += _voucherData['discountVoucher'] != null
        ? _voucherData['discountVoucher'].id.toString()
        : '';
    setLoading(context, loading: true);

    final response = await createOrder(
        addressId: _address.id,
        content: _txtMessage.text.trim(),
        deliveryMethod: _isDeleverySelected ? 'delivery' : 'pickup',
        subtotal: _cartProvider.totalAmount,
        shippingCost: _deliveryPrice,
        voucherDiscount: _orderInfo['voucherDiscount'],
        shippingDiscount: _orderInfo['deliveryDiscount'],
        grandtotal: _orderInfo['orderTotal'],
        items: _cartProvider.items.values.map((item) => item).toList(),
        promo: promoStr);
    setLoading(context, loading: false);
    if (response.error == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SuccessScreen()),
          (route) => false);
    } else {
      showToast(response.error);
    }
  }

  fetchAddress() async {
    await _addressProvider.fetAddresses();
    _addressProvider.setAddressLoading(false);
    if (_addressProvider.addresses.isNotEmpty) {
      _address = _addressProvider.addresses[0];
    } else {
      CheckOutPopUp.addressNull(context, (result) {
        setState(() {
          if (result != null)
            _address = _addressProvider.addresses
                .firstWhere((element) => element.id == result);
        });
      });
    }
    caculateShipping();
  }

  changeAddress() async {
    dynamic result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddressScreen(isChooseAddress: true)));
    if (result != null) {
      setState(() {
        _address = _addressProvider.addresses
            .firstWhere((element) => element.id == result['id']);
        caculateShipping();
      });
    }
  }

  caculateShipping() async {
    TomtomRoutes route =
        await GeolocatorService().getTomtomRoutes(_address.coordinates);
    setState(() {
      _deliveryPrice = route.routes[0].summary.lengthInMeters / 1000 * 5000;
      _orderInfo = caculateOrder();
    });
  }

  chooseVoucher() async {
    final bool isEdit = _voucherData['shippingVoucher'] != null ||
        _voucherData['discountVoucher'] != null;
    print(
        '${_voucherData['shippingVoucher']}, ${_voucherData['discountVoucher']}');
    print('isEdit: $isEdit');
    dynamic result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ChooseVoucher(
            isDeliveryMethod: _isDeleverySelected, isEdit: isEdit),
        settings: isEdit ? RouteSettings(arguments: _voucherData) : null));
    if (result['shippingVoucher'] != _voucherData['shippingVoucher'] ||
        result['discountVoucher'] != _voucherData['discountVoucher']) {
      setState(() {
        _voucherData = result;
        _orderInfo = caculateOrder();
      });
    }
  }
  Map caculateOrder() {
    double subtotal = _cartProvider.totalAmount;
    double deliveryPrice = _isDeleverySelected ? _deliveryPrice : 0;
    double deliveryDiscount;
    double voucherDiscount;
    if (_voucherData['shippingVoucher'] != null) {
      final VoucherModel shipping = _voucherData['shippingVoucher'];
      switch (shipping.discountUnit) {
        case 'cash':
          deliveryDiscount = shipping.discount * 1000.0;
          break;
        case 'percent':
          deliveryDiscount = _deliveryPrice * (shipping.discount / 100);
          break;
        default:
          deliveryDiscount = 0;
      }
    } else {
      deliveryDiscount = 0;
    }
    if (_voucherData['discountVoucher'] != null) {
      final VoucherModel discount = _voucherData['discountVoucher'];
      final List<CartItemModel> validCartItem = _voucherData['cartItemValid'];
      final int validCartItemQuantity = validCartItem.fold(
          0, (previousValue, element) => previousValue + element.quantity);
      final double validCartItemPrice = validCartItem.fold(
          0.0, (previousValue, element) => previousValue + element.price);
      switch (discount.applyFor) {
        case 'order':
          if (discount.discountUnit == 'cash') {
            voucherDiscount = discount.discount * 1000.0;
          } else if (discount.discountUnit == 'percent') {
            voucherDiscount = subtotal * (discount.discount / 100);
          } else
            voucherDiscount = 0;
          break;
        case 'product':
        case 'category':
          int validQuantity = discount.maxQuantity != null &&
                  validCartItemQuantity > discount.maxQuantity
              ? discount.maxQuantity
              : validCartItemQuantity;
          if (discount.discountUnit == 'cash') {
            voucherDiscount = validQuantity * (discount.discount * 1000.0);
          } else if (discount.discountUnit == 'percent') {
            voucherDiscount = validQuantity *
                (validCartItemPrice * (discount.discount / 100));
          }
          if (discount.maxPrice != null && voucherDiscount > discount.maxPrice)
            voucherDiscount = discount.maxPrice;
          break;
      }
    } else {
      voucherDiscount = 0;
    }
    return {
      'subtotal': subtotal,
      'deliveryPrice': deliveryPrice,
      'deliveryDiscount': deliveryDiscount,
      'voucherDiscount': voucherDiscount,
      'orderTotal':
          subtotal + deliveryPrice - deliveryDiscount - voucherDiscount
    };
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBody(
        appBar: AppBar(
          title: Text(LocaleKeys.checkout.tr()),
        ),
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 6,
                  child: Text(
                    LocaleKeys.deliver_address.tr(),
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: InkWell(
                    onTap: () => changeAddress(),
                    child: Text(
                      LocaleKeys.change.tr(),
                      style: TextStyle(
                          fontSize: 12.0, color: AppColors.primaryColor),
                      textAlign: TextAlign.end,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10.0),
            _buildAddressInformation(),
            Divider(height: 20.0),
            Text(
              LocaleKeys.delivery_method.tr(),
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20.0),
            buildDeliveryOptions(),
            Divider(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 6,
                  child: Text(
                    LocaleKeys.payment_method.tr(),
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      LocaleKeys.change.tr(),
                      style: TextStyle(
                          fontSize: 12.0, color: AppColors.primaryColor),
                      textAlign: TextAlign.end,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2, child: Image.asset(Res.momoLogo)),
                Expanded(
                    flex: 10,
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mo Mo Wallet',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            '(84) 837.695.292',
                            style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.grey[800],
                                letterSpacing: 1.05),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
            SizedBox(height: 20.0),
            InkWell(
              onTap: () => chooseVoucher(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.shop_voucher.tr(),
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 25.0,
                    color: AppColors.primaryColor,
                  )
                ],
              ),
            ),
            if (_voucherData != null) buildVoucherList(),
            SizedBox(height: 20.0),
            MessageBox(
              formKey: _formKey,
              controller: _txtMessage,
              maxLine: 5,
              fillColor: AppColors.primaryLightColor,
            ),
            SizedBox(height: 20.0),
            Text(
              LocaleKeys.sumary.tr(),
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkColor),
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    createTable(),
                    SizedBox(
                      height: 10.0,
                    ),
                    PillButton(
                        child: Text(LocaleKeys.place_order.tr()),
                        onPressed: () => placeOrder(),
                        color: AppColors.primaryColor),
                  ],
                ))
          ],
        ));
  }

  Widget _buildAddressInformation() {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) => provider.addressLoading
          ? Align(
              child: SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation(AppColors.primaryColor))))
          : provider.addresses.isEmpty
              ? Text(LocaleKeys.no_shipping_address.tr())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _address.receiverName ??
                          provider.addresses[0].receiverName,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, height: 1.5),
                    ),
                    Text(
                        _address.receiverPhone ??
                            provider.addresses[0].receiverPhone,
                        style: TextStyle(
                            height: 1.2,
                            fontSize: 13.0,
                            color: Colors.grey[700])),
                    Text(_address.address ?? provider.addresses[0].address,
                        style: TextStyle(
                            height: 1.2,
                            fontSize: 13.0,
                            color: Colors.grey[700])),
                  ],
                ),
    );
  }

  Widget createTable() {
    return Table(children: [
      TableRow(children: [
        Text(
          LocaleKeys.subtotal.tr(),
          style: TextStyle(),
        ),
        Text(
          convertVND(_cartProvider.totalAmount),
          textAlign: TextAlign.end,
        )
      ]),
      TableRow(children: [
        Text(
          LocaleKeys.shipping.tr(),
          style: TextStyle(),
        ),
        Text(
          convertVND(_deliveryPrice),
          textAlign: TextAlign.end,
        )
      ]),
      if (_voucherData['shippingVoucher'] != null)
        TableRow(children: [SizedBox(height: 5.0), SizedBox(height: 5.0)]),
      if (_voucherData['discountVoucher'] != null)
        TableRow(children: [
          Text(
            LocaleKeys.voucher_discount.tr(),
            style: TextStyle(),
          ),
          Text(
            '- ' + convertVND(_orderInfo['voucherDiscount']),
            textAlign: TextAlign.end,
          )
        ]),
      if (_voucherData['shippingVoucher'] != null)
        TableRow(children: [SizedBox(height: 5.0), SizedBox(height: 5.0)]),
      if (_voucherData['shippingVoucher'] != null)
        TableRow(children: [
          Text(
            LocaleKeys.shipping_discount.tr(),
            style: TextStyle(),
          ),
          Text(
            '- ' + convertVND(_orderInfo['deliveryDiscount']),
            textAlign: TextAlign.end,
          )
        ]),
      TableRow(children: [Divider(height: 15.0), Divider(height: 15.0)]),
      TableRow(children: [
        Text(
          LocaleKeys.order_total.tr(),
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor),
        ),
        Text(
          convertVND(_orderInfo['orderTotal']),
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor),
          textAlign: TextAlign.end,
        )
      ]),
    ]);
  }

  Widget buildVoucherList() {
    List list = [];
    _voucherData.forEach((key, value) {
      if (value != null && key != 'cartItemValid') list.add(value);
    });
    return ListView.separated(
      shrinkWrap: true,
      itemCount: list.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) => Container(
        color: AppColors.primaryLightColor,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              list[index].applyFor.toString().capitalize(),
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(list[index].discountUnit == 'cash'
                ? convertVND(list[index].discount * 1000.0)
                : '${list[index].discount} %')
          ],
        ),
      ),
    );
  }

  Column buildDeliveryOptions() {
    return Column(children: <LabeledRadio>[
      LabeledRadio(
        label: LocaleKeys.pick_up_at_shop.tr(),
        rightLabel: LocaleKeys.free.tr(),
        padding: const EdgeInsets.all(0.0),
        value: false,
        groupValue: _isDeleverySelected,
        onChanged: (bool newValue) {
          setState(() {
            _isDeleverySelected = newValue;
          });
        },
      ),
      LabeledRadio(
        label: LocaleKeys.delivery.tr(),
        rightLabel: convertVND(_deliveryPrice),
        padding: const EdgeInsets.all(0.0),
        value: true,
        groupValue: _isDeleverySelected,
        onChanged: (bool newValue) {
          setState(() {
            _isDeleverySelected = newValue;
          });
        },
      )
    ]);
  }
}

class LabeledRadio extends StatelessWidget {
  const LabeledRadio(
      {@required this.label,
      @required this.padding,
      @required this.groupValue,
      @required this.value,
      @required this.onChanged,
      @required this.rightLabel});

  final String label;
  final String rightLabel;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Container(
              height: 30.0,
              child: Radio<bool>(
                activeColor: AppColors.primaryColor,
                groupValue: groupValue,
                value: value,
                onChanged: (bool newValue) {
                  onChanged(newValue);
                },
              ),
            ),
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Expanded(
                child: Text(
              rightLabel,
              textAlign: TextAlign.end,
              style: TextStyle(fontWeight: FontWeight.w600),
            ))
          ],
        ),
      ),
    );
  }
}
