import 'package:coffee_shop/screens/sign_up/widgets/signup_form.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ScreenBody(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Column(
              children: [
                Text(
                  LocaleKeys.great_to_see_you_here.tr(),
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: getWidth(28.0),
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  LocaleKeys.sign_up_couple_step.tr(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Expanded(child: Center(child: SignUpForm())),
          ],
        ));
  }
}
