import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/Widgets/utils/Widgets_utiles.dart';
import 'package:flutter_login_page_ui/Widgets/utils/uiData.dart';
import 'package:flutter_login_page_ui/providers/bus_provider.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  String id;
  Widget build(BuildContext context) {
    id = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(),
    );
  }

  _body() {
    return Stack(
      children: <Widget>[
        _appBar(),
        _notiList()
      ],
    );
  }

  _appBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(icon: Icon(Icons.keyboard_arrow_left), onPressed: () => Navigator.pop(context)),
          SizedBox(width: 105,),
          Text('Notificaciones', style: UIData.estiloNotif,)
        ],
      ),
    );
  }

  _notiList() {
    return FutureBuilder(
      future: BusProvider().getNotis(id),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if( !snap.hasData ) {
          return Center(child: CircularProgressIndicator());
        } else {
          final data = snap.data;

          if( data.length == 0 ) {
            return Center(child: Text('No hay nuevas notificaciones', style: UIData.estiloMuted,),);
          } else {
            return _buillderList( data );
          }
          
        }
      },
    );
  }

  _buillderList( data ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context,i) {
          return WidgetsUtiles.itemNotificacion(data[i]);
        }
      ),
    );
  }
}