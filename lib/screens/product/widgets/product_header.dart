import 'package:coffee_shop/screens/search/search_screen.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class ProductHeader extends StatelessWidget {
  final int indexTab;
  final Function setIndex;
  const ProductHeader({@required this.indexTab, @required this.setIndex});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          child: Container(
            height: 45.0,
          ),
        ),
        Positioned(
          top: -35.0,
          left: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            height: 70.0,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 4.0,
                  spreadRadius: 5.0),
            ], color: Colors.white, borderRadius: BorderRadius.circular(50.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    flex: 5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(50, 50),
                          shape: StadiumBorder(),
                          padding: EdgeInsets.all(0.0),
                          elevation: 0.0,
                          primary:
                              indexTab == 0 ? primaryColor : primaryLightColor),
                      onPressed: () {
                        if (indexTab != 0) setIndex(0);
                      },
                      child: Text(
                        'Drinks',
                        style: TextStyle(
                            color: indexTab == 0 ? Colors.white : primaryColor,
                            fontSize: 20.0),
                      ),
                    )),
                SizedBox(
                  width: 15.0,
                ),
                Expanded(
                    flex: 5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(50, 50),
                          shape: StadiumBorder(),
                          padding: EdgeInsets.all(0.0),
                          elevation: 0.0,
                          primary:
                              indexTab == 1 ? primaryColor : primaryLightColor),
                      onPressed: () {
                        if (indexTab != 1) setIndex(1);
                      },
                      child: Text(
                        'Foods',
                        style: TextStyle(
                            color: indexTab == 1 ? Colors.white : primaryColor,
                            fontSize: 20.0),
                      ),
                    )),
                SizedBox(width: 15.0),
                Expanded(
                    flex: 2,
                    child: SizedBox.expand(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(0.0),
                            shape: CircleBorder(
                                side: BorderSide(color: primaryColor)),
                            onPrimary: primaryMediumColor,
                            elevation: 0.0,
                            primary: Colors.white),
                        onPressed: () => Navigator.pushNamed(
                            context, SearchScreen.routeName),
                        child: LineIcon.search(color: primaryColor, size: 25.0),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
