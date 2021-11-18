import 'package:coffee_shop/screens/profile/widgets/profile_avatar.dart';
import 'package:coffee_shop/screens/profile/widgets/profile_form.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String imPath;

  @override
  Widget build(BuildContext context) {
    return ScreenBody(
      appBar: AppBar(title: Text('Update profile')),
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
