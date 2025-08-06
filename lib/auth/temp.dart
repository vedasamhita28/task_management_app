import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:task_management_app/constants/router_names.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
AndroidNotificationDetails androidChannel = const AndroidNotificationDetails(
  'high_importance_channel', // id
  'call_channel', // title
  channelDescription:
      'This channel is used for app notifications.', // description
  importance: Importance.high,
  priority: Priority.high,
  playSound: true,
  visibility: NotificationVisibility.public,
);

class NotificationsInit extends ChangeNotifier {
  static final NotificationsInit _instance = NotificationsInit._internal();

  factory NotificationsInit() {
    return _instance;
  }

  NotificationsInit._internal();

  static initNotifications() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    var androiInit = const AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    var initSetting = InitializationSettings(
        android: androiInit, iOS: initializationSettingsDarwin);

    flutterLocalNotificationsPlugin.initialize(
      initSetting,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            break;
          case NotificationResponseType.selectedNotificationAction:
            break;
        }
      },
    );

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      // navigatorKey.currentState!.context.pushNamed(RouteNames.splash);
    }

    // FirebaseMessaging.instance.getToken();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // navigatorKey.currentState!.context.pushNamed(RouteNames.splash);
    });

    var generalNotificationDetails =
        NotificationDetails(android: androidChannel);

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      RemoteNotification? notification = message!.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? ios = message.notification?.apple;

      if (notification != null && (android != null || ios != null)) {
        flutterLocalNotificationsPlugin.show(notification.hashCode,
            notification.title, notification.body, generalNotificationDetails);
      }
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {}
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}
