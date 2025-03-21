import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings();

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(settings);
  }

  static Future<void> showNotification({required String title, required String body}) async {
    final BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body, // Required parameter for expanded text
    );

    final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id', // Unique channel ID
      'channel_name', // Channel Name
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: bigTextStyleInformation, // Use BigTextStyleInformation
    );

    final NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    await _notificationsPlugin.show(
      0, // Notification ID
      title,
      body, // Short text (shown before expanding)
      details,
    );
  }

}
