import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inpay_app/Enums/telasBottomNavigation.dart';
import 'package:inpay_app/Screens/Home/homeNavegacao.dart';

class HomeBloc {
  final _telaController = StreamController<Widget>();
  final _bottomNavigationController = StreamController<int>();

  /// Streams para observar os eventos deste Bloc
  Stream<Widget> get telaStream => _telaController.stream;
  Stream<int> get bottomNavigationStream => _bottomNavigationController.stream;

  /// Atualiza o índice da tela exibida na Home e adiciona ao StreamController
  void atualizarTela(TelasBottomNavigation tela) {
    NavegacaoHome().atualizarTela(tela);
    _telaController.sink.add(NavegacaoHome().telaAtual);
    _bottomNavigationController.sink.add(tela.index);
  }

  /// Recupera a Widget da tela inicial
  Widget recuperarTelaInicial() {
    NavegacaoHome().atualizarTela(TelasBottomNavigation.LIFE);
    return NavegacaoHome().telaAtual;
  }

  /// Fecha a Stream
  fecharStream() {
    _telaController.close();
    _bottomNavigationController.close();
  }
}
