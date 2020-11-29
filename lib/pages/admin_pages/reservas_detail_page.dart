import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/models/horario.dart';
import 'package:flutter_login_page_ui/models/reserva.dart';
import 'package:flutter_login_page_ui/providers/bus_provider.dart';

//En cualquier momento elimino esta pagina

class ReservasDetailPage extends StatefulWidget {
  ReservasDetailPage({Key key}) : super(key: key);

  @override
  _ReservasDetailPageState createState() => _ReservasDetailPageState();
}

class _ReservasDetailPageState extends State<ReservasDetailPage> {
  @override
  Widget build(BuildContext context) {
  final horario = ModalRoute.of(context).settings.arguments;


    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: _body( horario ),
    );
  }

  _body( Horario horario ) {
    return Stack(
      fit: StackFit.loose,      
      children: <Widget>[
        _headerB( context, horario.id ),
        Padding(
          padding: EdgeInsets.only(top: 260, left: 10, right: 10),
          child: Container(),
        ),
        
        
      ],
    );
  }

  _headerB( context, String idHorario ){
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              
                Text(
                  "Reservas",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.filter_list,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: (){_dialogReservas(context, idHorario);},
                    child: Text('Cerrar pedidos'),
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }

  _containerB( List<dynamic> reservas ) {
    return _buildList(reservas);
  }

  _buildList( List<dynamic> reservas ) {

    return ListView.builder(
      itemCount: reservas.length,
      itemBuilder: (context, i) {
        
        if(reservas.length == 0){
          return Align(child: ListTile(
            title: Text('No tenes reservas'),
            leading: Icon(Icons.info_outline)
          ),alignment: Alignment.center,
          );
        }

        return FutureBuilder(
          future: BusProvider().getReservaById(reservas[i]['_id']),
          builder: (context, AsyncSnapshot<Reserva> snap){

            if( !snap.hasData ) {
              return Center(
                child: Padding(
                  child: CircularProgressIndicator(),
                  padding: EdgeInsets.only(top: 25)
                ),
              );
            }
            final reserva = snap.data;
            return Card(
              child: ListTile(
                title: Text(reserva.usuarioReservado),
                subtitle: Text('Donde sube: ${reserva.dondeSube.length == 0 ? 'No especifico': reserva.dondeSube}'),
              ),
            );
          },
        );

      },
    );
  }

  _dialogReservas(context, idHorario) async{

    //TODO: Cambiar por un toast.
    showDialog(
      context: context,
      builder: (context) {
        
        return FutureBuilder(
          future: BusProvider().cierreReservas(idHorario),
          builder: (context, snap) {

            if( !snap.hasData ){
              return Padding(
                padding: const EdgeInsets.only(top: 200, bottom: 200),
                child: Card(
                    child: Center(child: CircularProgressIndicator()),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.only(top: 200, bottom: 200),
              child: Card(
                child: Center(
                  child: Text('Perfecto!', style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 30),),
                ),
              ),
            );

          },
        );

      }
    );
  }
}