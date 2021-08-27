import 'package:coffee_shop/screens/address/widgets/header.dart';
import 'package:flutter/material.dart';

import './widgets/body.dart';

class MoreScreen extends StatelessWidget {
  static String routeName = '/more';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          Header(expandHeight: 250, roundedContainerHeight: 50),
          SliverToBoxAdapter(
            child: Body(),
          )
        ],
      ),
    );
  }
}
