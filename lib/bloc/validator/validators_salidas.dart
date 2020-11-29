import 'dart:async';

import 'package:flutter_login_page_ui/models/horario.dart';


class Validators {
  final proximasSalidas = StreamTransformer<List<Horario>, List<Horario>>.fromHandlers(
    handleData:( salidas, sink ) {
      
      final fechaActual = DateTime.now();
      String auxFechaSplit = fechaActual.toIso8601String()
      .split('T')[0];

      final List<Horario> listaFinal = [];      
    
      salidas.forEach( (value) {
        final salidaHoy = DateTime.parse('$auxFechaSplit ${value.hora}:00');
        int dist = salidaHoy.difference(fechaActual).inMinutes;
        
        if( dist < 100 && !dist.isNegative ) {
          listaFinal.add(value);
        }                 

      });

      sink.add(listaFinal);          

    }
  );
}