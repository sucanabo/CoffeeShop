import 'package:coffee_shop/providers/navigation_provider.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenBody extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final bool isHomeScreen;
  final AppBar appBar;
  final bool resizeToAvoidBottomInset;
  const ScreenBody(
      {@required this.child,
      this.margin,
      this.padding,
      this.isHomeScreen = false,
      this.resizeToAvoidBottomInset = true,
      this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Stack(
        children: [
          Scaffold(
            appBar: appBar,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isHomeScreen)
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Welcome to',
                            style:
                                TextStyle(fontSize: 26.0, color: Colors.white)),
                        Text('KOFEHOLIC',
                            style: TextStyle(
                                fontSize: 36.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                Expanded(
                  child: Container(
                    margin: margin,
                    padding: padding ?? EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                        color: Colors.white),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
          Consumer<NavigationProvider>(
              builder: (context, provider, child) => provider.loading
                  ? Container(
                      decoration: BoxDecoration(
                          color: AppColors.blackColor.withOpacity(0.3)),
                      child: Center(
                          child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: getWidth(30.0),
                            vertical: getHeight(20.0)),
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 20.0,
                                width: 20.0,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.primaryColor)),
                              ),
                              SizedBox(width: getWidth(10.0)),
                              Text('Please wait ...'),
                            ]),
                      )),
                    )
                  : SizedBox.shrink())
        ],
      ),
    );
  }
}
