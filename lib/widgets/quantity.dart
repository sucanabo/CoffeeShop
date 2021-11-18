import 'package:coffee_shop/values/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class Quantity extends StatefulWidget {
  final int initValue;
  final Function onChange;
  final bool cicleStyle;
  Quantity(
      {@required this.initValue, @required this.onChange, this.cicleStyle});
  @override
  _QuantityState createState() => _QuantityState();
}

class _QuantityState extends State<Quantity> {
  int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initValue;
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _quantity = widget.initValue;
  }

  void minusPress() {
    if (_quantity > 1) {
      setState(() {
        _quantity -= 1;
      });
      widget.onChange(_quantity);
    }
  }

  void plusPress() {
    setState(() {
      _quantity += 1;
    });
    widget.onChange(_quantity);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cicleStyle == true) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: 25.0,
              height: 25.0,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.transparent,
                      padding: EdgeInsets.all(0),
                      side: BorderSide(width: 2, color: AppColors.primaryMediumColor),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0))),
                  onPressed: () => minusPress(),
                  child: Center(
                      child: LineIcon.minus(
                    color: AppColors.primaryMediumColor,
                    size: 22.0,
                  )))),
          Container(
            child: Text(
              _quantity.toString(),
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
              width: 25.0,
              height: 25.0,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: AppColors.primaryMediumColor,
                      padding: EdgeInsets.all(0),
                      side: BorderSide(width: 2, color: AppColors.primaryMediumColor),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0))),
                  onPressed: () => plusPress(),
                  child: Center(
                      child: LineIcon.plus(
                    size: 22.0,
                  ))))
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 40.0,
          width: 40.0,
          child: ElevatedButton(
              onPressed: () => minusPress(),
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.white,
                  padding: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: AppColors.primaryMediumColor),
                      borderRadius: BorderRadius.circular(10.0))),
              child: Icon(
                LineIcons.minus,
                color: AppColors.primaryMediumColor,
              )),
        ),
        Text(
          _quantity.toString(),
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 40.0,
          width: 40.0,
          child: ElevatedButton(
              onPressed: () => plusPress(),
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: AppColors.primaryMediumColor,
                  padding: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0))),
              child: Icon(
                LineIcons.plus,
                color: Colors.white,
              )),
        ),
      ],
    );
  }
}
