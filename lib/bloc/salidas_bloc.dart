
import 'dart:async';

import 'package:flutter_login_page_ui/bloc/validator/validators_salidas.dart';
import 'package:flutter_login_page_ui/models/horario.dart';
import 'package:flutter_login_page_ui/providers/bus_provider.dart';


class Salidas with Validators{
  final provider = BusProvider();
  String destino = 'Corrientes';
  final _salidasController = StreamController<List<Horario>>.broadcast();

  //Recuperar los datos del Stream  
  Stream<List<Horario>> get ultimasSalidasStream => _salidasController.stream.transform(proximasSalidas);
  
  void obtenerUltimasSalidas( String pDestino ) async {
      setUltimasSalidas( await provider.getHorarios(pDestino) );

  }
  
  //Insertar valores al Stream  
  Function get setUltimasSalidas => _salidasController.sink.add;
  

  dispose() {    
    _salidasController?.close();
  }

}