import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../login_state.dart';

class FormCard extends StatefulWidget {
  @override
  _FormCardState createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _loadingForm = false;
  final usuario = {
    "email": '',
    "password": ''
  };

  TextEditingController _emailcontroller = TextEditingController();

  TextEditingController _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView(
      child: new Container(
        width: double.infinity,
        height: ScreenUtil.getInstance().setHeight(780),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 15.0),
                  blurRadius: 15.0),
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, -10.0),
                  blurRadius: 10.0),
            ]),
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Login",
                  style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(45),
                    fontFamily: "Poppins-Bold",
                    letterSpacing: .6
                  )
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(30),
                ),
                Text("Usuario",
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: ScreenUtil.getInstance().setSp(35))
                ),
                _inputUsuario(),               
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(30),
                ),
                Text("Contraseña",
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: ScreenUtil.getInstance().setSp(35))
                ),
                _inputContras(),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(35),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Olvidaste tu contraseña?",
                      style: TextStyle(
                          color: Colors.blue,
                          fontFamily: "Poppins-Medium",
                          fontSize: ScreenUtil.getInstance().setSp(28)),
                    )
                  ],
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(5),
                ),
                _botonIngresar( context )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputUsuario() {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp   = new RegExp(pattern);

      
    return TextFormField(
      controller: _emailcontroller,      
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelStyle: TextStyle(fontSize: 16),
          hintText: "correo electronico",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 15.0)
      ),
      onSaved: (value) => usuario['email'] = value,
      validator: (value) {
        
        if ( regExp.hasMatch( value ) ) {
          return null;
        } else {          
          return 'Ingresa un correo valido';
        }

      },
    );

  }

  Widget _inputContras() {
    return TextFormField(
      controller: _passwordcontroller,
      obscureText: true,
      textCapitalization: TextCapitalization.characters,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          hintText: "password",
          labelStyle: TextStyle(fontSize: 16),
          hintStyle: TextStyle(color: Colors.grey, fontSize: 15.0)
      ),
      onSaved: (value) => usuario['contras'] = value,
    );
  }

  _botonIngresar(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        
        InkWell(
          child: Container(
            width: ScreenUtil.getInstance().setWidth(300),
            height: ScreenUtil.instance.height * 0.02,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFF17ead9),
                  Color(0xFF6078ea)
                ]),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF6078ea).withOpacity(.3),
                      offset: Offset(0.0, 8.0),
                      blurRadius: 8.0)
                ]),
            child: Material(
              color: Colors.blue,
              child: InkWell(
                onTap: () => _submit( context ),
                child: Center(
                  child: Text("ingresar",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins-Bold",
                          fontSize: 18,
                          letterSpacing: 1.0)),
                ),
              ),
            ),
          ),
        ),        
      ],
    );
  }

  void _submit(BuildContext context) {
    
    if(!formKey.currentState.validate()) return null;
    
    var state = Provider.of<LoginState>(context);
    
    usuario['email'] = _emailcontroller.value.text;
    usuario['password'] = _passwordcontroller.value.text;
    
    state.emailYContrasLogin(usuario['email'], usuario['password'], context);
    
    usuario['password'] = '';
    usuario['email'] = '';
    
  }
}
