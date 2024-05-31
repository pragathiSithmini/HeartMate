// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:heartmate_frontend/constants.dart';

class NegativeCard extends StatelessWidget {
  const NegativeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: kPrimaryColor
      ),
      margin: EdgeInsets.all(25),
      child: Text(
        'Congratualtions!'
        '\n\nYou are not at the risk of being a heart patient in the coming 10 years'
        '\n\nKeep up the good health',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 25,
        ),
      ),
    );
  }
}
