import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:push_notification/config/router/app_router.dart';

class LocalNotifications {
  static Future<void> requestPermissionNotification() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> initializeLocalNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  static void showLocalNotification(
      {required int id, String? title, String? body, String? data}) {
    const androidDetails = AndroidNotificationDetails(
        'channel id', 'channel name',
        playSound: true, importance: Importance.max, priority: Priority.high);
    const notificationDetails = NotificationDetails(android: androidDetails);
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails,
        payload: data);
  }

  static void onDidReceiveNotificationResponse(NotificationResponse response) {
    appRouter.push('/push-details/${response.payload}');
  }
}
