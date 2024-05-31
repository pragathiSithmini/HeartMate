// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:heartmate_frontend/constants.dart';
import 'package:heartmate_frontend/widgets/tip_card.dart';
import 'package:heartmate_frontend/widgets/postive_card.dart';
import 'package:heartmate_frontend/widgets/negative_card.dart';

class Prediction extends StatelessWidget {
  final Widget resultCard;
  const Prediction({
    Key? key,
    required this.resultCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF9FA8DA),
      appBar: AppBar(
        backgroundColor:kPrimaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              child: resultCard,
            ),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.white,
              alignment: Alignment.topCenter,
              // margin: EdgeInsets.only(bottom: 25),
              child: Text(
                'Here are some Health Care Tips',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
            ),
            SizedBox(height: 10),
            TipCard(tip: "Do you know..?  Etating Fatty fish (like Salmon, Mackerel, Herring, Haddock) decrease the risk"
                " of arrhythmia and atherosclerosis. iorn, Zinc, And Selenium they boost our health and fight"
                " heart disease", tipNumber: 'Tip 1', height: 0.25),
            TipCard(
                tip:
                    "Do you know..? Drinking Red wine reduces fat deposits in your blood vessels and assists in"
                        "detoxification and weigtht loss. It is able to reduce the risk of dementia and prostate cancer.", tipNumber: 'Tip 2', height: 0.2),
            TipCard(
                tip:
                    "Do you know..? Bio active compounds contained in green tea improves health."
                        "it has positive influence on the process of fat burning boosting the rate of metabolism.", tipNumber: 'Tip 3', height: 0.2),
            TipCard(
                tip:
                    "Maintain an active life style and engage in minimum 20 minutes of physical exercises daily", tipNumber: 'Tip 4',height: 0.15),
            TipCard(
                tip:
                    "Practice good dental hygiene"
                        "bacteria in the mouth help develop heart risk", tipNumber: 'Tip 5',height: 0.15),
            TipCard(
                tip:
                    "Get enough sleep"
                        "Sleep is an essential part in human life style and affects mental and physical health"
                        " therefore you shoud sleep 8 hours for a day", tipNumber: 'Tip 6', height: 0.2),
          ],
        ),
      ),
    );
  }
}
