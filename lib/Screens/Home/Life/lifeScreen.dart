import 'dart:async';
import 'package:flutter/material.dart';
import 'package:inpay_app/Screens/src/data/data.dart';
import 'package:inpay_app/Screens/src/pages/overview_page.dart';
import 'package:inpay_app/Screens/src/widgets/credit_card.dart';
import 'package:inpay_app/Screens/src/widgets/payment_card.dart';
import 'package:inpay_app/Services/firestore.dart';
import 'package:inpay_app/Utils/constants.dart';

/// Tela que exibe a vida financeira do usuário
class LifeScreen extends StatefulWidget {
  LifeScreen({Key key}) : super(key: key);

  @override
  _LifeScreenState createState() => _LifeScreenState();
}

class _LifeScreenState extends State<LifeScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  Future<Null> _refresh() {
    return getUser().then((_user) {
      //setState(() => msgNome = _user);
    });
  }

  Future<String> getUser() async {
    return "";
  }

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView(
          padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Container(
              color: Colors.grey.shade50,
              height: _media.height / 3.1,
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Stack(
                          children: <Widget>[
                            Material(
                              elevation: 4,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                    colors: <Color>[
                                      AZUL_INPAY,
                                      Colors.blue,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Opacity(
                              opacity: 0.1,
                              child: Container(
                                color: Colors.black87,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      height: _media.longestSide <= 775
                          ? _media.height / 4
                          : _media.height / 4.3,
                      width: _media.width,
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overscroll) {
                          overscroll.disallowGlow();
                          return true;
                        },
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.only(bottom: 10),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: getCreditCards().length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(top: 15, right: 10),
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OverviewPage())),
                                child: CreditCard(
                                  card: getCreditCards()[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 10,
                    right: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Olá, ${Database().usuarioLogado?.nome ?? "usuário"}!",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "${Database().usuarioLogado?.cpf ?? ""}",
                                    style: TextStyle(
                                      color: Colors.grey[350],
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 36,
                              ),
                              onPressed: () => print("add"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey.shade50,
              width: _media.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25.0, bottom: 10, right: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Todos",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Recebidos",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Enviados",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25.0,
                      bottom: 15,
                      top: 15,
                    ),
                    child: Text(
                      "28 Abril 2020",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overscroll) {
                          overscroll.disallowGlow();
                          return true;
                        },
                        child: ListView.separated(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 85.0),
                              child: Divider(),
                            );
                          },
                          padding: const EdgeInsets.only(bottom: 30.0),
                          itemCount: getPaymentsCard().length,
                          itemBuilder: (BuildContext context, int index) {
                            return PaymentCardWidget(
                              payment: getPaymentsCard()[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
