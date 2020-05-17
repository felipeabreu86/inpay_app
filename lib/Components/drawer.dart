import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inpay_app/Components/circleAvatar.dart';
import 'package:inpay_app/Services/appInfo.dart';
import 'package:inpay_app/Services/firestore.dart';
import 'package:inpay_app/Utils/constants.dart';

class HomeDrawer extends StatelessWidget {
  final VoidCallback logoutCallback;
  final String urlImagem = Database().usuarioLogado?.urlImagem ?? "";
  final String versao = AppInfo().version;

  HomeDrawer(this.logoutCallback);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[AZUL_INPAY, AZUL_INPAY],
              ),
            ),
            child: Container(
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      print('pressionou o icone');
                    },
                    child: circleAvatar(
                      55,
                      53,
                      urlImagem,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      Database().usuarioLogado.nome,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomListTile(Icons.person, 'Perfil', () {
            Timer(Duration(milliseconds: 300), () {
              Navigator.pop(context);
            });
          }),
          CustomListTile(Icons.notifications, 'Notificações', () {
            Timer(Duration(milliseconds: 300), () {
              Navigator.pop(context);
            });
          }),
          CustomListTile(Icons.settings, 'Configurações', () {
            Timer(Duration(milliseconds: 300), () {
              Navigator.pop(context);
            });
          }),
          CustomListTile(Icons.lock, 'Sair', () {
            Timer(Duration(milliseconds: 300), () {
              logoutCallback();
            });
          }),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 6, right: 7),
              child: Text(
                'Versão: $versao',
                style: TextStyle(fontSize: 10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade400),
          ),
        ),
        child: InkWell(
          splashColor: Colors.blueAccent,
          onTap: onTap,
          child: Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
