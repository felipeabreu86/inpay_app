import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inpay_app/Components/snackbar.dart';
import 'package:inpay_app/Enums/returnStatus.dart';
import 'package:inpay_app/Models/usuario.dart';
import 'package:inpay_app/Screens/Login/Cadastro/cadastroBloc.dart';
import 'package:inpay_app/Screens/Login/loginStyles.dart';
import 'package:inpay_app/Services/auth.dart';
import 'package:inpay_app/Utils/constants.dart';
import 'package:inpay_app/Utils/errorHandler.dart';

/// Tela exibida ao usuário para cadastro de nova conta
class CadastroScreen extends StatefulWidget {
  CadastroScreen({Key key}) : super(key: key);

  final CadastroBloc bloc = CadastroBloc();

  @override
  CadastroScreenState createState() => new CadastroScreenState();
}

class CadastroScreenState extends State<CadastroScreen>
    with TickerProviderStateMixin {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerTelefone = TextEditingController();
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
                    controller: _controllerNome,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: new InputDecoration(
                      icon: new Icon(
                        Icons.person_outline,
                        color: Colors.white,
                      ),
                      errorText: null,
                      border: InputBorder.none,
                      hintText: "Nome",
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
                  child: new TextFormField(
                    controller: _controllerTelefone,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [maskTextTelefone],
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: new InputDecoration(
                      icon: new Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      errorText: null,
                      border: InputBorder.none,
                      hintText: "Telefone",
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
          stream: widget.bloc.stream,
          initialData: 0,
          builder: (context, snapshot) {
            return RaisedButton(
              child: _setUpButtonChild(snapshot.data),
              color: AZUL_INPAY,
              padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
                Usuario usuario = new Usuario(
                    email: _controllerEmail.text,
                    nome: _controllerNome.text,
                    senha: _controllerSenha.text,
                    telefone: _controllerTelefone.text);
                _cadastrarUsuario(context, usuario);
              },
            );
          },
        ),
      ],
    );
  }

  /// Widget responsável por criar parte do botão de login, retornando texto, progress ou check
  Widget _setUpButtonChild(int value) {
    if (value == 0) {
      return Container(
        child: Text(
          "Criar Conta",
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

  /// Widget responsável por gerar a linha inferior para recuperação de senha e criação de conta
  Widget _bottomRow(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SafeArea(
          minimum: EdgeInsets.only(bottom: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  'Já possui uma conta?',
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
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 35,
                  width: _media.width / 5,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Entrar',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: Colors.white,
                        fontSize: 13.0,
                      ),
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

  /// Realiza as verificações relacionadas ao cadastro do usuário
  _cadastrarUsuario(BuildContext context, Usuario usuario) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (!usuario.isSignUpFieldsFilled) {
      Scaffold.of(context).showSnackBar(snackbarPreencherCampos);
    } else if ((connectivityResult) == ConnectivityResult.none) {
      Scaffold.of(context).showSnackBar(snackbarConexao);
    } else {
      widget.bloc.atualizar();
      ReturnStatus retorno = await Auth().signUp(usuario);

      if (retorno == ReturnStatus.SUCCESS) {
        widget.bloc.atualizar();
        Scaffold.of(context).showSnackBar(snackbarUsuarioCadastrado);
        await Auth().signOut();
        Timer(Duration(milliseconds: 1500), () {
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
