import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/Widgets/utils/uiData.dart';

class SuccessPage extends StatefulWidget {
  SuccessPage({Key key}) : super(key: key);

  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  String msg;
  @override
  Widget build(BuildContext context) {
    msg = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: _body(),
    );
  }

  _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('¡Perfecto!', style: UIData.successPageTitle ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(msg, style: UIData.successPageSubTitle),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 50,),
        RaisedButton(
          onPressed: () => Navigator.pushNamed(context, '/'),
          color: Colors.greenAccent,
          child: Text('Ir a inicio', style: UIData.successPageSubTitle),
        )
      ],
    );
  }
}