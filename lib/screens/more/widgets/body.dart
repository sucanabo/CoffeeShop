import 'package:coffee_shop/res.dart';
import 'package:coffee_shop/screens/address/address_screen.dart';
import 'package:coffee_shop/screens/favourite_product/favourite_product_screen.dart';
import 'package:coffee_shop/screens/more/widgets/more_tab.dart';
import 'package:coffee_shop/screens/order/order_screeen.dart';
import 'package:coffee_shop/screens/profile/profile_screen.dart';
import 'package:coffee_shop/services/user_service.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 0, bottom: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
          ),
          Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  MoreTab(
                    imgPath: Res.ic_note,
                    title: 'Transaction History',
                    onPressed: () {
                      Navigator.pushNamed(context, OrderScreen.routeName);
                    },
                  ),
                  MoreTab(
                    imgPath: Res.ic_heart_circle,
                    title: 'Your Favourite',
                    onPressed: () {
                      Navigator.pushNamed(
                          context, FavouriteProductScreen.routeName);
                    },
                  ),
                ],
              )),
          Divider(
            thickness: 1,
            height: 50.0,
          ),
          Text(
            'Support',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
          ),
          Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  MoreTab(
                    imgPath: Res.ic_message_text,
                    title: 'Contact us',
                  ),
                ],
              )),
          Divider(
            thickness: 1,
            height: 50.0,
          ),
          Text(
            'Account',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
          ),
          Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  MoreTab(
                    imgPath: Res.ic_profile,
                    title: 'Your account',
                    onPressed: () {
                      Navigator.of(context).pushNamed(ProfileScreen.routeName);
                    },
                  ),
                  MoreTab(
                    imgPath: Res.ic_location_tick,
                    title: 'Save Addresses',
                    onPressed: () {
                      Navigator.of(context).pushNamed(AddressScreen.routeName);
                    },
                  ),
                  MoreTab(
                    imgPath: Res.ic_setting,
                    title: 'Setting',
                  ),
                  MoreTab(
                    imgPath: Res.ic_logout,
                    title: 'Logout',
                    onPressed: () {
                      logout(context);
                    },
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
