import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/Widgets/utils/uiData.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_login_page_ui/models/usuario.dart';

class WidgetsUtiles {

  static flare(String animation, String file, Alignment alineacion) => FlareActor(file, alignment: alineacion, fit: BoxFit.contain, animation: animation);
  //Item de la lista de notificaciones
  static itemNotificacion( data ) => 
  Card(
    child: ListTile(
      leading: _leadingIcon( data['tipo'] ),
      title: Text(data['titulo'], style: UIData.estiloNotif,),
      subtitle: Text(data['descripcion'], style: UIData.estiloMuted,),
    ) 
  );
  
  static Widget _leadingIcon(int tipo) {
    double ancho = 80.0,
           alto  = ancho;
    //Iconos para cada tipo de notificacion
    switch (tipo) {
      case 1:
        return UIData.svgGet('assets/svg/003-thumbs up.svg', alto, ancho);
        break;
      default:
        return UIData.svgGet('assets/svg/003-thumbs up.svg', alto, ancho);
      break;
    }
  }

  static Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: ScreenUtil.getInstance().setWidth(80),
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );

 static showLoading( BuildContext context ) {
  AlertDialog alert = AlertDialog(
    content: new Row(
    children: [
        CircularProgressIndicator(),
        Container( 
          margin: EdgeInsets.only(left: 5),
          child: Text("Cargando") 
        ),
      ],
    ),
  );

  showDialog(
    barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
} 

static drawer(BuildContext context, Usuario usuario) {
    return Drawer(
      child: ListView(
        // Importante: elimine cualquier padding del ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: ListTile(
              title: Text(usuario.usuario, style: TextStyle(fontSize: 16, color: Colors.white),),
              subtitle: Text(usuario.email),
            ),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
          ),
          ListTile(
            title: Text('Notificaciones'),
            leading: Icon(Icons.notifications),
            onTap: () {
              Navigator.pushNamed(context, 'notificaciones');
            },
          ),
          ListTile(
            title: Text('Mi cuenta'),
            leading: Icon(Icons.account_circle),
            onTap: () {
              // Actualiza el estado de la aplicación
              // ...
            },
          ),
          ListTile(
            title: Text('Mis favs'),
            leading: Icon(Icons.favorite, color: Colors.redAccent,),
            onTap: () {
              Navigator.pushNamed(context, 'favos-page');
            },
          ),
        ],
      ),
    );
  }
  
}