import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/bloc/register_bloc.dart';

class Provider extends InheritedWidget {
  final registerBloc = RegisterBloc(); 
  static Provider _instancia;

  factory Provider({Key key, Widget child}) {

    if( _instancia == null ) {
      _instancia = Provider._internal(key: key, child: child,);
    }

    return _instancia;
  }

  Provider._internal({Key key, Widget child}) 
  : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static RegisterBloc of ( BuildContext context ) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().registerBloc;
  }
}