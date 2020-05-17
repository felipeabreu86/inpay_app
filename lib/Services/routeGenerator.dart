import 'package:flutter/material.dart';
import 'package:inpay_app/Screens/Home/homeScreen.dart';
import 'package:inpay_app/Screens/Login/Cadastro/cadastroScreen.dart';
import 'package:inpay_app/Screens/Login/RecuperarSenha/recuperarSenhaScreen.dart';
import 'package:inpay_app/Utils/constants.dart';
import 'package:inpay_app/main.dart';

/// Classe responsável por definir as rotas do aplicativo
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case INITIAL_ROUTE:
        return new MyCustomRoute(
          builder: (_) => new RootScreen(),
          settings: settings,
        );
      case CADASTRO_ROUTE:
        return new MyCustomRoute(
          builder: (_) => new CadastroScreen(),
          settings: settings,
        );
      case RECUPERAR_SENHA:
        return new MyCustomRoute(
          builder: (_) => new RecuperarSenhaScreen(),
          settings: settings,
        );
      case HOME_ROUTE:
        return new MyCustomRoute(
          builder: (_) => HomeScreen(),
          settings: settings,
        );
    }
    return null;
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    //if (settings.isInitialRoute) return child;
    return new FadeTransition(opacity: animation, child: child);
  }
}
