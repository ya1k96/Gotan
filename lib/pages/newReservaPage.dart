import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/Widgets/utils/Widgets_utiles.dart';
import 'package:flutter_login_page_ui/Widgets/utils/uiData.dart';
import 'package:flutter_login_page_ui/models/FavosModel.dart';
import 'package:flutter_login_page_ui/models/horario.dart';
import 'package:flutter_login_page_ui/models/reserva.dart';
import 'package:flutter_login_page_ui/providers/bus_provider.dart';
import 'package:flutter_login_page_ui/providers/db_cache.dart';
import 'package:provider/provider.dart';
import 'package:flutter_login_page_ui/models/usuario.dart';


import '../login_state.dart';

class NewReservaPage extends StatefulWidget {
  NewReservaPage({Key key}) : super(key: key);

  @override
  _NewReservaPageState createState() => _NewReservaPageState();
}

class _NewReservaPageState extends State<NewReservaPage> {
  Horario salida;
  Reserva reserva;
  TextStyle estiloForma = TextStyle(
    fontSize: 16.0,
    fontFamily: "Poppins-Medium"
  );
  IconData _ico = Icons.favorite_border;
  String idHorario;
  bool _isLoading = false;
  
  @override
  Widget build(BuildContext context) {
    CacheLocal().initDB();
    idHorario = ModalRoute.of(context).settings.arguments;
    
    Usuario usuario = Provider.of<LoginState>(context).user;
    reserva = new Reserva(
      cantidad: 1,
      horarioId: '',      
      dondeSube: '',
      usuarioReservado: usuario.id
    );
  
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,        
        title: Text('información', style: TextStyle(color: Colors.black54)),
        backgroundColor: Colors.transparent,        
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, color: Colors.black54,),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
      decoration: BoxDecoration(        
        color: Colors.white12
      ),
      child: SingleChildScrollView(
        child: _crearBody(context),
      )
    ),
   );
  }
  //TODO: Cambiar el paso de parametros
  //Pasar unicamente el id para pedir la salida.
  //En lugar de pasar el dato concreto y pedir el administrador
  Widget _crearBody(context) {
    return FutureBuilder(
      future: BusProvider().getHorarioById(idHorario),
      builder: (BuildContext context, AsyncSnapshot snap){
        if( !snap.hasData ) {
          return Padding(
            padding: const EdgeInsets.only(top: 150.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        salida = Horario.fromJson(snap.data[0]);
        salida.nombre = snap.data[0]['id_admin']['usuario'];
        reserva.horarioId = salida.id;
        //Nombre de usuario de la cta.

        return Stack(children: <Widget>[
          Padding(
          padding: const EdgeInsets.symmetric(vertical: 150, horizontal: 15),      
          child: Card(
            elevation: 7.0,
            child: Column(
              children: <Widget>[
                SizedBox(height: 15.0,),               
                _formulario(),
                _botonesEnd(context)
              ],
            ),
          ),
        ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: CircleAvatar( 
                child: Text('${ salida.nombre[0] }',style: TextStyle(fontSize: 60),),
                radius: 50,
              ),
              onTap: () => Navigator.pushNamed(context, 'profile-page'),
            ),

          ],
        ),
        Padding(
          padding: const EdgeInsets.all(95.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Chip(label: Text('${salida.nombre}',style: TextStyle(fontSize: 20),), elevation: 8,)
            ],
          ),
        ),
        ],
        );
      },
    );
  }

  Widget _formulario() {
    return Form(
      child: Column(
        children: <Widget>[
          _hora(),
          Divider(),
          _pedidoCerrado(),
          Divider(),
          _cupo(),    
        ],
      ),
    );
  }

  Widget _hora(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Salida' , style: estiloForma,),
              Text( '${salida.hora}Hs' , style: estiloForma,)
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          Row(
            children: <Widget>[
              Text('Desde ${salida.desde} a ${salida.hacia}', style: UIData.estiloMuted)
            ],
          ),
        ],
      ),
    );
  }

  Widget _cupo() {
    Color color = Colors.greenAccent;    
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Cupos', style: estiloForma,),
          Text(salida.cupo.toString(),          
          style: TextStyle(
            color: color, 
            fontFamily: "Poppins-Medium", fontSize: 18
          )
        )
        ],
      ),
    );
  }

  Widget _botonesEnd(context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _submit(context),
          _cancelar(),
          _favButton()
        ],
      );
  }

  _submit(context) {
    dynamic onPressed = (salida.cupo == 0) ? 
    null : salida.pedidoCerrado ?
    null : () => _pedirReservaProdivider(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
      child: (salida.cupo != 0) ? UIData.botonFormulario(onPressed, 'Pedir') : Text('Completo  ', style: UIData.estiloMuted, ),
    );
  }

  

  _cancelar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, left:10.0, top: 10.0),
      child: UIData.botonCancelarYRegresar(context),
    );
  }

  //TODO: Este metodo va en la pagina de procesamiento del pedido
  _pedirReservaProdivider(context) async {
    WidgetsUtiles.showLoading(context);
    // setState(() {
    //   _isLoading = true;   
    // });

    final resp = await BusProvider().addReserva(reserva); 
    // setState(() {
    //   _isLoading = false;      
    // });
    Navigator.pop(context);
    final message = resp['message'];
    if( !resp['ok'] ) {
      Navigator.pushNamed(context, 'error-page', arguments: message);
    } else {
      Navigator.pushNamed(context, 'success-page', arguments: message);
      // Future.delayed(const Duration(milliseconds: 1000), () {
      // });
    }

  }

  agregarFav() async {
    await CacheLocal().insertFav(salida);
  }

  _pedidoCerrado() {
    return salida.pedidoCerrado ?
    Chip(label: Text('cerrado'),) :
    Container();
  }

  _favButton() {
    return FutureBuilder(
      future: CacheLocal().isFav(salida.id),
      builder: (context, snap) {
        if( snap.hasData ) {
          _ico  = snap.data ? Icons.favorite : Icons.favorite_border;              
        }
        return Consumer<FavosModel>(
          builder: (context, favos, child) {
            return Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: () { 
              favos.insertFav(salida);
              setState(() {
              });
            }, 
            icon: Icon(_ico, color: Colors.redAccent) 
            ),
          );
          },
          child: Container(width: 0.0, height: 0.0,),
        );
      },
    );
  }

  // _loadingDialog() {
  //   return FlareLoading(
  //     name: 'assets/animation/loading.flr',
  //     loopAnimation: 'Loading',
  //     endAnimation: 'Complete',
  //     startAnimation: 'Loading',
  //     width: 200,
  //     height: 200,
  //     fit: BoxFit.fill,
  //     isLoading: _isLoading,
  //     onSuccess: (_) {
  //       print('Finished');
  //     },
  //     onError: (err, stack) {
  //       print(err);
  //     },
  //   );
  // }
}
