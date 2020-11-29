import 'dart:async';

class Validators {
  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if( password == null ) {
        return sink.addError('Ingresa una contraseña');
      } 

      if( password.length >= 6 ) {
        sink.add( password );
      } else {
        sink.addError('Debe tener longitud mayor a 6');
      } 
    }
  );
  final validarNomYApe = StreamTransformer<String, String>.fromHandlers(
    handleData: (nomYApe, sink) {
      if( nomYApe == null ) {
       return sink.addError('Ingresa un usuario');
      } 
      if( nomYApe.length >= 5 ) {
        sink.add( nomYApe );
      } else {
        sink.addError('Debe tener longitud mayor a 5');
      } 
    }
  );

  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if( email == null ) {
        return sink.addError('Ingresa un correo valido');
      } 

      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'; 
      RegExp regExp = new RegExp( pattern );

      if( regExp.hasMatch( email ) ) {
        sink.add( email );
      } else {
        sink.addError('Ingresa un correo valido');
      }
    }
  );
}