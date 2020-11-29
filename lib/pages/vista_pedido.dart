import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/Widgets/utils/Widgets_utiles.dart';
import 'package:flutter_login_page_ui/Widgets/utils/uiData.dart';
import 'package:flutter_login_page_ui/models/pedido.dart';
import 'package:flutter_login_page_ui/providers/bus_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VistePedido extends StatefulWidget {
  VistePedido({Key key}) : super(key: key);

  @override
  _VistePedidoState createState() => _VistePedidoState();
}

class _VistePedidoState extends State<VistePedido> {
  Pedido pedido;
  @override
  Widget build(BuildContext context) {
    pedido = ModalRoute.of(context).settings.arguments;
    return Container(
       child: Scaffold(
         appBar: AppBar(
           backgroundColor: Colors.transparent,
           elevation: 0.0,
           title: Text('Pedido',style: TextStyle(
             color: Colors.black54
            ),
           ),
           leading: InkWell(
             child: Icon(Icons.keyboard_arrow_left, color: Colors.black54,),
             onTap: () => Navigator.pop(context),
           ),
         ),
         body: _crearBody(context),
       ),
    );
  }


_crearBody(BuildContext context) {
  return Card(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _crearHeaderB(),
        _bodyDocument(pedido),
        SizedBox(height: 20,),
        _botonCancelarPedido(context)
      ],
    ),
  );
}

_botonCancelarPedido(BuildContext context) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: RaisedButton(
      highlightColor: Colors.red,
      color: Colors.red[300],
      textColor: Colors.white,
      hoverColor: Colors.red,
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15 ),
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => Padding(
            padding: EdgeInsets.symmetric( vertical: 200 ),
            child: _dialogBody(context),
          )
        );
      },
      child: Text('Cancelar pedido'),
    ),
  );
}

_dialogBody(BuildContext context) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.symmetric( horizontal: 19 ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
        Text('¿Estas seguro de que quieres cancelar tu pedido?', style: UIData.estiloNotif,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Si'),
              onPressed: () async { 
                //Mostrar el dialogo de carga
                WidgetsUtiles.showLoading(context);

                final result = await BusProvider().cancelarPedido(pedido.sId);
                if( result['ok'] ) { 
                  //Quitar el dialogo de carga
                  Navigator.pop(context); 
                    
                  confirmadoToast();

                  new Timer(new Duration(seconds: 1), () {
                    Navigator.pushReplacementNamed(context, '/');                            
                  });                                 
                  
                }
              },
            ),
            UIData.botonFormulario(() {}, 'Realizar pedido')
          ],
        )
        ],
      ),
    ),
  );
}

confirmadoToast() {
  return Fluttertoast.showToast(
        msg: 'Hemos guardado tus cambios',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
  );
}

Widget _bodyDocument(Pedido pedido) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(35),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Horario', style: UIData.estiloMuted,),
              Text(pedido.horarioId.hora, style:UIData.estiloMuted),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Combi', style: UIData.estiloMuted,),
              Text(pedido.horarioId.idAdmin.usuario, style:UIData.estiloMuted),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Cantidad', style: UIData.estiloMuted,),
              Text(pedido.cantidad.toString(), style:UIData.estiloMuted),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Hacia', style: UIData.estiloMuted,),
              Text(pedido.horarioId.hacia, style:UIData.estiloMuted),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Subis por', style: UIData.estiloMuted,),
              Text(pedido.dondeSube, style:UIData.estiloMuted),
            ],
          ),
          Divider(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Total pesos ', style: UIData.estiloNotif,),
              Text('${pedido.horarioId.precio}', style:UIData.estiloMuted),
            ],
          ),
          
        ],
      ),
    ),
  );
}

_crearHeaderB() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text('Detalles', style: UIData.estiloMuted)
    ],
  );
}
}