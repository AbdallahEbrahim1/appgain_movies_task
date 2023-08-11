import 'dart:convert';

import 'package:appgain_movies_task/features/notifications/view.dart';
import 'package:appgain_movies_task/my_app.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final _firebaseMessaging = FirebaseMessaging.instance;
const _androidNotificationChannel = AndroidNotificationChannel(
  "high_importance_channel",
  "High Importance Notification",
  description: "This Channel is used for importance notification",
  importance: Importance.defaultImportance,
);

final FlutterLocalNotificationsPlugin _localeNotification =
    FlutterLocalNotificationsPlugin();

void handleMessage(RemoteMessage? message) {
  if (message == null) return;
  navigatorKey.currentState?.pushNamed(
    NotificationsView.route,
    arguments: message,
  );
}

Future initLocaleNotifications() async {
  const iOS = DarwinInitializationSettings();
  const android = AndroidInitializationSettings(
    '@drawable/ic_launcher',
  );

  const settings = InitializationSettings(
    android: android,
    iOS: iOS,
  );

  await _localeNotification.initialize(
    settings,
  );
  //
  // await _localeNotification.initialize(
  //   settings,
  //   onSelectNotification: (String? payload) async {
  //     // Handle the notification tap event here
  //     final message = RemoteMessage.fromMap(jsonDecode(payload as String));
  //     handleMessage(message);
  //   },
  // );
  //

  final platform = _localeNotification.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();
  await platform?.createNotificationChannel(_androidNotificationChannel);
}

Future initPushNotifications() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((message) {
    final notification = message.notification;
    if (notification == null) return;
    _localeNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidNotificationChannel.id,
            _androidNotificationChannel.name,
            channelDescription: _androidNotificationChannel.description,
            icon: '@drawable/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.toMap()));
  });
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("title: ${message.notification?.title}");
  print("body: ${message.notification?.body}");
  print("data: ${message.data}");
}

class FirebaseApi {
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("Token: $fCMToken");
    initPushNotifications();
    initLocaleNotifications();
  }
}
