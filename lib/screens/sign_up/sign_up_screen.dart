import 'package:coffee_shop/providers/firebase_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/body.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = '/sign_up';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final provider = Provider.of<FirebaseProvider>(context, listen: false);
        if (provider.user != null) {
          final User user = FirebaseAuth.instance.currentUser;
          user.delete();
          provider.clearUser();
        }
        return true;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              'Sign up',
            ),
          ),
          body: Body()),
    );
  }
}
