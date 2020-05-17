import 'package:flutter/material.dart';
import 'package:inpay_app/Components/circularProgressIndicator.dart';
import 'package:inpay_app/Enums/authStatus.dart';
import 'package:inpay_app/Screens/Home/homeScreen.dart';
import 'package:inpay_app/Screens/Login/loginScreen.dart';
import 'package:inpay_app/Services/appInfo.dart';
import 'package:inpay_app/Services/auth.dart';
import 'package:inpay_app/Services/firestore.dart';
import 'package:inpay_app/Services/routeGenerator.dart';
import 'package:inpay_app/Utils/constants.dart';


/// Método principal que inicializa o aplicativo
void main() {
  runApp(
    MaterialApp(
      title: APP_TITLE,
      home: new RootScreen(),
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    ),
  );
}

/// Tela responsável por realizar a verificação de autenticação
/// do usuário e o direcionar para as telas Login ou Home
class RootScreen extends StatefulWidget {
  RootScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState() {
    super.initState();
    // Recuperar dados do usuário
    Auth().getCurrentUser().then((user) {
      if (user != null) {
        _userId = user?.uid;
      }
      loginCallback();
    });
    // Recuperar informações do aplicativo
    AppInfo();
  }

  void loginCallback() {
    Auth().getCurrentUser().then((user) async {
      setState(() {
        if (user?.uid == null) {
          _userId = "";
          authStatus = AuthStatus.NOT_LOGGED_IN;
        } else {
          _userId = user.uid;
          authStatus = AuthStatus.NOT_DETERMINED;
        }
      });
      await Database().recuperarUsuario(_userId).then((onValue) {
        print(onValue.toString());
        setState(() {
          if (onValue?.nome == null) {
            Auth().signOut();
            _userId = "";
            authStatus = AuthStatus.NOT_LOGGED_IN;
          } else {
            _userId = _userId;
            authStatus = AuthStatus.LOGGED_IN;
          }
        });
      });
    });
  }

  void logoutCallback() {
    Auth().signOut();
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return _userId.isEmpty
            ? Container(color: AZUL_INPAY)
            : buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return LoginScreen(
          loginCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new HomeScreen(
            userId: _userId,
            logoutCallback: logoutCallback,
          );
        } else {
          return buildWaitingScreen();
        }
        break;
      default:
        return buildWaitingScreen();
    }
  }
}
