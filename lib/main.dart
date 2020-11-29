import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/bloc/socket.dart';
import 'package:flutter_login_page_ui/login_state.dart';
import 'package:flutter_login_page_ui/models/FavosModel.dart';
import 'package:flutter_login_page_ui/pages/admin_pages/reservas_detail_page.dart';
import 'package:flutter_login_page_ui/pages/admin_pages/reservas_page.dart';
import 'package:flutter_login_page_ui/pages/error_page.dart';
import 'package:flutter_login_page_ui/pages/favos_page.dart';
import 'package:flutter_login_page_ui/pages/home_page.dart';
import 'package:flutter_login_page_ui/pages/login_page.dart';
import 'package:flutter_login_page_ui/pages/newReservaPage.dart';
import 'package:flutter_login_page_ui/pages/notification_page.dart';
import 'package:flutter_login_page_ui/pages/profile_page.dart';
import 'package:flutter_login_page_ui/pages/registro/register_page.dart';
import 'package:flutter_login_page_ui/pages/reserva_detalle/vista_detalle_pedido.dart';
import 'package:flutter_login_page_ui/pages/success_page.dart';
import 'package:flutter_login_page_ui/providers/push_notification_manager.dart';
import 'package:provider/provider.dart';




void main() {     
  runApp(MyApp());
} 

class MyApp extends StatefulWidget{

  @override
  _MyAppState createState() => _MyAppState();    
  
}

class _MyAppState extends State<MyApp> {
    GlobalKey<NavigatorState> llave = new GlobalKey<NavigatorState>();
    String token;
    @override
    void initState() {    
      super.initState();
      PushNotificationsManager().init(llave);
    }

    @override
    Widget build(BuildContext context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<LoginState>(
            builder: ( BuildContext context ) => LoginState(),
          ),
          ChangeNotifierProvider<FavosModel>(
            builder: (context) => FavosModel(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ultimas salidas',        
          navigatorKey: llave,
          routes: {
            '/' : (BuildContext context) {
              
              var state = Provider.of<LoginState>(context);
              if( state.isLoggeIn() ) {
                return Consumer<FavosModel>(builder: (context, favos, child) {
                  favos.initDB();
                  return HomePage();
                },);              
              } else {
                return LoginPage();
              }
            },
            'detailReservasPage'   : (BuildContext context) => ReservasDetailPage(),
            'vista-detalle-pedido' : (BuildContext context) => VistaDetallePedido(),
            'notificaciones'       : (BuildContext context) => NotificationPage(), 
            'reserva-detalle'      : (BuildContext context) => NewReservaPage(),
            'reservas'             : (BuildContext context) => ReservasPage(),
            'registro'             : (BuildContext context) => RegisterPage(),
            'success-page'         : (BuildContext context) => SuccessPage(),
            'profile-page'         : (BuildContext context) => ProfilePage(),
            'error-page'           : (BuildContext context) => ErrorPage(),
            'favos-page'           : (BuildContext context) => FavosPage()
          },
        ),

      );
      
    }

    @override 
    void dispose() {
      super.dispose();
    }

  
  }
  
