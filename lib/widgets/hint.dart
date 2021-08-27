import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class Hint extends StatefulWidget {
  final String title;
  final Colors background;
  final Colors textColor;
  Hint({this.title, this.background, this.textColor});

  @override
  _HintState createState() => _HintState();
}

class _HintState extends State<Hint> {
  String _title;
  bool _active;

  @override
  void initState() {
    super.initState();
    _title = widget.title;
    _active = true;
  }

  @override
  Widget build(BuildContext context) {
    return _active
        ? Container(
            width: SizeConfig.screenWidth,
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                color: widget.background ?? primaryLightColor,
                borderRadius: BorderRadius.circular(8.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 11,
                  child: Text(
                    'Hint: $_title',
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                        color: widget.textColor ?? textColor),
                  ),
                ),
                Flexible(
                    flex: 1,
                    child: IconButton(
                      padding: EdgeInsets.all(0),
                      alignment: Alignment.centerRight,
                      icon: LineIcon.times(
                        size: 20.0,
                        color: textColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _active = false;
                        });
                      },
                    ))
              ],
            ),
          )
        : Container();
  }
}
