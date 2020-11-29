import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/Widgets/utils/uiData.dart';
import 'package:flutter_login_page_ui/models/horario.dart';
import 'package:flutter_login_page_ui/pages/admin_pages/widgets/UIClasses.dart';
import 'package:flutter_login_page_ui/providers/bus_provider.dart';
import 'package:provider/provider.dart';

import '../../login_state.dart';

class ReservasPage extends StatefulWidget {
  ReservasPage({Key key}) : super(key: key);
  static final String path = "lib/src/pages/lists/list2.dart";
  final pathIcon = 'assets/svg/redes.svg';

  _ReservasPageState createState() => _ReservasPageState();
}

class _ReservasPageState extends State<ReservasPage> {
  final TextStyle dropdownMenuItem =
  TextStyle(color: Colors.black, fontSize: 18);
  final primary = Colors.blueAccent;
  String id;
  double height;

  @override
  Widget build(BuildContext context) {
    id = Provider.of<LoginState>(context).user.id;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      floatingActionButton: _botonFlotante(),
      body: SingleChildScrollView(
        child: Container(
          height: height/1.5,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 220),
                child: _builder()
              ),
              Container(
                height: height / 2,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_left,
                              color: Colors.black87,
                              size: 35,
                            ),
                          ),                     
                        ],
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            UIData.svgGet(widget.pathIcon, 80, 80)                             
                          ],
                        ),
                      ),
                      Text('Horarios', style: UIData.subtitulo,)
                    ],
                  ),
                ),
              ),
                            
            ],
          ),
        ),
      ),
    );
  }


  _botonFlotante() {
    return FloatingActionButton(
      onPressed: _onPressAdd,
      child: Icon(Icons.add),
    );
  }


  void _onPressAdd() {
  }

  _builder() {
    return FutureBuilder(
      future: BusProvider().getHorariosByUserId(id),
      builder: ( BuildContext context,  AsyncSnapshot<List<Horario>> snap){

        if( !snap.hasData ){
          return Center(
            child: CircularProgressIndicator()
          );
        }

        final data = snap.data;                    

        return UIClasess.grillaHorarios(context, data);
      }
    );
  }
}