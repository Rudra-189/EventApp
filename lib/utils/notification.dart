import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class NotificationService{
  static Notification_message(String title,msg){
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'notification',
          title: title,
          body: msg,
          notificationLayout: NotificationLayout.BigText,
      ));
  }
}