// Widget Lista de pedidos para la pagina principal
import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/Widgets/utils/uiData.dart';
import 'package:flutter_login_page_ui/models/pedido.dart';
import 'package:flutter_login_page_ui/providers/bus_provider.dart';

class Pedidos {
  String idUsuario;

  Pedidos({@required this.idUsuario});

  Widget listaPedidos( ) => FutureBuilder(
    future: BusProvider().getReservasByUserId(this.idUsuario),
    builder: (context, snap) {
      if( !snap.hasData ) {
        return Center(child: CircularProgressIndicator(),);
      } else {
        final data = snap.data;
          if( data.length == 0 ) {
            return Center(child: Text('Nada por aqui'),);
          } else {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Card(
                    color: Colors.white,
                    child: ListView.separated(
                      itemCount: data.length,
                      itemBuilder: (context, i) {
                        Pedido item = Pedido.fromJson(data[i]);
                        return ListTile(
                          enabled: _enabled( item ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                            Text( '${item.horarioId.idAdmin.usuario}'),
                            Text(' - '),
                            Text( '${item.horarioId.hora}hs', style: UIData.estiloMuted,),
                          ],), 
                          trailing: item.aprobado ?
                            Icon(Icons.check_circle, color: Colors.green[300],) :
                            Icon(Icons.close, color: Colors.red[300],),
                          subtitle: _leyenda( item ), 
                          onTap: () => Navigator.pushNamed(context, 'vista-detalle-pedido', arguments: item),                            
                        );
                      },
                      separatorBuilder: (context, i) => Divider(height: 30, color: Colors.grey,),
                    ),
                  ),
                ),
              ),
            );
          }
          
      }
    },
  );

  

  _leyenda( Pedido item ) {
    if( item.cancelado ) {
      return Text('Cancelado', style: UIData.estiloRechazadoMuted,);
    } else {
      return _expiracion(item.createdAt);
    }
  }

  _expiracion( DateTime fecha ) {
    final dist = _tiempoPasado( fecha );
    
    if( dist > 1 && !dist.isNegative ) {
      return Text('Hecho');
    } 
  }

  _enabled( Pedido item ) {
    final dist = _tiempoPasado(item.createdAt);
    if( item.cancelado || (!dist.isNegative && dist > 2) ) {
      return false;
    } else {
      return true;
    }
  }

  _tiempoPasado( DateTime fecha ) {
    String auxFechaSplit = DateTime.now().toIso8601String()
    .split('T')[0];
    final fechaActual = DateTime.parse(auxFechaSplit);

    return fecha.difference(fechaActual).inHours;
  }
}
