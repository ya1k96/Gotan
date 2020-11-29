import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/providers/bus_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_login_page_ui/bloc/socket.dart';

import 'Widgets/utils.dart';
import 'models/usuario.dart';


class LoginState with ChangeNotifier{
  BusProvider bus = BusProvider();

  final _googleSignIn = new GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ]);


  final _auth = FirebaseAuth.instance;
  Usuario _usuario;
  bool googleUser = false;
  bool _loggedIn = false;

  void googleLogin( BuildContext context ) async {
    final user = await _handleSignIn();
    
    if( user != null ) {
      final resp = await bus.isUser(user.email);

      _loggedIn = true;

      notifyListeners();  
      if(!resp['ok']) {
        final newUser = <String, dynamic>{
          "email"     : user.email,
          "usuario"   : user.displayName,
          "is_google" : "true"          
        };

        _usuario = (await bus.sigIn(newUser))['usuario'];

      } else {
        _usuario = resp['usuario'];
      }


    } else {
      Utils.mostrarDialogoError(context);      
    }

  }

  facebookLogin( BuildContext context ) async {

    final facebookLogin = FacebookLogin();

    final FacebookLoginResult result =
        await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        final facebookResp = await bus.createUserWithFacebook( accessToken.token );

        print(facebookResp);
        if( facebookResp != null ) {
          final resp = await bus.isUser(facebookResp['email']);
          _loggedIn = true;

          notifyListeners();  
          if(!resp['ok']) {
            final newUser = <String, dynamic>{
              "email"       : facebookResp['email'],
              "usuario"     : facebookResp['first_name'],
              "is_facebook" : "true"              
            };

            _usuario = (await bus.sigIn(newUser))['usuario'];

          } else {
            _usuario = resp['usuario'];
          }


        } else {
          Utils.mostrarDialogoError(context);      
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }
    
  
  emailYContrasLogin(email, password, context) async {
    final resp = await bus.logIn(email, password);
    
    if( resp['ok'] ) {
      _loggedIn = true;
      _usuario = Usuario.fromJson(resp['usuario']);

      //if(_usuario.isAdmin) {
      //  blocS.registroAdmin(resp['usuario']);
      //} else {
      //  blocS.registroUsuario(resp['usuario']);
      //}

      notifyListeners();
      return true;
    } else {
      Utils.mostrarDialogoError(context);            
    }

    return false;
  }
  
  void logOut() {
    _loggedIn = false;
    notifyListeners();
  }

  Future _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
   
    return user;
  }

  bool isLoggeIn() => _loggedIn;
  Usuario get user => _usuario;
}