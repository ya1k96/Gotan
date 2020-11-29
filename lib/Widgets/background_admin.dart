import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/Widgets/utils/arcClipper.dart';
import 'package:flutter_login_page_ui/Widgets/utils/uiData.dart';

class BackgroundAdmin extends StatelessWidget {  

  Widget topHalf(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return new Flexible(
      flex: 2,
      child: ClipPath(
        clipper: new ArcClipper(),
        child: Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                  color: Colors.blueAccent,
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: AssetImage('assets/image_02.png'),
                    // ...
                  )
              ),

            ),            
          ],
        ),
      ),
    );
  }

  final bottomHalf = new Flexible(
    flex: 3,
    child: new Container(),
  );

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[topHalf(context), bottomHalf],
    );
  }
}