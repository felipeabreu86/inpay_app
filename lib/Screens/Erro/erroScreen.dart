import 'package:flutter/material.dart';

/// Tela responsável por exibir a tela de Erro do aplicativo
class ErroScreen extends StatefulWidget {
  ErroScreen({Key key}) : super(key: key);

  @override
  _ErroScreenState createState() => _ErroScreenState();
}

class _ErroScreenState extends State<ErroScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Ocorreu algum erro.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Por favor, tente novamente.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
