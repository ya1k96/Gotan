import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/Widgets/utils/Widgets_utiles.dart';
import 'package:flutter_login_page_ui/Widgets/utils/uiData.dart';
import 'package:flutter_login_page_ui/login_state.dart';
import 'package:flutter_login_page_ui/models/usuario.dart';
import 'package:flutter_login_page_ui/pages/principal_page.dart';
import 'package:flutter_login_page_ui/providers/bus_provider.dart';
import 'package:provider/provider.dart';

import 'admin_pages/admin_home_page.dart';


 class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   int _currentIndex = 0;
   BusProvider busProvider = BusProvider();
   dynamic state;
   final GlobalKey _scaffoldKey = new GlobalKey();

   @override
   Widget build(BuildContext context) {
   
   state = Provider.of<LoginState>(context);    
   Usuario user = state.user;
    
    return Scaffold(   
      key: _scaffoldKey,
      body: user.isAdmin ? _callPageAdmin() : _callPageUser(),
      floatingActionButton: _floatingActionButton(context), 
      drawer: WidgetsUtiles.drawer(context, user),
      floatingActionButtonLocation: _location(user.isAdmin),
    );
   }

  _logOutApp(contexto) {
    showDialog(
      context: contexto,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            height: 150,
            width: 300,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Text('¿Seguro que quieres salir?', style: UIData.subtitulo,)
                  ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: (){
                          setState(() {      
                            state.logOut();
                          });
                          Navigator.pop(context);
                        },
                        child: Text('Si', style: UIData.subtitulo,),
                      ),
                      RaisedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text('Cancelar', style: UIData.subtitulo,),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
    
  }

  _floatingActionButton(context) {
    return FloatingActionButton(
      backgroundColor: Colors.blueAccent,
      tooltip: 'Salir',
      
      child: Icon(Icons.exit_to_app),
      onPressed: (){
        _logOutApp(context);
      },
    );
  }

  _callPageUser() {
    switch (_currentIndex) {
      default: return PrincipalPage();        
    }
  }
  _callPageAdmin() {
    switch (_currentIndex) {
      default: return AdminHomePage();        
    }
  }


  FloatingActionButtonLocation _location(bool isAdmin) {
   return FloatingActionButtonLocation.endFloat;
  }
}