import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/Widgets/utils/uiData.dart';
import 'package:flutter_login_page_ui/models/horario.dart';
import 'package:flutter_login_page_ui/providers/bus_provider.dart';

class SearchDelegatePage extends SearchDelegate {
  
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(Icons.keyboard_arrow_left),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if(query.length < 1){
      return _sugerencia();
    } else {
      return FutureBuilder(
        future: BusProvider().buscarPorHora(query),
        builder: (BuildContext context, AsyncSnapshot<List<Horario>> snap){
          if( !snap.hasData ) {
            return Center(
              child: CircularProgressIndicator()
            );
          }
          if( snap.data.length == 0 ) {
            return _sinCoincidencias();
          }
          final List<Horario> horarios = snap.data;
          return ListView.builder(
            itemCount: horarios.length,
            itemBuilder: (context, i){
              return ListTile(
                title: Text('${horarios[i].hora} Hs\n${horarios[i].desde} - ${horarios[i].hacia}', 
                style: UIData.estiloMuted,),
                leading: Icon(Icons.access_time),
                trailing: Icon(Icons.keyboard_arrow_right),
                contentPadding: EdgeInsets.all(9.0),
                onTap: () {                  
                  Navigator.pushNamed(context, 'reserva-detalle', arguments: horarios[i].id);
                },
                subtitle: Text('Lugares disponibles: ${horarios[i].cupo}'),                
              );
            },
          );
        },
      );
    }   
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _sugerencia();
  }

  Widget _sugerencia() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              UIData.svgGet('assets/svg/redes.svg', 120, 120)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  '¡Busca por horario!',
                  style: UIData.labelSearchD,
                ),
              )
            ],
          )
          
        ],
    );
  }

  Widget _sinCoincidencias() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              UIData.svgGet('assets/svg/sad.svg', 120, 120)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                'No hay coincidencias.',
                style: UIData.labelSearchD,
              ),
            )
          ],
        )
      ],
    );
  }

}