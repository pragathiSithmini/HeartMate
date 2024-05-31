// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:heartmate_frontend/constants.dart';
import 'package:heartmate_frontend/screens/display_test_screen.dart';
import 'package:heartmate_frontend/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchTest extends StatefulWidget {
  final int userId;
  const SearchTest({Key? key, required this.userId}) : super(key: key);

  @override
  State<SearchTest> createState() => _SearchTestState(userId);
}

class _SearchTestState extends State<SearchTest> {
  int userId;
  _SearchTestState(this.userId);

  @override
  void initState() {
    _getDateList();
    super.initState();
  }

  List? dateList;
  String? _myDate;

  String Url = 'https://heart-mate.herokuapp.com/dates?userId=';
  Future<String?> _getDateList() async {
    var data = await fetchdata(Url + userId.toString());
    var decoded = json.decode(data);

    setState(() {
      dateList = decoded["result"];

      print(dateList);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF9FA8DA),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/icons/calendar.png",
                  height: size.height * 0.2,
                  width: size.width * 0.2,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                'Select a Date',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 5),
              width: size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          value: _myDate,
                          iconSize: 30,
                          icon: (null),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                          hint: Text('Select a Date'),
                          onChanged: (String? newValue) {
                            setState(() {
                              _myDate = newValue!;
                              print(_myDate);
                            });
                          },
                          items: dateList?.map((item) {
                            return new DropdownMenuItem(
                              child: new Text(item['date'].toString()),
                              value: item['testId'].toString(),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.3,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 30, 30, 30),
              width: 200,
              height: 50.0,
              child: RaisedButton(
                onPressed: () async {
                  if (_myDate == null) {
                    confirm(context);
                  } else {
                    print(_myDate);
                    final url = 'https://heart-mate.herokuapp.com//searchtest';

                    final response = await http.post(Uri.parse(url),
                        body: json.encode({"testId": _myDate}));

                    var decoded = json.decode(response.body);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return DisplayTest(test: decoded['result']);
                      }),
                    );
                  }
                },
                color: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void confirm(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("Oh! Darling"),
      content: Text("You have not selected a date neh :("),
      // ignore: prefer_const_literals_to_create_immutables
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "Ok",
          ),
        )
      ],
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }
}
