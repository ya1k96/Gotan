//import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
//class Notificacion {
//  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = //FlutterLocalNotificationsPlugin();
//
//  void init() async {
//    // initialise the plugin. app_icon needs to be a added as a drawable resource to the //Android head project
//    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
//    var initializationSettings = InitializationSettings(
//        initializationSettingsAndroid, null);
//    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//        onSelectNotification: selectNotification);
//  }
//
//  Future selectNotification(String payload) async {
//    if (payload != null) {
//      debugPrint('notification payload: ' + payload);
//    }
//  }
//
//  showNotification(String titulo, String body, String payload) async {
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//    'your channel id', 'your channel name', 'your channel description',
//    importance: Importance.Max, priority: Priority.High, ticker: 'ticker', playSound: true);
//    var platformChannelSpecifics = NotificationDetails(
//        androidPlatformChannelSpecifics, null);
//    await flutterLocalNotificationsPlugin.show(
//        0, titulo, body, platformChannelSpecifics,
//        payload: 'item x');
//  }
//}