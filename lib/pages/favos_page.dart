import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/Widgets/utils/uiData.dart';
import 'package:flutter_login_page_ui/models/FavosModel.dart';
import 'package:flutter_login_page_ui/providers/db_cache.dart';
import 'package:provider/provider.dart';

class FavosPage extends StatefulWidget {
  FavosPage({Key key}) : super(key: key);

  @override
  _FavosPageState createState() => _FavosPageState();
}

class _FavosPageState extends State<FavosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Mis favoritos'),),
      body: _body(),
    );
  }

  _body() {
    return Consumer<FavosModel>(
      builder: (context, favos, child) {
        final lista = favos.favos;
        if( lista.length == 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('No tienes favoritos', style: UIData.estiloMuted,),
                ],
              )
            ],
          );
        }

        return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, i) {
              final data = lista[i];
                return ListTile(
                  title: Text(data['hora']),
                  subtitle: Text(data['desde'] + '  ' + data['hacia']),
                  leading: Icon(Icons.access_time),
                  onTap: () => Navigator.pushNamed(context, 'reserva-detalle', arguments: data['id']),
                );
              
            },
          );
      }, 
      child: Container(),
    );
  }
}