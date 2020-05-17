import 'package:flutter/material.dart';
import 'package:inpay_app/Enums/telasBottomNavigation.dart';
import 'package:inpay_app/Screens/Home/Life/lifeScreen.dart';

/// Classe responsável por controlar a navegação entre as telas da barra de navegação da Home
class NavegacaoHome {
  static final NavegacaoHome _singleton = NavegacaoHome._internal();

  factory NavegacaoHome() {
    return _singleton;
  }

  NavegacaoHome._internal();

  /// Mantém o índice da tela exibida
  int _indexTela = 0;

  /// Método responsável por atualizar o índice da tela
  atualizarTela(TelasBottomNavigation tela) {
    _indexTela = tela.index;
  }

  /// Lista de telas
  List<Widget> _telas = List<Widget>();

  /// Retorna a tela atual
  Widget get telaAtual => _getListaTelas()[_indexTela];

  /// Retorna a lista de telas.
  /// Inicializa a lista caso esteja vazia.
  _getListaTelas() {
    if (_telas.isEmpty) {
      _telas = new List(TelasBottomNavigation.values.length);
      _telas[TelasBottomNavigation.LIFE.index] = LifeScreen();
      _telas[TelasBottomNavigation.BANCO.index] = Text('Tela banco');
      _telas[TelasBottomNavigation.BARRAS.index] = Text('Tela barras');
      _telas[TelasBottomNavigation.ESCALADA.index] = Text('Tela escalada');
      _telas[TelasBottomNavigation.BONUS.index] = Text('Tela bonus');
    }
    return _telas;
  }
}
