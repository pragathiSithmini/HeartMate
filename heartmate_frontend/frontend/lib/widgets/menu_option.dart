// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:heartmate_frontend/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuOption extends StatelessWidget {
  final String title;
  final String img;
  const MenuOption({Key? key, required this.title, required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            img,
            width: 70,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            title,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
