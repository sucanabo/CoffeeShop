import 'package:coffee_shop/res.dart';
import 'package:coffee_shop/screens/address/address_screen.dart';
import 'package:coffee_shop/screens/contact_us/contact_us_screen.dart';
import 'package:coffee_shop/screens/favourite_product/favourite_product_screen.dart';
import 'package:coffee_shop/screens/more/widgets/more_tab.dart';
import 'package:coffee_shop/screens/order/order_screeen.dart';
import 'package:coffee_shop/screens/password/change_password/change_password.dart';
import 'package:coffee_shop/screens/profile/profile_screen.dart';
import 'package:coffee_shop/services/user_service.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.service.tr(),
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
          ),
          Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  MoreTab(
                    imgPath: Res.ic_note,
                    title: LocaleKeys.transaction_history.tr(),
                    onPressed: () {
                      Navigator.pushNamed(context, OrderScreen.routeName);
                    },
                  ),
                  MoreTab(
                    imgPath: Res.ic_heart_circle,
                    title: LocaleKeys.favourite.tr(),
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
            LocaleKeys.support.tr(),
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
          ),
          Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  MoreTab(
                    imgPath: Res.ic_message_text,
                    title: LocaleKeys.contact_us.tr(),
                    onPressed: () => Navigator.of(context)
                        .pushNamed(ContactUsScreen.routeName),
                  ),
                ],
              )),
          Divider(
            thickness: 1,
            height: 50.0,
          ),
          Text(
            LocaleKeys.account.tr(),
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
          ),
          Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  MoreTab(
                    imgPath: Res.ic_profile,
                    title: LocaleKeys.account_info.tr(),
                    onPressed: () {
                      Navigator.of(context).pushNamed(ProfileScreen.routeName);
                    },
                  ),
                  MoreTab(
                    imgPath: Res.ic_location_tick,
                    title: LocaleKeys.save_address.tr(),
                    onPressed: () {
                      Navigator.of(context).pushNamed(AddressScreen.routeName);
                    },
                  ),
                  MoreTab(
                    imgPath: Res.ic_lock2,
                    title: LocaleKeys.change_password.tr(),
                    onPressed: () => Navigator.of(context)
                        .pushNamed(ChangePassword.routeName),
                  ),
                  MoreTab(
                    imgPath: Res.ic_logout,
                    title: LocaleKeys.logout.tr(),
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
