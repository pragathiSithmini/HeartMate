// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:heartmate_frontend/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heartmate_frontend/widgets/menu_option.dart';
import 'package:heartmate_frontend/screens/test_input_screen.dart';
import 'package:heartmate_frontend/screens/view_test_screen.dart';
import 'package:heartmate_frontend/screens/search_test_screen.dart';
import 'package:heartmate_frontend/screens/login-screeen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Menu extends StatelessWidget {
  final String userName;
  final int userId;
  const Menu({Key? key, required this.userName, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9FA8DA),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Icon(
                Icons.logout,
                size: 40.0,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Hi " + userName,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Menu",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/icons/user.png",
                    width: 60,
                    height: 60,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Flexible(
            child: GridView.count(
              childAspectRatio: .80,
              padding: EdgeInsets.only(left: 16, right: 16),
              crossAxisCount: 2,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return TestInput(
                          userId: userId,
                        );
                      }),
                    );
                  },
                  child: MenuOption(
                    title: "Take a Test",
                    img: "assets/icons/test.png",
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final url = 'https://heart-mate.herokuapp.com//viewtest';

                    final response = await http.post(Uri.parse(url),
                        body: json.encode({"userId": userId}));

                    var decoded = json.decode(response.body);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return ViewTest(
                          testList: decoded["result"],
                        );
                      }),
                    );
                  },
                  child: MenuOption(
                    title: "View Previous Tests",
                    img: "assets/icons/view.png",
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return SearchTest(
                          userId: userId,
                        );
                      }),
                    );
                  },
                  child: MenuOption(
                    title: "Search Test",
                    img: "assets/icons/search.png",
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) {
                    //     return SelectLocation();
                    //   }),
                    // );
                  },
                  child: MenuOption(
                    title: "View Statistical Report",
                    img: "assets/icons/statistics.png",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
