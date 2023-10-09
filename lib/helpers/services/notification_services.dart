import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manawanui/helpers/utils/util_functions.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> requestNotificationPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      console("NotificationService => authorized/provisional");
      initLocalNotifications();
    } else {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
      console("NotificationService => denied");
    }
  }

  Future<String> getDeviceToken() async {
    final token = await _messaging.getToken();
    return token ?? "";
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });
  }

  Future<void> initLocalNotifications() async {
    const androidInitSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    const iOSInitSettings = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iOSInitSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {},
    );
  }

  Future<void> showNotification(RemoteMessage message) async {
    final channelId = Random.secure().nextInt(10000).toString();
    final channel = AndroidNotificationChannel(
      channelId,
      "Manawanui Notifications",
      importance: Importance.high,
    );

    final androidNotificationDetails = AndroidNotificationDetails(
      channelId,
      channel.name,
      channelDescription: "Manawanui Notifications",
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const iOSNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title?.toString() ?? "",
      message.notification?.body?.toString() ?? "",
      notificationDetails,
    );
  }
}
