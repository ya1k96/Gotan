import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/Widgets/FormCard.dart';
import 'package:flutter_login_page_ui/Widgets/SocialIcons.dart';
import 'package:flutter_login_page_ui/Widgets/utils/Widgets_utiles.dart';
import 'package:flutter_login_page_ui/Widgets/utils/uiData.dart';
import 'package:flutter_login_page_ui/login_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../CustomIcons.dart';

class LoginPage extends StatefulWidget {
  
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //bool _isSelected = false;

  _LoginPageState();

  //void _radio() {
  //  setState(() {
  //    _isSelected = !_isSelected;
  //  });
  //}

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    //ScreenUtil.instance =
    //ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: UIData.svgGet('assets/svg/bus_stop.svg', screenSize.height * 0.3, 88),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("assets/image_02.png"),
              )
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 30.0),
              child: Column(
                children: <Widget>[
                 
                  SizedBox(
                    height: ScreenUtil.instance.height * 0.07,
                  ),
                  FormCard(),                  
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      WidgetsUtiles.horizontalLine(),
                      Text("Con redes sociales",
                          style: TextStyle(
                              fontSize: 16.0, fontFamily: "Poppins-Medium")),
                      WidgetsUtiles.horizontalLine()
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocialIcon(
                        colors: [
                          Color(0xFF102397),
                          Color(0xFF187adf),
                          Color(0xFF00eaf8),
                        ],
                        iconData: CustomIcons.facebook,
                        onPressed: () {
                          Provider.of<LoginState>(context).facebookLogin(context);

                        },
                      ),
                      SocialIcon(
                        colors: [
                          Color(0xFFff4f38),
                          Color(0xFFff355d),
                        ],
                        iconData: CustomIcons.googlePlus,
                        onPressed: () {
                          Provider.of<LoginState>(context).googleLogin(context);
                        },
                      )
                      
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.006,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text( "¿Nuevo? ", style: TextStyle(fontFamily: "Poppins-Medium") ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, 'registro'),
                        child: 
                        Text("¡Registrate!",
                          style: TextStyle(
                            color: Color(0xFF5d74e3),
                            fontFamily: "Poppins-Bold")
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  
}