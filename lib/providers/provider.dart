library providers;

import 'dart:io';

import 'package:coffee_shop/models/models.dart';
import 'package:coffee_shop/screens/screens.dart';
import 'package:coffee_shop/services/services.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/values/values.dart';
import 'package:coffee_shop/widgets/widgets.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

//part
part 'auth_provider.dart';
part 'cart_provider.dart';
part 'category_provider.dart';
part 'firebase_provider.dart';
part 'language_provider.dart';
part 'location_provider.dart';
part 'navigation_provider.dart';
part 'notification_provider.dart';
part 'product_provider.dart';
part 'transaction_provider.dart';
part 'voucher_provider.dart';
