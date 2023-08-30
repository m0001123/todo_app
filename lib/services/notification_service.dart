import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class NotifyService{
  FlutterLocalNotificationsPlugin  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  initalizeNotifyService() async{
    tz.initializeTimeZones();
    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("appicon");

    final InitializationSettings initializationSettings =
    InitializationSettings(
      iOS: initializationSettingsIOS,
      android:initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        );
  }


  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }


  Future onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
      Get.dialog(Text('asdfjkl;'));
  }

  Future onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      print('notification payload: $payload');
    }
    Get.to(()=>Container(color: Colors.yellow,));
  }

  void displayNotification({required String title, required String body})async{
    var androidPlatformNotificationDetails = new AndroidNotificationDetails('your channel id', 'your channel name',importance: Importance.max,priority: Priority.high);
    var iosPlatformNotificationDetails = new  DarwinNotificationDetails();
    var platformNotificationDetails = NotificationDetails(android: androidPlatformNotificationDetails,iOS: iosPlatformNotificationDetails);
    await flutterLocalNotificationsPlugin.show(0, title, body, platformNotificationDetails);
  }

  void scheduledNotification({required String title, required String body}) async{
    var androidPlatformNotificationDetails = new AndroidNotificationDetails('your channel id', 'your channel name',);
    var iosPlatformNotificationDetails = new  DarwinNotificationDetails();
    var platformNotificationDetails = NotificationDetails(android: androidPlatformNotificationDetails,iOS: iosPlatformNotificationDetails);
    await flutterLocalNotificationsPlugin.zonedSchedule(1, title, body, tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),platformNotificationDetails, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

}