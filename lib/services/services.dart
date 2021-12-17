library services;

import 'dart:convert';
import 'package:coffee_shop/models/models.dart';
import 'package:coffee_shop/providers/provider.dart';
import 'package:coffee_shop/screens/screens.dart';
import 'package:coffee_shop/untils/untils.dart';
import 'package:coffee_shop/values/values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//part
part 'category_service.dart';
part 'firebase_auth.dart';
part 'location_service.dart';
part 'order_service.dart';
part 'product_service.dart';
part 'reward_service.dart';
part 'user_service.dart';
part 'voucher_service.dart';
