import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UIData {
  //routes


  //strings
  static const String appName = "Flutter UIKit";

  //fonts
  static const String quickFont = "Quicksand";
  static const String ralewayFont = "Raleway";
  static const String quickBoldFont = "Quicksand_Bold.otf";
  static const String quickNormalFont = "Quicksand_Book.otf";
  static const String quickLightFont = "Quicksand_Light.otf";

  //images
  static const String imageDir = "assets/images";
  static const String pkImage = "$imageDir/pk.jpg";
  static const String profileImage = "$imageDir/profile.jpg";
  static const String blankImage = "$imageDir/blank.jpg";
  static const String dashboardImage = "$imageDir/dashboard.jpg";
  static const String loginImage = "$imageDir/login.jpg";
  static const String paymentImage = "$imageDir/payment.jpg";
  static const String settingsImage = "$imageDir/setting.jpeg";
  static const String shoppingImage = "$imageDir/shopping.jpeg";
  static const String timelineImage = "$imageDir/timeline.jpeg";
  static const String verifyImage = "$imageDir/verification.jpg";

  //login
  static const String enter_code_label = "Phone Number";
  static const String enter_code_hint = "10 Digit Phone Number";
  static const String enter_otp_label = "OTP";
  static const String enter_otp_hint = "4 Digit OTP";
  static const String get_otp = "Get OTP";
  static const String resend_otp = "Resend OTP";
  static const String login = "Login";
  static const String enter_valid_number = "Enter 10 digit phone number";
  static const String enter_valid_otp = "Enter 4 digit otp";

  //gneric
  static const String error = "Error";
  static const String success = "Success";
  static const String ok = "OK";
  static const String forgot_password = "Forgot Password?";
  static const String something_went_wrong = "Something went wrong";
  static const String coming_soon = "Coming Soon";

  static const MaterialColor ui_kit_color = Colors.grey;

//colors
  static List<Color> kitGradients = [
    // new Color.fromRGBO(103, 218, 255, 1.0),
    // new Color.fromRGBO(3, 169, 244, 1.0),
    // new Color.fromRGBO(0, 122, 193, 1.0),
    Colors.blueGrey.shade800,
    Colors.black87,
  ];
  static List<Color> kitGradients2 = [
    Colors.cyan.shade600,
    Colors.blue.shade900
  ];

  //randomcolor
  static final Random _random = new Random();

  static final TextStyle subtitulo = TextStyle(
    fontSize: 15.0,
    fontFamily: "Poppins-Medium",
    color: Colors.black87
  );

    static final TextStyle letraGridHorario = TextStyle(
    fontSize: 15.0,
    fontFamily: "Poppins-Medium",
    color: Colors.redAccent
  );

  static final estiloMuted = TextStyle(
    fontSize: 14.0,
    fontFamily: "Poppins-Medium",
    color: Colors.black54
  );

  static final estiloRechazadoMuted = TextStyle(
    fontSize: 14.0,
    fontFamily: "Poppins-Medium",
    color: Colors.red[300]
  );

  static final estiloAprobadoMuted = TextStyle(
    fontSize: 14.0,
    fontFamily: "Poppins-Medium",
    color: Colors.green[300]
  );
  
  static final estiloChipPedidos = TextStyle(
    fontSize: 14.0,
    fontFamily: "Poppins-Medium",
    color: Colors.white
  );

  static final successPageTitle = TextStyle(
    fontSize: 24.0,
    fontFamily: "Poppins-Medium",
    color: Colors.white
  );

  static final successPageSubTitle = TextStyle(
    fontSize: 18.0,
    fontFamily: "Poppins-Medium",
    color: Colors.white
  );

  static final estiloNotif = TextStyle(
    fontSize: 18.0,
    fontFamily: "Poppins-Medium",
    color: Colors.black54
  );

  static final estiloHora = TextStyle(
    color: Colors.black54, 
    fontSize: 13, 
    letterSpacing: .3,
    fontFamily: 'Poppins-Medium'
  );
  
  static final labelUsuario = TextStyle(
    color: Colors.blueAccent,
    fontWeight: FontWeight.bold,
    fontSize: 18
  );

  static final labelSearchD = TextStyle(
    color: Colors.black54,
    fontWeight: FontWeight.bold,
    fontSize: 28
  );

  /// Returns a random color.
  static Color next() {
    return new Color(0xFF000000 + _random.nextInt(0x00FFFFFF));
  }

  static svgGet( String iconPath, double alto, double ancho ) {
    return SvgPicture.asset(
      iconPath,
      matchTextDirection: true,
      height: alto,
      width: ancho,
    );
  }

  static OutlineButton botonFormulario(onPressed, titulo) {
    return OutlineButton(
      padding: const EdgeInsets.all(15.0),
      shape: StadiumBorder(),
      onPressed: onPressed,
      highlightColor: Colors.blueAccent,
      child: Text(titulo, style: TextStyle(color: Colors.black54, fontSize: 17)),
    );
  }

  static MaterialButton botonCancelarYRegresar(context) {
    return MaterialButton(
          elevation: 0.0,
          padding: const EdgeInsets.all(15.0),
          onPressed: (){
            Navigator.pop(context);
          },
          color: Colors.white,
          child: Text('Cancelar', style: TextStyle(color: Colors.black54, fontSize: 17)),
      );
  }
  
}