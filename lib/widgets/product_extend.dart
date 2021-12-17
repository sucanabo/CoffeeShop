import 'package:flutter/material.dart';
import 'package:coffee_shop/values/values.dart';

class ProductExtend extends StatefulWidget {
  const ProductExtend({
    Key key,
    @required this.title,
    this.child,
  }) : super(key: key);
  final String title;
  final Widget child;

  @override
  _ProductExtendState createState() => _ProductExtendState();
}

class _ProductExtendState extends State<ProductExtend> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(),
              margin: EdgeInsets.only(right: 5.0),
              child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    backgroundColor: Colors.white),
              ),
            ),
          ),
          Expanded(
              flex: 7,
              child:
                  Align(alignment: Alignment.centerRight, child: widget.child)),
        ],
      ),
    );
  }
}

class ProductCheckBox extends StatefulWidget {
  const ProductCheckBox({Key key, this.handleCheck, this.initValue, this.title})
      : super(key: key);
  final Function handleCheck;
  final bool initValue;
  final String title;

  @override
  _ProductCheckBoxState createState() => _ProductCheckBoxState();
}

class _ProductCheckBoxState extends State<ProductCheckBox> {
  bool _initValue;
  String _title;
  @override
  void initState() {
    super.initState();
    _initValue = widget.initValue;
    _title = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bool newValue = !_initValue;
        setState(() {
          _initValue = newValue;
        });
        widget.handleCheck();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_initValue && _title != null) Text(_title),
          SizedBox(width: 20.0),
          Container(
            height: 25.0,
            width: 25.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: _initValue
                    ? Border.all(color: AppColors.primaryLightColor, width: 2.5)
                    : Border.all(color: Colors.grey[400], width: 2.5),
                color: _initValue ? AppColors.primaryLightColor : Colors.white),
            child: _initValue
                ? Icon(
                    Icons.check,
                    color: AppColors.primaryColor,
                    size: 20,
                  )
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}

class ProductDropDown extends StatefulWidget {
  const ProductDropDown(
      {Key key, this.handleSelect, this.data, this.initValue});
  final dynamic initValue;
  final List<dynamic> data;
  final Function handleSelect;

  @override
  _ProductDropDownState createState() => _ProductDropDownState();
}

class _ProductDropDownState extends State<ProductDropDown> {
  dynamic defaultValue;
  String title;
  @override
  void initState() {
    super.initState();
    defaultValue = widget.initValue ?? setDefault();
    title = defaultValue['title'];
  }

  dynamic setDefault() {
    widget.data.forEach((element) {
      if (element['default'] == 1) return element;
    });
    return widget.data[0];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (title != null) Text(title),
        SizedBox(width: 20.0),
        Container(
          height: 35.0,
          width: 75.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: AppColors.primaryMediumColor),
          child: Align(
            alignment: Alignment.center,
            child: DropdownButton(
                onChanged: (value) {
                  setState(() {
                    defaultValue = value;
                    title = defaultValue['title'];
                  });
                  widget.handleSelect(value);
                },
                value: defaultValue,
                hint: Text(
                  defaultValue['option_title'].toString(),
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                underline: SizedBox(),
                iconEnabledColor: Colors.white,
                dropdownColor: AppColors.primaryMediumColor,
                focusColor: AppColors.primaryMediumColor,
                items: List.generate(
                    widget.data.length,
                    (index) => DropdownMenuItem(
                        value: widget.data[index],
                        child: Text(
                          widget.data[index]['option_title']
                              .toString()
                              .capitalize(),
                          style: TextStyle(color: Colors.white),
                        )))),
          ),
        ),
      ],
    );
  }
}
