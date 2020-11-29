
import 'dart:async';

import 'package:flutter_login_page_ui/bloc/validator/validator_reg.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc with Validators {

  final _passwordController = BehaviorSubject<String>();
  final _emailController    = BehaviorSubject<String>();
  final _usuarioController  = BehaviorSubject<String>();
  
  //Recuperar los datos del Stream
  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);
  Stream<String> get usuarioStream => _usuarioController.stream.transform(validarNomYApe);
  
  Stream<bool> get formValidStream => Observable.combineLatest3(emailStream, passwordStream, usuarioStream, (email, password, usuario) => true );

  //Insertar valores al Stream
  Function(String) get changeUsuario => _usuarioController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;

  //Obtener el valor de los campos
  String get email    =>  _emailController.value;
  String get usuario  =>  _usuarioController.value;
  String get password =>  _passwordController.value;


  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _usuarioController?.close();
  }
}