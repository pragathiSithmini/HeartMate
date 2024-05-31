// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:heartmate_frontend/constants.dart';

class DisplayTest extends StatelessWidget {
  final Map test;
  const DisplayTest({
    Key? key,
    required this.test
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                  "assets/icons/record.png",
                  height: size.height * 0.2,
                  width: size.width * 0.2,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                'Test Results',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              // margin: EdgeInsets.only(bottom: 25),
              // ignore: prefer_const_constructors
              child: Text(
                'Date : ' + test['date'] ,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              // margin: EdgeInsets.only(bottom: 25),
              child: Text(
                'Age : ' + test['age'],
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              // margin: EdgeInsets.only(bottom: 25),
              child: Text(
                'Systolic Blood Pressure : ' + test['sysBP'] + ' mmHg',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              // margin: EdgeInsets.only(bottom: 25),
              child: Text(
                'Has Hypertention? : ' + test['prevelantHyp'],
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              // margin: EdgeInsets.only(bottom: 25),
              child: Text(
                'Diastolic Blood Pressure : ' + test['diaBP'] + ' mmHg',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              // margin: EdgeInsets.only(bottom: 25),
              child: Text(
                'Glucose Level : ' + test['glucose'] + ' mg/dL',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              // margin: EdgeInsets.only(bottom: 25),
              child: Text(
                'Gender : ' + test['gender'],
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              // margin: EdgeInsets.only(bottom: 25),
              child: Text(
                'Has Diabetes? : ' + test['diabetes'],
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              // margin: EdgeInsets.only(bottom: 25),
              child: Text(
                'Total Cholesterol Level : ' + test['totChol'] + ' mg/dL',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              // margin: EdgeInsets.only(bottom: 25),
              child: Text(
                'On mediction for Blood Pressure? : ' + test['bpMeds'],
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              // margin: EdgeInsets.only(bottom: 25),
              child: Text(
                'BMI : ' + test['bmi'],
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              // margin: EdgeInsets.only(bottom: 25),
              child: Text(
                'Result : ' + test['result'],
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
