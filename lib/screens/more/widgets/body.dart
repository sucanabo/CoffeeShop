import 'package:coffee_shop/screens/address/address_screen.dart';
import 'package:coffee_shop/screens/favourite_product/favourite_product_screen.dart';
import 'package:coffee_shop/screens/more/widgets/more_tab.dart';
import 'package:coffee_shop/screens/profile/profile_screen.dart';
import 'package:coffee_shop/screens/sign_in/sign_in_screen.dart';
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
                    imgPath: 'assets/icons/transaction_history.svg',
                    title: 'Transaction History',
                  ),
                  MoreTab(
                    imgPath: 'assets/icons/your_favourite.svg',
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
                    imgPath: 'assets/icons/contact_us.svg',
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
                    imgPath: 'assets/icons/account.svg',
                    title: 'Your account',
                    onPressed: () {
                      Navigator.of(context).pushNamed(ProfileScreen.routeName);
                    },
                  ),
                  MoreTab(
                    imgPath: 'assets/icons/location.svg',
                    title: 'Save Addresses',
                    onPressed: () {
                      Navigator.of(context).pushNamed(AddressScreen.routeName);
                    },
                  ),
                  MoreTab(
                    imgPath: 'assets/icons/setting.svg',
                    title: 'Setting',
                  ),
                  MoreTab(
                    imgPath: 'assets/icons/logout.svg',
                    title: 'Logout',
                    onPressed: () {
                      logout().then((value) => Navigator.of(context)
                          .pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()),
                              (route) => false));
                    },
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
