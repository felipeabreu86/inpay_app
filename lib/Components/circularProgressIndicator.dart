import 'package:flutter/material.dart';
import 'package:inpay_app/Utils/constants.dart';

/// Retorna um Widget contendo um circular progress indicator com o texto "carregando..."
Widget buildWaitingScreen() {
  return Scaffold(
    body: Container(
      color: AZUL_INPAY,
      alignment: Alignment.center,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 35,
              width: 35,
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Carregando...",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
              ),
            ),
          ]),
    ),
  );
}
