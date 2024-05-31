// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:heartmate_frontend/constants.dart';

class TipCard extends StatelessWidget {
  final String tip;
  final String tipNumber;
  final height;
  const TipCard({
    Key? key, 
    required this.tip,
    required this.tipNumber,
    this.height,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(15),
      height: size.height*height,
      width: size.width*0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: <Widget>[
          Image.asset(
            "assets/icons/heart.png",
            width: 50,
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tipNumber,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text(tip)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
