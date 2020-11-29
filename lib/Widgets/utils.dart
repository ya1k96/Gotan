import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/pages/search_delegate.dart';
class Utils {

 static mostrarDialogoError(BuildContext context){
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0)
              ),
              height: 150,
              width: 250,
              child: Center(
                child: Material(
                  color: Colors.white,
                  child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Ha ocurrido un error'),
                  subtitle: Text('Contraseña o correo invalido'),
                ),
                )
              ),
            ),
          );
        }
      );
  }

  static Widget botonBuscar( BuildContext context, SearchDelegate searchDelegate ) {
    return IconButton(
      icon: CircleAvatar(child: Icon(Icons.search), backgroundColor: Colors.white, radius: 50,),
      onPressed: (){
        showSearch(
          context: context,
          delegate: searchDelegate,
          query: ''
        );
      },
    );
  }

}

