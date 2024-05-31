// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:heartmate_frontend/constants.dart';
import 'package:heartmate_frontend/screens/display_test_screen.dart';

class ViewTest extends StatelessWidget {
  final List testList;
  const ViewTest({Key? key, required this.testList}) : super(key: key);

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
                  "assets/icons/previous-test.png",
                  height: size.height * 0.2,
                  width: size.width * 0.2,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                'Previous Tests',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
              ),
            ),
            Column(
              children: testList.map((test) {
                return InkWell(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.all(15),
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/icons/record.png",
                          width: 50,
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(test["name"],
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(fontSize: 15)),
                              Text(test["date"])
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    print(test.runtimeType);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return DisplayTest(test: test);
                      }),
                    );
                  },
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
