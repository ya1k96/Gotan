import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';
import 'dart:io';

//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationProvider {
	final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
	final _mensajesStreamController = StreamController<String>.broadcast();
	Stream<String> get mensajes => _mensajesStreamController.stream;

  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  // configLocalN() {
  //   var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
  //   var initializationSettingsIOS = IOSInitializationSettings(
  //       onDidReceiveLocalNotification: null);
  //   var initializationSettings = InitializationSettings(
  //       initializationSettingsAndroid, initializationSettingsIOS
  //   );
  //   flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //       onSelectNotification: onSelectNotification
  //   );
  // }
  // Future onSelectNotification(String payload) async {
  //   if (payload != null) {
  //     print('notification payload: ' + payload);
  //   }
    
  // }  
  
	initNotifications() async {
		_firebaseMessaging.requestNotificationPermissions();

		_firebaseMessaging.configure(
			onMessage: ( info ) async {
				print('========= on message =========');
				print(info);

				String argumento = 'no-data';
				if( Platform.isAndroid ) {
					argumento = info['data']['notification'] ?? 'no-data';
				} 

				_mensajesStreamController.sink.add( argumento );
			},
			onLaunch: ( info ) {
				print('========= on launch =========');
				print(info);
			},
			onResume: ( info ) {
				print('========= on resume =========');
				print(info);

        String argumento = 'no-data';
				if( Platform.isAndroid ) {
					argumento = info['data']['notification'] ?? 'no-data';
				} 

				_mensajesStreamController.sink.add( argumento );
			}
		);
	}
	dispose() {
		_mensajesStreamController?.close();
	}

  // void _showNotification() async {
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //           'your channel id', 'your channel name', 'your channel description',
  //           importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
  //       var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  //       var platformChannelSpecifics = NotificationDetails(
  //           androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  //       await flutterLocalNotificationsPlugin.show(
  //           0, 'plain title', 'plain body', platformChannelSpecifics,
  //           payload: 'item x');
  // }
}