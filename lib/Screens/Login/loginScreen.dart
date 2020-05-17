import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inpay_app/Components/snackbar.dart';
import 'package:inpay_app/Enums/returnStatus.dart';
import 'package:inpay_app/Models/usuario.dart';
import 'package:inpay_app/Screens/Login/loginBloc.dart';
import 'package:inpay_app/Screens/Login/loginStyles.dart';
import 'package:inpay_app/Services/auth.dart';
import 'package:inpay_app/Utils/constants.dart';
import 'package:inpay_app/Utils/errorHandler.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

/// Tela exibida ao usuário para autenticação
class LoginScreen extends StatefulWidget {
  LoginScreen(this.loginCallback);

  final VoidCallback loginCallback;
  final LoginBloc bloc = LoginBloc();

  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  Size _media;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    _media = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: _media.height,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _logoInpay(),
                _loginForm(),
                _bottomRow(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Widget responsável por carregar o logotipo da InPay
  Widget _logoInpay() {
    return Padding(
      padding: EdgeInsets.only(top: 60),
      child: Image.asset(
        "assets/images/logotype/logo_inpay.png",
        width: 200,
      ),
    );
  }

  /// Widget responsável por criar o formulário de login
  Widget _loginForm() {
    return Container(
      margin: new EdgeInsets.symmetric(horizontal: 20.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Form(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
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
                      hintStyle:
                          const TextStyle(color: Colors.white, fontSize: 15.0),
                      contentPadding: const EdgeInsets.only(
                          top: 15.0, right: 30.0, bottom: 15.0, left: 5.0),
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
                  child: StreamBuilder<bool>(
                    stream: widget.bloc.streamSenha,
                    initialData: false,
                    builder: (context, snapshot) {
                      return new TextFormField(
                        controller: _controllerSenha,
                        keyboardType: TextInputType.text,
                        obscureText: snapshot.data ? false : true,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: new InputDecoration(
                          icon: new Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              snapshot.data
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorLight,
                            ),
                            onPressed: () {
                              widget.bloc.atualizarObscureText();
                            },
                          ),
                          errorText: null,
                          border: InputBorder.none,
                          hintText: "Senha",
                          hintStyle: const TextStyle(
                              color: Colors.white, fontSize: 15.0),
                          contentPadding: const EdgeInsets.only(
                              top: 15.0, right: 30.0, bottom: 15.0, left: 5.0),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: _signIn(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Widget responsável por criar o botão de login
  Widget _signIn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        StreamBuilder<int>(
          stream: widget.bloc.streamBtLogin,
          initialData: 0,
          builder: (context, snapshot) {
            return RaisedButton(
              child: _setUpButtonChild(snapshot.data),
              color: AZUL_INPAY,
              padding: EdgeInsets.fromLTRB(32, 16, 32, 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
                Usuario usuario = new Usuario(
                  email: _controllerEmail.text,
                  senha: _controllerSenha.text,
                );
                _autenticarUsuario(context, usuario);
              },
            );
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: _divisor(),
        ),
      ],
    );
  }

  /// Widget responsável por criar parte do botão de login, retornando texto, progress ou check
  Widget _setUpButtonChild(int value) {
    if (value == 0) {
      return Container(
        child: Text(
          "Entrar",
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

  /// Exibe um dividor na tela entre a autenticação via e-mail e redes
  Widget _divisor() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 40, right: 15),
                child: Divider(
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              "ou",
              style: TextStyle(color: Colors.white),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 40, left: 15),
                child: Divider(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  var logadoGoogle = await Auth().signInGoogle();
                  if (logadoGoogle == ReturnStatus.SUCCESS) {
                    widget.loginCallback();
                  }
                },
                child: Icon(LineAwesomeIcons.google,
                    size: 40.0, color: Colors.white),
              ),
              Icon(LineAwesomeIcons.facebook, size: 40.0, color: Colors.white),
              Icon(LineAwesomeIcons.apple, size: 40.0, color: Colors.white),
            ],
          ),
        ),
      ],
    );
  }

  /// Widget responsável por gerar a linha inferior para recuperação de senha e criação de conta
  Widget _bottomRow(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SafeArea(
          minimum: EdgeInsets.only(bottom: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RECUPERAR_SENHA);
                },
                child: Container(
                  height: 35,
                  width: _media.width / 2,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Esqueceu sua senha?',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: Colors.black,
                          fontSize: 13.0),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, CADASTRO_ROUTE);
                },
                child: Container(
                  height: 35,
                  width: _media.width / 2,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Criar uma conta',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: Colors.white,
                          fontSize: 13.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Realiza as verificações relacionadas à autenticação do usuário
  _autenticarUsuario(BuildContext context, Usuario usuario) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (!usuario.isLoginFieldsFilled) {
      Scaffold.of(context).showSnackBar(snackbarPreencherCampos);
    } else if ((connectivityResult) == ConnectivityResult.none) {
      Scaffold.of(context).showSnackBar(snackbarConexao);
    } else {
      widget.bloc.atualizar();
      ReturnStatus retorno = await Auth().signIn(usuario.email, usuario.senha);

      if (retorno == ReturnStatus.SUCCESS) {
        widget.bloc.atualizar();
        Timer(Duration(milliseconds: 1000), () {
          widget.loginCallback();
        });
      } else {
        widget.bloc.reiniciar();
        String mensagem = ErrorHandler().getErrorMessage(retorno);
        Scaffold.of(context).showSnackBar(buildSnackBar(mensagem, 3));
      }
    }
  }
}
