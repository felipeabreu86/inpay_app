import 'package:flutter/material.dart';
import 'package:inpay_app/Components/drawer.dart';
import 'package:inpay_app/Enums/telasBottomNavigation.dart';
import 'package:inpay_app/Screens/Erro/erroScreen.dart';
import 'package:inpay_app/Screens/Home/homeBloc.dart';
import 'package:inpay_app/Utils/constants.dart';

/// Tela Home - Exibida após o login do usuário
class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.userId, this.logoutCallback}) : super(key: key);

  final VoidCallback logoutCallback;
  final String userId;
  final bloc = HomeBloc();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(widget.logoutCallback),
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("assets/images/logotype/logo_inpay.png", height: 40),
        backgroundColor: AZUL_INPAY,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder<Widget>(
        stream: widget.bloc.telaStream,
        initialData: widget.bloc.recuperarTelaInicial(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErroScreen();
          } else {
            return snapshot.data;
          }
        },
      ),
      floatingActionButton: StreamBuilder<int>(
        stream: widget.bloc.floatingActionButtonStream,
        initialData: 0,
        builder: (context, snapshot) {
          var _indexPressed = snapshot.data;
          var corItem = _indexPressed == TelasBottomNavigation.LIFE.index
              ? Colors.yellow
              : Colors.white;
          return FloatingActionButton(
            backgroundColor: AZUL_INPAY,
            onPressed: () {
              widget.bloc.atualizarTela(TelasBottomNavigation.LIFE);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.home, color: corItem),
                Text("LIFE", style: TextStyle(fontSize: 11, color: corItem)),
              ],
            ),
            elevation: 5.0,
          );
        },
      ),
      bottomNavigationBar: StreamBuilder<int>(
        stream: widget.bloc.bottomNavigationStream,
        initialData: 0,
        builder: (context, snapshot) {
          var _indexPressed = snapshot.data;
          return BottomAppBar(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: IconButton(
                    icon: new Tab(
                      icon: Container(
                        child: Image(
                          image: AssetImage(
                            _indexPressed == TelasBottomNavigation.BANCO.index
                                ? 'assets/images/icon/pig_bank_icon_2.png'
                                : 'assets/images/icon/pig_bank_icon.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    onPressed: () {
                      widget.bloc.atualizarTela(TelasBottomNavigation.BANCO);
                    },
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: new Tab(
                      icon: Container(
                        child: Image(
                          image: AssetImage(
                            _indexPressed == TelasBottomNavigation.BARRAS.index
                                ? 'assets/images/icon/bars_free_icon_2.png'
                                : 'assets/images/icon/bars_free_icon.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    onPressed: () {
                      widget.bloc.atualizarTela(TelasBottomNavigation.BARRAS);
                    },
                  ),
                ),
                Expanded(child: new Text('')),
                Expanded(
                  child: IconButton(
                    icon: new Tab(
                      icon: Container(
                        child: Image(
                          image: AssetImage(
                            _indexPressed ==
                                    TelasBottomNavigation.ESCALADA.index
                                ? 'assets/images/icon/climb_icon_2.png'
                                : 'assets/images/icon/climb_icon.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    onPressed: () {
                      widget.bloc.atualizarTela(TelasBottomNavigation.ESCALADA);
                    },
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: new Tab(
                      icon: Container(
                        child: Image(
                          image: AssetImage(
                            _indexPressed == TelasBottomNavigation.BONUS.index
                                ? 'assets/images/icon/bonus_icon_2.png'
                                : 'assets/images/icon/bonus_icon.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    onPressed: () {
                      widget.bloc.atualizarTela(TelasBottomNavigation.BONUS);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
