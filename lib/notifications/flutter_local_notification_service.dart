import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:protfolio_admin_app/screens/projects/projects_view.dart';

class FlutterLocalNotificationsService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialiZe() {
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? route) async {
      if(route!=null) {
        Get.to(() => const ProjectsView());
      }
        });
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              "portfolio_notification_channel",
              "portfolio_notification",
              channelDescription: "this is our porfolio notification chanel",
              importance: Importance.max,
              priority: Priority.high));

      await flutterLocalNotificationsPlugin.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
           payload: null);


    } on Exception catch (e) {
      print("exception from chanel creation:${e}");
      // TODO
    }
  }
}
