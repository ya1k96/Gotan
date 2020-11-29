import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/Widgets/utils/uiData.dart';

//Widgets para la pagina de administracion
class UIClasess {

  static Widget grillaHorarios( BuildContext context, data) {
    return GridView.count(
      crossAxisCount: 4,
      children: data.map<Widget>((value){
        return InkWell(
          onTap: () => Navigator.pushNamed(context, 'detailReservasPage', arguments: value),
          child: Card(
            elevation: 5,
            child: Center(
              child: Text(value.hora, style: UIData.letraGridHorario,),
            ),
          ),
        );
      }).toList(),
    );
  }

}