import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/Widgets/utils/arcClipper.dart';
import 'package:flutter_login_page_ui/Widgets/utils/uiData.dart';

 class Fondo extends StatelessWidget {

   @override
   Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoMorado = ClipPath(
      child: Container(
      height: size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
      ),
    ),
      clipper: ArcClipper(),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.15) 
      ),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,

        Positioned( top: 90.0, left: 30.0, child: circulo,),
        Positioned( top: -40.0, right: -30.0, child: circulo,),
        Positioned( bottom: -50.0, right: -10.0, child: circulo,),
        Positioned( bottom: 120.0, right: 20.0,  child: circulo,),
        Container(
          padding: EdgeInsets.only(top: size.width * 0.05),
          child: Column(
            children: <Widget>[
              ClipOval(
                child: Container(
                  color: Colors.white30,
                  child: UIData.svgGet('assets/svg/021-user.svg', 125, 125),
                ),
              ),
              SizedBox(height: 10.0, width: double.infinity),
              Text('Registrate para ingresar', style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: 16,
                color: Colors.white
                ),
              
              ),
            ],
          ),
        )
      ],
    );
   }
 }