import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseNotifications {
  FirebaseMessaging _messaging;
  BuildContext myContext;

  void setupFirebase(BuildContext context) {
    _messaging = FirebaseMessaging.instance;
    NotificationHandler.initNotification(context);
    firebaseCloudMessagingListener(context);
    _messaging.setAutoInitEnabled(true);
    _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
    );
    myContext = context;
  }

  void firebaseCloudMessagingListener(BuildContext context) async {
    NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
    print('Setting ${settings.authorizationStatus}');
    //Get token
    _messaging.getToken().then((token) => print('My token $token'));
    _messaging
        .subscribeToTopic("all")
        .whenComplete(() => print('Subscribe success.'));
    //Handle mess
    FirebaseMessaging.onMessage.listen((message) {
      print('Receive onMess $message');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        NotificationHandler.showNotification(
            id: notification.hashCode,
            body: notification.body,
            title: notification.title);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      print('Receive open app: $remoteMessage');
      if (Platform.isAndroid) {
        showDialog(
            context: myContext,
            builder: (context) => CupertinoAlertDialog(
                  title: Text(remoteMessage.notification.title),
                  content: Text(remoteMessage.notification.body),
                  actions: [
                    CupertinoDialogAction(
                      child: Text('OK'),
                      isDefaultAction: true,
                      onPressed: () {
                        print('clicked dialog');
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    )
                  ],
                ));
      }
    });
  }
}

class NotificationHandler {
  static final flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();
  static BuildContext myContext;
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
  static final onNotifications = BehaviorSubject<String>();
  static void initNotification(BuildContext context) async {
    context = context;
    final initAndroid = AndroidInitializationSettings("@mipmap/launcher_icon");
    final initIOS = IOSInitializationSettings();

    final initSetting =
        InitializationSettings(android: initAndroid, iOS: initIOS);
    await flutterLocalNotificationPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationPlugin.initialize(initSetting,
        onSelectNotification: (payload) async {
      onNotifications.add(payload);
    });
  }

  static Future showNotification(
          {int id = 0, @required String title, @required String body}) async =>
      flutterLocalNotificationPlugin.show(
          id,
          title,
          body,
          NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  channelDescription: channel.description,
                  icon: 'launch_background',
                  importance: Importance.max,
                  priority: Priority.max,
                  playSound: true,
                  ticker: 'ticker'),
              iOS: IOSNotificationDetails()));

  static Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    showDialog(
        context: myContext,
        builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(body),
              actions: [
                CupertinoDialogAction(
                  child: Text('OK'),
                  isDefaultAction: true,
                  onPressed: () {
                    print('clicked dialog');
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                )
              ],
            ));
  }
}
