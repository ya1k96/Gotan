import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/Widgets/background_admin.dart';
import 'package:flutter_login_page_ui/Widgets/utils/Data.dart';
import 'package:flutter_login_page_ui/Widgets/utils/uiData.dart';

class AdminHomePage extends StatefulWidget {
  AdminHomePage({Key key}) : super(key: key);
  
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  Size deviceSize;
  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        BackgroundAdmin(),        
        _body()
      ],
    );
  }
  _header() {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Chip(
            label: Text('Admin', 
              textAlign: TextAlign.center,
              style: UIData.subtitulo
            ),
            avatar: CircleAvatar(
              child: Icon(Icons.account_circle),
            ),
          )
        ],
      ),
    );
  }


  _tarjetas() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height/1.6,
      width: size.width - 20,
      child: Card(
        elevation: 8.0,
        child: Stack(
          children: <Widget>[
            GridView.count(
              crossAxisCount: 2,
              children: listaDeOpciones.map<Widget>((value) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'reservas');
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        UIData.svgGet(value['icon'], 80, 80),                        
                        SizedBox(height: 15,),
                        Text(
                          value['nombre'],
                          style: UIData.subtitulo,
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }

  _body() {
    return Column(
      children: <Widget>[
        _header(),
        SizedBox(
          height: 140,
        ),
        _tarjetas()
      ],
    );
  }
}