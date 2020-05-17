import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:inpay_app/Components/snackbar.dart';
import 'package:inpay_app/Enums/returnStatus.dart';
import 'package:inpay_app/Screens/Login/RecuperarSenha/recuperarSenhaBloc.dart';
import 'package:inpay_app/Screens/Login/loginStyles.dart';
import 'package:inpay_app/Services/auth.dart';
import 'package:inpay_app/Utils/constants.dart';
import 'package:inpay_app/Utils/errorHandler.dart';

/// Tela exibida ao usuário para recuperação da senha
class RecuperarSenhaScreen extends StatefulWidget {
  RecuperarSenhaScreen({Key key}) : super(key: key);

  final bloc = RecuperarSenhaBloc();

  @override
  _RecuperarSenhaScreenState createState() => _RecuperarSenhaScreenState();
}

class _RecuperarSenhaScreenState extends State<RecuperarSenhaScreen> {
  TextEditingController _controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Esqueci a senha"),
        backgroundColor: AZUL_INPAY,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: _media.width,
          height: _media.height - AppBar().preferredSize.height,
          decoration: new BoxDecoration(
            image: backgroundImage,
          ),
          child: new Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: <Color>[
                  AZUL_INPAY,
                  const Color.fromRGBO(162, 146, 199, 0.8),
                ],
                stops: [0.1, 0.6],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'Esqueceu a senha? Vamos te ajudar!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 30),
                    child: Text(
                      'Preencha seu e-mail cadastrado e enviaremos um link de recuperação de senha.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      border: new Border(
                        bottom: new BorderSide(
                          width: 0.5,
                          color: Colors.white24,
                        ),
                      ),
                    ),
                    child: new TextFormField(
                      controller: _controllerEmail,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: new InputDecoration(
                        icon: new Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        errorText: null,
                        border: InputBorder.none,
                        hintText: "E-mail",
                        hintStyle: const TextStyle(
                            color: Colors.white, fontSize: 15.0),
                        contentPadding: const EdgeInsets.only(
                            top: 15.0, right: 30.0, bottom: 15.0, left: 5.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: _btRecuperarSenha(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Widget responsável por criar o botão de login
  Widget _btRecuperarSenha() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        StreamBuilder<int>(
          stream: widget.bloc.stream,
          initialData: 0,
          builder: (context, snapshot) {
            return RaisedButton(
              child: _recuperarSenhaButtonChild(snapshot.data),
              color: AZUL_INPAY,
              padding: EdgeInsets.fromLTRB(32, 16, 32, 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
                _recuperarSenha(context, _controllerEmail.text);
              },
            );
          },
        ),
      ],
    );
  }

  /// Widget responsável por criar parte do botão, retornando texto, progress ou check
  Widget _recuperarSenhaButtonChild(int value) {
    if (value == 0) {
      return Container(
        child: Text(
          "Recuperar Senha",
          style: new TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.3,
          ),
        ),
      );
    } else if (value == 1) {
      return Container(
        height: 23.0,
        width: 23.0,
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Container(
        height: 23.0,
        width: 23.0,
        child: Icon(Icons.check, color: Colors.white),
      );
    }
  }

  /// Realiza as verificações relacionadas à recuperação de senha do usuário via e-mail
  _recuperarSenha(BuildContext context, String email) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (email.isEmpty) {
      Scaffold.of(context).showSnackBar(snackbarPreencherCampos);
    } else if ((connectivityResult) == ConnectivityResult.none) {
      Scaffold.of(context).showSnackBar(snackbarConexao);
    } else {
      widget.bloc.atualizar();
      ReturnStatus retorno = await Auth().sendPasswordResetEmail(email);

      if (retorno == ReturnStatus.SUCCESS) {
        widget.bloc.atualizar();
        Scaffold.of(context).showSnackBar(snackbarEmailRecuperacaoEnviado);
        Timer(Duration(milliseconds: 2000), () {
          Navigator.pop(context);
        });
      } else {
        widget.bloc.reiniciar();
        String mensagem = ErrorHandler().getErrorMessage(retorno);
        Scaffold.of(context).showSnackBar(buildSnackBar(mensagem, 3));
      }
    }
  }
}
