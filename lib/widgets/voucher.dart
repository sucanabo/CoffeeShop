import 'package:coffee_shop/models/voucher.dart';
import 'package:coffee_shop/providers/voucher_provider.dart';
import 'package:coffee_shop/screens/voucher/widgets/my_voucher/voucher_detail.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:coffee_shop/widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';

class VoucherWidget extends StatefulWidget {
  final VoucherModel voucher;
  final bool isUserVoucher;
  final bool enable;
  final Function chooseVoucherPress;
  final bool initChoose;
  const VoucherWidget({
    @required this.voucher,
    @required this.isUserVoucher,
    this.enable = true,
    this.chooseVoucherPress,
    this.initChoose,
    Key key,
  }) : super(key: key);

  @override
  _VoucherWidgetState createState() => _VoucherWidgetState();
}

class _VoucherWidgetState extends State<VoucherWidget> {
  bool isSaved;
  VoucherProvider provider;
  bool _isChoose;
  @override
  void initState() {
    super.initState();
    provider = Provider.of<VoucherProvider>(context, listen: false);
    isSaved = provider.isVoucherSaved(widget.voucher.id);
    _isChoose = widget.initChoose ?? false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  onChangeChoose() {
    setState(() {
      _isChoose = !_isChoose;
    });
    widget.chooseVoucherPress(widget.voucher);
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        if (widget.enable) {
          widget.chooseVoucherPress != null
              ? onChangeChoose()
              : showSheet(context);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/voucher_background.png'),
                colorFilter: widget.enable
                    ? null
                    : ColorFilter.mode(Colors.grey[300], BlendMode.srcATop),
                fit: BoxFit.fill)),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Container(
                    child: widget.voucher.discountUnit != null
                        ? _buidDefaultVoucher()
                        : Container(
                            height: 80,
                            padding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image(
                                image:
                                    base64StringToImage(widget.voucher.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  )),
              Expanded(
                flex: 8,
                child: Stack(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.voucher.title,
                              style: TextStyle(fontSize: 16.0),
                              maxLines: 2,
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                widget.chooseVoucherPress != null
                                    ? InkWell(
                                        onTap: () => showSheet(context),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            LineIcon.angleRight(
                                              size: 13.0,
                                              color: darkColor,
                                            ),
                                            Text(
                                              'Rules',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: darkColor),
                                            ),
                                          ],
                                        ))
                                    : Text(
                                        formartDate(widget.voucher.expiryDate),
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                if (!widget.isUserVoucher)
                                  _buildSaveButton(isSaved, provider, context)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack _buidDefaultVoucher() {
    return new Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                height: 80.0,
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.topCenter + Alignment(0, 0.3),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0), color: primaryColor),
            child: Text(
              widget.voucher.applyFor.capitalize(),
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center + Alignment(0, 0.3),
          child: Text(
            widget.voucher.discountUnit == 'cash'
                ? '\đ${widget.voucher.discount}'
                : '${widget.voucher.discount}%',
            style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.w600,
                color: primaryColor),
          ),
        )
      ],
    );
  }

  InkWell _buildSaveButton(
      bool isSaved, VoucherProvider provider, BuildContext context) {
    return new InkWell(
      onTap: () {
        if (this.isSaved == false) {
          this.setState(() {
            this.isSaved = true;
          });
          Future<bool> success = provider.saveVoucher(this.widget.voucher.id);
          // ignore: unrelated_type_equality_checks
          if (success == false) {
            showMess(context: context, text: 'Save voucher failed.');
            this.setState(() {
              this.isSaved = false;
            });
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: isSaved ? Colors.grey : darkColor),
        child: Text(
          'Save',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future showSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => openBottomSheet(
            context: context, child: VoucherDetail(voucher: widget.voucher)));
  }
}

class CardItem extends StatelessWidget {
  final Map item;
  const CardItem({@required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: primaryLightColor,
      onTap: () {
        print('hi');
      },
      child: Container(
        width: SizeConfig.screenWidth * 0.43,
        height: SizeConfig.screenHeigh * 0.10,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: Offset(5, 5),
                  blurRadius: 6.0,
                  spreadRadius: 3.0),
            ],
            borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: primaryLightColor),
                child: SvgPicture.asset('assets/icons/${item['icon']}'),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  item['text'],
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
