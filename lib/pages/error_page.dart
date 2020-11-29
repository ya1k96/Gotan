import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/Widgets/utils/uiData.dart';

class ErrorPage extends StatefulWidget {
  ErrorPage({Key key}) : super(key: key);

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  String msg;
  @override
  Widget build(BuildContext context) {
    msg = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.redAccent,
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
                  Text('Error', style: UIData.successPageTitle ),
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
          color: Colors.redAccent,
          child: Text('Ir a inicio', style: UIData.successPageSubTitle),
        )
      ],
    );
  }
}