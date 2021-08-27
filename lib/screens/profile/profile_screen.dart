import 'package:flutter/material.dart';

import './widgets/body.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Update profile')), body: Body());
  }
}
