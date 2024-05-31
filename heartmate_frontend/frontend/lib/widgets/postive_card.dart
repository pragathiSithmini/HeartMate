// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:heartmate_frontend/constants.dart';

class PositiveCard extends StatelessWidget {
  const PositiveCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: kPrimaryColor),
      margin: EdgeInsets.all(25),
      child: Text(
        'Alert!'
        '\n\nYou are potentially at the risk of being a heart patient in the coming 10 years'
        '\n\nPlease view our recommended health tips and lifestyle changes for more information',
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
