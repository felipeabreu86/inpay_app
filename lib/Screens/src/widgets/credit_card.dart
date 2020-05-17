import 'package:flutter/material.dart';
import 'package:inpay_app/Screens/src/models/credit_card_model.dart';

class CreditCard extends StatelessWidget {
  final CreditCardModel card;

  CreditCard({Key key, this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Material(
      elevation: 1,
      shadowColor: Colors.grey.shade300,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            width: _media.width - 40,
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Nº do Cartão",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  card.cardNo,
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Expira em",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(card.expiryDate,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ))
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: Container(
              height: 25,
              width: 50,
              //color: Colors.pink,
              padding: EdgeInsets.all(7),
              child: Container(), /*Image.network(
                card.logo,
                width: 50,
                color: Colors.white,
              ),*/
            ),
          ),
        ],
      ),
    );
  }
}
