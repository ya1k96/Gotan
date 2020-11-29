import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/bloc/provider.dart';
import 'package:flutter_login_page_ui/pages/registro/fondo.dart';
import 'package:flutter_login_page_ui/providers/bus_provider.dart';
import 'package:flutter_login_page_ui/providers/push_notification_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {       
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,

      ),
      body: Stack(
        children: <Widget>[          
          _loginForm(context),
          Fondo(),
        ],
      ),
    );
  }

  _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = new Provider().registerBloc;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          
          SafeArea(
            child: Container(
              height: size.width * 0.40,
              padding: EdgeInsets.only(top: size.height * 0.10),
            ),
          ),

          Container(
            width: size.width * 0.95,
            padding: EdgeInsets.symmetric(vertical: 30.0),
            margin: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                
                SizedBox(height: 25.0,),
                _crearEmail( bloc ),
                SizedBox(height: 25.0,),
                _crearPassword( bloc ),
                SizedBox(height: 25.0,),
                _crearNyA( bloc ),
                SizedBox(height: 25.0,),
                _crearBoton( bloc )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearEmail( bloc ) {

    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snap ){

        return Container( 
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: TextField(
            style: TextStyle(
              fontFamily: 'Poppins-Medium'
            ),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.blue,),
              hintText: 'ejemplo@corre.com',
              labelText: 'Email',
              errorText: snap.error
            ),
            onChanged: bloc.changeEmail,

            // onChanged: bloc.changeEmail (opcional mas corto)
          ),
        );

      },
    );

    
  }
  Widget _crearNyA( bloc ) {

    return StreamBuilder(
      stream: bloc.usuarioStream,
      builder: (BuildContext context, AsyncSnapshot snap ){

        return Container( 
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: TextField(
            style: TextStyle(
              fontFamily: 'Poppins-Medium'
            ),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              icon: Icon(Icons.account_box, color: Colors.blue,),
              hintText: 'meliSuave96',
              labelText: 'Usuario',
              errorText: snap.error
            ),
            onChanged: bloc.changeUsuario,
            // onChanged: bloc.changeEmail (opcional mas corto)
          ),
        );

      },
    );

    
  }

  Widget _crearPassword( bloc ) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snap) {

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: TextField(
            style: TextStyle(
              fontFamily: 'Poppins-Medium'
            ),
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.blue,),
              labelText: 'Password',
              errorText: snap.error,
            
            ),
            onChanged: bloc.changePassword,
            
          ),
        );

      },
    );
    
  }

  Widget _crearBoton( bloc ) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snap) {
        dynamic hasData = snap.hasData;

        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Enviar', style: TextStyle(
              fontFamily: 'Poppins-Medium',
              fontSize: 16
            ),),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 0.0,
          color: Colors.blueAccent,
          textColor: Colors.white,
          onPressed: hasData ? () => _register( context, bloc ) : null,
        );

      },
    );
  }

  _register( BuildContext context, bloc ) {	
    final pushToken = PushNotificationsManager().token;

    Map<String, String> newUser = {
      "usuario"    : bloc.usuario,
      "email"      : bloc.email,
      "password"   : bloc.password,
      'is_google'  : 'false',
      'is_facebook': 'false',
      'push_token' : pushToken
    };

   _sendApi(newUser)
    .then( (resp) {

    String message = 'Ha ocurrido un error. intenta mas tarde.';
    Color color = Colors.redAccent;

    if( resp['ok'] ) {
      message = 'Perfecto! Ya podes ingresar';
      color = Colors.green;
    } else {
      message = resp['errores'];
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0
    );
      
    if(resp['ok']) Navigator.pushNamed(context, '/');

    });
  }

  _sendApi(newUser) {
    final bus = new BusProvider();
    return bus.sigIn(newUser);
  }
  //_getToken() async {
  //  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
	//	return await _firebaseMessaging.getToken();
  //}
}