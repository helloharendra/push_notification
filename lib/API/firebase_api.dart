import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push_notification/main.dart';
import 'package:push_notification/screens.dart/notification_screen.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title:  ${message.notification!.title}');
  print('Body:  ${message.notification!.body}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High  Importance Notifications',
    description: 'This channel is used for important notification',
    importance: Importance.defaultImportance,
  );
  final localNotificatios = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message != null) return;
    navigatorKey.currentState
        ?.pushNamed(NotificationScreen.route, arguments: message);
  }

  Future initNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then((handleMessage));
    FirebaseMessaging.onMessageOpenedApp.listen((handleMessage));
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      localNotificatios.show(
        notification.hashCode,
        notification.title!,
        notification.body!,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/ic_launcher',
          ),
        ),
        payload:jsonEncode(message.toMap()),
      );
    });
  }

  Future initLocalNotifications() async {
const iOS =DarwinInitializationSettings();
const android =AndroidInitializationSettings('@drawable/ic_launcher');
const settings=InitializationSettings(android: android,iOS: iOS);
await localNotificatios.initialize(
  settings,onDidReceiveNotificationResponse:(payload){
    final message=RemoteMessage.fromMap(jsonDecode(payload as String));
    handleMessage(message);
  }
);
  final platForm=localNotificatios.resolvePlatformSpecificImplementation<
  AndroidFlutterLocalNotificationsPlugin>();
  // await platform?.createNotiFicationChannel(_androidChannel);

  }


  Future<void> initPushNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("FCM Token : $fCMToken");
    initPushNotifications();
    initLocalNotifications();
  }
}
