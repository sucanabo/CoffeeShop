import 'package:coffee_shop/providers/auth_provider.dart';
import 'package:coffee_shop/screens/profile/widgets/profile_avatar.dart';
import 'package:coffee_shop/screens/profile/widgets/profile_form.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: false).getUser;

    return ScreenBody(
      child: ListView(padding: EdgeInsets.all(20.0), children: [
        ProfileAvatar(userImg: user.image),
        SizedBox(
          height: SizeConfig.screenHeigh * 0.05,
        ),
        ProfileForm()
      ]),
    );
  }
}
