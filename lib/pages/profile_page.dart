import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/Widgets/utils/uiData.dart';
import 'config.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F8FA),
      body: LayoutBuilder(
        builder: (context, constraints) {
          SizeConfig().init(constraints, Orientation.portrait);
         return Stack(
          overflow: Overflow.visible,
          children: <Widget>[

            Container(
              color: Colors.blueAccent,
              height: 40 * SizeConfig.heightMultiplier,
              child: Padding(
                padding:  EdgeInsets.only(left: 30.0, right: 30.0, top: 10 * SizeConfig.heightMultiplier),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          height: 11 * SizeConfig.heightMultiplier,
                          width: 22 * SizeConfig.widthMultiplier,
                          // decoration: BoxDecoration(
                          //   shape: BoxShape.circle,
                          //   image: DecorationImage(
                          //       fit: BoxFit.cover,
                          //       image: AssetImage("assets/profileimg.png"))
                          // ),
                        ),
                        SizedBox(width: 5 * SizeConfig.widthMultiplier,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Neil Sullivan Paul", style: TextStyle(
                              color: Colors.white,
                              fontSize: 3 * SizeConfig.textMultiplier,
                              fontWeight: FontWeight.bold
                            ),),
                            SizedBox(height: 1 * SizeConfig.heightMultiplier,),
                            Row(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    // Image.asset(
                                    //     "assets/fb.png",
                                    // height: 3 * SizeConfig.heightMultiplier,
                                    //   width: 3 * SizeConfig.widthMultiplier,
                                    // ),
                                    SizedBox(width: 2 * SizeConfig.widthMultiplier,),
                                    Text("Protorix", style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 1.5 * SizeConfig.textMultiplier,
                                    ),),
                                  ],
                                ),
                                SizedBox(width: 7 * SizeConfig.widthMultiplier,),
                                Row(
                                  children: <Widget>[
                                    // Image.asset(
                                    //   "assets/insta.png",
                                    //   height: 3 * SizeConfig.heightMultiplier,
                                    //   width: 3 * SizeConfig.widthMultiplier,
                                    // ),
                                    SizedBox(width: 2 * SizeConfig.widthMultiplier,),
                                    Text("Protorix", style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: 1.5 * SizeConfig.textMultiplier,
                                    ),),
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 3 * SizeConfig.heightMultiplier,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text("10.2K", style: TextStyle(
                              color: Colors.white,
                              fontSize: 3 * SizeConfig.textMultiplier,
                              fontWeight: FontWeight.bold
                            ),),
                            Text("Protorix", style: TextStyle(
                              color: Colors.white70,
                              fontSize: 1.9 * SizeConfig.textMultiplier,
                            ),),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text("543", style: TextStyle(
                                color: Colors.white,
                                fontSize: 3 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.bold
                            ),),
                            Text("Following", style: TextStyle(
                              color: Colors.white70,
                              fontSize: 1.9 * SizeConfig.textMultiplier,
                            ),),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white60),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("EDIT PROFILE", style: TextStyle(
                              color: Colors.white60,
                              fontSize: 1.8 * SizeConfig.textMultiplier
                            ),),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(top: 35 * SizeConfig.heightMultiplier),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  )
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:  EdgeInsets.only(left: 30.0, top: 3 * SizeConfig.heightMultiplier),
                        child: Text("Libertarian", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 2.2 * SizeConfig.textMultiplier
                        ),),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),            
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Row(
                children: <Widget>[
                  Icon(Icons.keyboard_arrow_left), 
                  Text('Atras', style: UIData.estiloNotif)
                ],
              ),
              ),         
            ),
          ],
        );
        }
      ),

    );
  }

}