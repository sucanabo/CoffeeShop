import 'package:flutter/material.dart';

import './widgets/body.dart';

class SearchScreen extends StatelessWidget {
  static String routeName = '/search';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search product'),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
