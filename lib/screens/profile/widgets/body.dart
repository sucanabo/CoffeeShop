import 'package:coffee_shop/screens/profile/widgets/profile_avatar.dart';
import 'package:coffee_shop/screens/profile/widgets/profile_form.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/values/values.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String imPath;

  @override
  Widget build(BuildContext context) {
    return ScreenBody(
      appBar: AppBar(title: Text(LocaleKeys.update_profile.tr())),
      child: ListView(padding: EdgeInsets.all(20.0), children: [
        ProfileAvatar(onChanged: (value) {
          setState(() {
            imPath = value;
          });
        }),
        SizedBox(
          height: SizeConfig.screenHeigh * 0.05,
        ),
        ProfileForm(imgPath: imPath),
      ]),
    );
  }
}
