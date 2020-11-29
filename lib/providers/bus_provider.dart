import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_login_page_ui/models/horario.dart';
import 'package:flutter_login_page_ui/models/reserva.dart';
import 'package:http/http.dart' as http;


class BusProvider {
  String _url = 'http://192.168.1.5:3000';
	final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  getAdministradores() async {   
    return json.decode( (await http.get('$_url/usuario')).body );
  }

  getAdministrador( String id ) async {
    return json.decode( (await http.post('$_url/usuario/id', body: { "id": id })).body );
  }

  Future<List<Horario>> getHorarios([String destino]) async {    
    return _casteoHorarios( (json.decode( (await http.get('$_url/horario?destino=$destino')).body ))['horarios'] );
  }

  getHorarioById(String id) async {
    return json.decode( (await http.get('$_url/horario/byId/$id')).body )['horario'];
  }

  Future<List<Horario>> getHorariosByUserId( String id ) async {
    print('id: $id');
    return _casteoHorarios(json.decode( ((await http.get('$_url/horario/byUser/$id')).body) )['horarios']);
  }

  getReservasByUserId( String id ) async {
    return json.decode( (await http.get('$_url/usuario/pedidos/$id')).body );
  }
  
  Future<Reserva> getReservaById( String id ) async {
    return Reserva.fromJson(json.decode( (await http.get('$_url/horario/reserva/$id')).body )['reserva'][0]);
  }

  logIn( String email, String password ) async {
    final user = {"email": email, "password": password};
    return json.decode( (await http.post('$_url/usuario/login', body: user)).body );
  }

  sigIn( Map<String, dynamic> newUser ) async {
    return json.decode( (await http.post('$_url/usuario', body: newUser )).body );
  }

  isUser( String email ) async {  
    return json.decode( (await http.post('$_url/usuario/es_usuario', body: {"email": email})).body);
  }

  Future<List<Horario>> buscarPorHora( String hora ) async {
    return _casteoHorarios( (json.decode( (await http.post('$_url/horario/query', body: {"query": hora})).body ))['horarios'] );
  }

  Future addReserva(Reserva data) async {
    //blocS.nuevaReserva(reserva);
    //final dbRef = FirebaseDatabase.instance.reference().child("reservas");
    dynamic reserva = reservaToJson(data);
    dynamic response;
    try {
      response = json.decode((await http.post('$_url/horario/addReserva', body: { "reserva": reserva })).body);
    } catch (e) {
      response = {'ok': false, 'message': 'Ha ocurrido un error. Intenta mas tarde.'};
    }

    return response;
  }

  Future reservasById(String id) async {
    dynamic response;
    try {
      response = json.decode((await http.get('$_url/horario/reservasById/$id')).body);
    } catch (e) {
      response = {'ok': false, 'message': 'Ha ocurrido un error. Intenta mas tarde.'};
    }

    return response;
  }

  cierreReservas( String id ) async  {
    return json.decode( (await http.get('$_url/usuario/administradores/cpdh/$id')).body );
  }

  getNotis( String id ) async {
    dynamic response;
    try {
      response = json.decode( (await http.get('$_url/usuario/notificaciones/$id')).body );
    } catch (e) {
      response = {'ok': false, 'message': 'Ha ocurrido un error. Intenta mas tarde.'};
    }

    return response;
  }

  cancelarPedido( String id ) async {
    return json.decode( (await http.post('$_url/usuario/pedidos/cancelar/$id', body: {'id': id})).body );
  }

  List<Horario> _casteoHorarios( List<dynamic> horarios ) {
    final List<Horario> listaFinal = [];
    
    horarios.forEach((hora) {
      final Horario item = Horario.fromJson(hora);      
      listaFinal.add( item );
    });

    return listaFinal;
  }
  _getTokenPush() async {
		return await _firebaseMessaging.getToken();
  }
  Map<String, dynamic> _addPushIdInUser( Map<String, dynamic> newUser ) {
    return {
      "email"     : newUser['email'],
      "usuario"   : newUser['usuario'],
      "is_google" : newUser['is_google'] ?? 'false', 
      "is_facebook" : newUser['is_facebook'] ?? 'false', 
      "push_id"     : _getTokenPush()
    };
  }
  //LOGIN CON FACEBOOK 
  createUserWithFacebook(String accessToken) async {
    print(accessToken);   
    final graphResponse = await http.get(
    'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${accessToken}');

    return json.decode(graphResponse.body);
  }
}