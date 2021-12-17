import 'package:coffee_shop/providers/provider.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/values/values.dart';
import 'package:coffee_shop/widgets/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
class SignInWith extends StatefulWidget {
  @override
  _SignInWithState createState() => _SignInWithState();
}

class _SignInWithState extends State<SignInWith> {
  bool _isSignIn = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirebaseProvider>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _isSignIn
            ? Align(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              )
            : PillButton(
                elevation: 1,
                color: Colors.white,
                onPressed: () {
                  provider.googleAuth(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LineIcon.googlePlusG(
                      color: Colors.red[500],
                      size: 30.0,
                    ),
                    Text(
                      LocaleKeys.sign_in_with.tr(args: ['Google']),
                      style:
                          TextStyle(color: AppColors.textColor, fontSize: 16.0),
                    ),
                    LineIcon.arrowRight(
                      color: AppColors.textColor,
                      size: 25.0,
                    )
                  ],
                ),
              ),
        SizedBox(height: 10.0),
        PillButton(
          elevation: 1,
          color: Colors.white,
          onPressed: () {provider.facebookLogin(context);},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LineIcon.facebookF(
                color: Colors.blue[500],
                size: 25.0,
              ),
              Text(
                LocaleKeys.sign_in_with.tr(args: ['Facebook']),
                style: TextStyle(color: AppColors.textColor, fontSize: 16.0),
              ),
              LineIcon.arrowRight(
                color: AppColors.textColor,
                size: 25.0,
              )
            ],
          ),
        ),
      ],
    );
  }
}
