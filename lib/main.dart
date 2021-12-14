import 'package:coffee_shop/providers/auth_provider.dart';
import 'package:coffee_shop/providers/cart_provider.dart';
import 'package:coffee_shop/providers/category_provider.dart';
import 'package:coffee_shop/providers/firebase_provider.dart';
import 'package:coffee_shop/providers/language_provider.dart';
import 'package:coffee_shop/providers/location_provider.dart';
import 'package:coffee_shop/providers/navigation_provider.dart';
import 'package:coffee_shop/providers/product_provider.dart';
import 'package:coffee_shop/providers/transaction_provider.dart';
import 'package:coffee_shop/providers/voucher_provider.dart';
import 'package:coffee_shop/routes.dart';
import 'package:coffee_shop/screens/loading/loading_screen.dart';
import 'package:coffee_shop/translations/codegen_loader.g.dart';
import 'package:coffee_shop/untils/languages.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: LanguageProvider.localizations,
      path: 'assets/translations',
      fallbackLocale: Languages.vi,
      assetLoader: CodegenLoader(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseProvider>(
            create: (_) => FirebaseProvider()),
        ChangeNotifierProvider<NavigationProvider>(
            create: (_) => NavigationProvider()),
        ChangeNotifierProvider<ProductProvider>(
            create: (_) => ProductProvider()),
        ChangeNotifierProvider<CategoryProvider>(
            create: (_) => CategoryProvider()),
        ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<VoucherProvider>(
            create: (_) => VoucherProvider()),
        ChangeNotifierProvider<TransactionProvider>(
            create: (_) => TransactionProvider()),
        ChangeNotifierProvider<LocationProvider>(
            create: (_) => LocationProvider()),
        ChangeNotifierProvider<LanguageProvider>(
            create: (_) => LanguageProvider()),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        initialRoute: LoadingScreen.routeName,
        routes: routes,
        theme: theme(),
        color: AppColors.darkColor,
      ),
    );
  }
}

Future<void> _backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handle background service ${message.messageId}');
}
