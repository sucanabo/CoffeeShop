library screens;

import 'dart:async';
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
//===IMPORT===
import 'package:coffee_shop/models/models.dart';
import 'package:coffee_shop/providers/provider.dart';
import 'package:coffee_shop/services/services.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/untils/untils.dart';
import 'package:coffee_shop/values/values.dart';
import 'package:coffee_shop/widgets/widgets.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:tiengviet/tiengviet.dart';
//Address
part 'address/address_screen.dart';
part 'address/widgets/address_detail.dart';
part 'address/widgets/address_item.dart';
part 'address/widgets/body.dart';
part 'address/widgets/header.dart';
//Cart
part 'cart/cart_screen.dart';
part 'cart/widgets/body.dart';
part 'cart/widgets/cart_bottom_sheet.dart';
//Checkout
part 'checkout/checkout_screen.dart';
part 'checkout/widgets/checkout_choose_voucher.dart';
part 'checkout/widgets/checkout_popup.dart';
//Contact us
part 'contact_us/contact_us_screen.dart';
//Enter code
part 'enter_code/enter_code.dart';
//Favourite
part 'favourite_product/favourite_product_screen.dart';
part 'favourite_product/widgets/body.dart';
//Google map
part 'google_map/google_map_screen.dart';
//Home
part 'home/home_screen.dart';
part 'home/widgets/body.dart';
part 'home/widgets/home_carousel.dart';
//Loading
part 'loading/loading_screen.dart';
//Main body
part 'main_body.dart';
//More
part 'more/more_screen.dart';
part 'more/widgets/body.dart';
part 'more/widgets/more_tab.dart';
//Notificaiton
part 'notification/notification.dart';
part 'notification/notification_detail_screen.dart';
part 'notification/widgets/display_notifications.dart';
part 'notification/widgets/notification_item.dart';
part 'order/order_detail.dart';
//Order
part 'order/order_screeen.dart';
part 'order/widgets/transaction.dart';
//OTP
part 'otp/otp_screen.dart';
part 'otp/widgets/body.dart';
part 'otp/widgets/otp_form.dart';
//password
part 'password/change_password/change_password.dart';
part 'password/enter_password/enter_password.dart';
part 'password/forgot_password/forgot_password_screen.dart';
part 'password/forgot_password/widgets/body.dart';
part 'password/new_password/new_password_screen.dart';
//Product
part 'product/product_screen.dart';
part 'product/see_product_screen.dart';
part 'product/widgets/body.dart';
part 'product/widgets/floating_cart.dart';
part 'product/widgets/product_header.dart';
part 'product/widgets/tab_category.dart';
//Product detail
part 'product_detail/product_detail_screen.dart';
part 'product_detail/widgets/action_button.dart';
part 'product_detail/widgets/body.dart';
part 'product_detail/widgets/bottom_bar.dart';
part 'product_detail/widgets/heading.dart';
part 'product_detail/widgets/rating_dialog.dart';
//Profile
part 'profile/profile_screen.dart';
part 'profile/widgets/body.dart';
part 'profile/widgets/profile_avatar.dart';
part 'profile/widgets/profile_form.dart';
//Search
part 'search/search_screen.dart';
part 'search/widgets/body.dart';
part 'search/widgets/search_bar.dart';
//Sign in
part 'sign_in/sign_in_screen.dart';
part 'sign_in/widgets/body.dart';
part 'sign_in/widgets/sign_in_with.dart';
part 'sign_in/widgets/signin_form.dart';
//Sign up
part 'sign_up/sign_up_screen.dart';
part 'sign_up/widgets/body.dart';
part 'sign_up/widgets/signup_form.dart';
//Success
part 'success/success.dart';
//Voucher
part 'voucher/voucher_screen.dart';
part 'voucher/widgets/accumulate/accumulate_info_card.dart';
part 'voucher/widgets/accumulate/accumulate_tab.dart';
part 'voucher/widgets/body.dart';
part 'voucher/widgets/my_voucher/voucher_detail.dart';
part 'voucher/widgets/my_voucher/voucher_tab.dart';
part 'voucher/widgets/positioned_voucher.dart';
part 'voucher/widgets/reward/reward_detail.dart';
part 'voucher/widgets/reward/reward_tab.dart';
