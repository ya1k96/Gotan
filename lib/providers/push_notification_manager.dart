import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:flutter_login_page_ui/bloc/notification.dart';
class PushNotificationsManager {

  //Recorda agregar funcion para tomar el pushtoken para el usuario que tiene mas de un dispositivo.
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance = PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;
  void init(llave) async {
    //var notificacion = Notificacion();
    //notificacion.init();
  
    if (!_initialized) {
      // For iOS request permission first.
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.requestNotificationPermissions();
  
      _firebaseMessaging.configure(
        onMessage: ( data ) async {

				print('========= on message =========');
				print(data);

			},
			onLaunch: ( data ) async {
				print('========= on launch =========');
				print(data);
			},
			onResume: ( data ) async {
        llave.currentState.pushNamed('notificaciones');
      }
      );
      
      _initialized = true;
    }
  }

  get token async =>  await _firebaseMessaging.getToken();
}