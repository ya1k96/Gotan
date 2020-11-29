import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/Widgets/Pedidos.dart';
import 'package:flutter_login_page_ui/Widgets/background_admin.dart';
import 'package:flutter_login_page_ui/Widgets/utils.dart';
import 'package:flutter_login_page_ui/Widgets/utils/Widgets_utiles.dart';
import 'package:flutter_login_page_ui/Widgets/utils/uiData.dart';
import 'package:flutter_login_page_ui/bloc/salidas_bloc.dart';
import 'package:flutter_login_page_ui/models/horario.dart';
import 'package:flutter_login_page_ui/models/usuario.dart';
import 'package:flutter_login_page_ui/pages/search_delegate.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../login_state.dart';

class PrincipalPage extends StatefulWidget {
  PrincipalPage({Key key}) : super(key: key);

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  RefreshController _refreshController = new RefreshController(initialRefresh: true);
  Size size;
  Salidas bloc = Salidas();  
  bool resultado;
  TextStyle estiloMuted = TextStyle(
    fontSize: 12.0,
    fontFamily: "Poppins-Medium",
    color: Colors.black54
  );
  final primary = Colors.blueAccent;
  final secondary = Colors.blueAccent;
  String dropdownvalue = 'Corrientes';
  Usuario user;
  @override
  Widget build(BuildContext context) {      
    final state = Provider.of<LoginState>(context);
    size = MediaQuery.of(context).size;
    user = state.user;
    Widget body = Container();

    return  FadeIn(
      delay: Duration(milliseconds: 5),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: Stack(                  
        children: <Widget>[
          _crearBody(size),           
          BackgroundAdmin(),
          _crearHeader(user, context)
        ],
    ),
    footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            if(mode==LoadStatus.idle){
              body =  Chip(label: Text("pull up load"), backgroundColor: Colors.blueAccent,);
            }
            else if(mode==LoadStatus.loading){
              body = Chip(label: Text("Cargando"), backgroundColor: Colors.blueAccent,);
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
                body = Text("release to load more");
            }
            else{
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
      ),
    );
  }
  _crearHeader( Usuario user, context ) {
    return SafeArea(
      child: Column(
      children: <Widget>[      
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[  
            IconButton(
            icon: CircleAvatar(
              backgroundColor: Colors.white, child: Icon(Icons.dehaze), radius: 20.0,
            ), 
            onPressed: () => Scaffold.of(context).openDrawer()
          ),          
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Utils.botonBuscar(context, SearchDelegatePage())
          )
          ],
        ),
        ClipOval(
          child: Container(
            padding: EdgeInsets.all(19),
            color: Colors.white60,
            child: UIData.svgGet('assets/svg/bus-hora.svg', 100, 100),
          ),
        ),
        SizedBox(height: 10.0, width: double.infinity),
        Text('Proximas salidas', 
        style: TextStyle(
          fontSize: 20,
          color: Colors.white, 
          fontFamily: "Poppins-Medium",
          ),
        ),
      ],
  ),
    );
  }
  _crearBody(Size screensize) {

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 280),
      child: Container(               
        height: size.height,          
        child: SizedBox(
          child: Column(           
      children: <Widget>[
          SizedBox(
            height: screensize.height*0.050,
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Voy a: ', style: UIData.estiloMuted,),
              _dropDownDestino()
            ],
          ),
          ),                                 
          Flexible(
            child: BounceInUp(
              animate: true,
              child: _crearProximasSalidas(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              WidgetsUtiles.horizontalLine(),
              Chip(label: Text('Tus pedidos', style: UIData.estiloChipPedidos, textAlign: TextAlign.start,), backgroundColor: Colors.grey,),
              WidgetsUtiles.horizontalLine()

            ],
          ),
          Pedidos(idUsuario: user.id).listaPedidos()
      ],
      ),
        ),
      ),
    );
  }
  Widget _crearProximasSalidas() {
    bloc.obtenerUltimasSalidas(dropdownvalue);
    return StreamBuilder(
      stream: bloc.ultimasSalidasStream,
      builder: (BuildContext context, AsyncSnapshot<List<Horario>> snap){        

        if( !snap.hasData ) {
          return Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );                        
        }
                

        if( snap.data.length == 0 ){          

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: ListTile(
                leading: Icon(Icons.info_outline, color: Colors.black54,),
                title: Text('Actualmente no hay salidas disponibles', style: estiloMuted,),
              ),
            ),
          );

        } else {          

          final data = snap.data;          
          return Container(
            height: 250,
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i){
                return InkWell(
                  child: Card(
                    borderOnForeground: true,
                    elevation: 8,
                    child: buildList(context, i, data), 
                    
                  ),
                );

              },
            ),
          );
        }

      },
    ); 
    
  }

  buildList(BuildContext context, int index, List<Horario> data) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10
            ),
            child: UIData.svgGet('assets/svg/redes.svg', 45, 45),
          ), 
          SizedBox(width: 11,),         
          InkWell(
            onTap: () => Navigator.pushNamed(context, 'reserva-detalle', arguments: data[index].id),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,              
              children: <Widget>[
                Text(
                  data[0].idAdmin['usuario'],
                  style: UIData.labelUsuario,
                ),
                Row(                  
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      color: Colors.deepOrange,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      data[index].hora,
                      style: UIData.estiloHora
                    ),                           
                  ],
                ),                
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.gps_not_fixed,
                      color: Colors.deepOrange,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('${data[index].hacia} - Desde: ${data[index].desde}',
                        style: TextStyle(
                            color: Colors.black54, 
                            fontSize: 13, 
                            letterSpacing: .3,
                            fontFamily: 'Poppins-Medium')
                    ),                    
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _dropDownDestino() {
    return DropdownButton<String>(
    value: dropdownvalue,
    icon: Icon(Icons.arrow_drop_down),
    iconSize: 24,
    elevation: 16,
    style: TextStyle(
      color: Colors.blue
    ),
    underline: Container(
      height: 2,
      color: Colors.blueAccent,
    ),
    onChanged: (String newValue) {
      setState(() {
        dropdownvalue = newValue;
        bloc.obtenerUltimasSalidas(dropdownvalue);
      });
    },
    items: <String>['San Cosme', 'Corrientes']
      .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      })
      .toList(),
  );
  }

  void _onRefresh() async {
      setState(() {
        bloc.obtenerUltimasSalidas(dropdownvalue); 
      });
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 2000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if(mounted)
    setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }
}