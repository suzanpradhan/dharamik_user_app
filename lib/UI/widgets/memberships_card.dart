import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MemberShipCard extends StatelessWidget {
  const MemberShipCard({
    this.cardDiscription,
    this.cardName,
    this.cardRecommendation,
    this.cardPrice,
    this.onOffer,
    this.callback
  });
  final String cardName;
  final String cardRecommendation;
  final String cardDiscription;
  final int cardPrice;
  final bool onOffer;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
          color: Colors.red),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  cardName,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize:
                          (context.mdWindowSize == MobileWindowSize.xsmall)
                              ? 21
                              : 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              (onOffer == true)
                  ? Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Text(
                        'On Offer',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    )
                  : Container()
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Divider(
            color: Colors.black,
            height: 5,
          ),
          Text(
            cardRecommendation,
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            cardDiscription,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  print('Read More Pressed');
                },
                child: Text('Read More',
                    style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        fontSize: 17.0)),
              ),
              Column(
                children: [
                  Text('₹${cardPrice.toString()}/-',
                      style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontSize: 21.0)),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: FlatButton(
                      onPressed: callback,
                      child: Text(
                        'BUY/UPGRADE NOW',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
