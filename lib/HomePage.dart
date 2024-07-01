import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:friendless/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'congratulations.dart';
import 'firebase_options.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

FirebaseFirestore obje = FirebaseFirestore.instance;
CollectionReference objectCollectionRef =
obje.collection('Questions');

int i = 1;
int score = 0;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
        title: Text('Friendless - Personality test'),
        centerTitle: true,
        backgroundColor: Theme.of(context).hintColor,
      ),
            Color(0xff8974b2),
            Color(0xffb74f00),
          ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(//
              child: Text(
                "Personality Test",
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500, fontSize: 36),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Theme.of(context).hintColor,
              ),
              child: Center(
                child: FutureBuilder<String>(
                  future: giveQuestion(context, i),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          snapshot.data ?? '',
                          style: TextStyle( color: Colors.white,
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            Column(
              children: [
                buildButton(context, "Strongly Agree", 2),
                buildButton(context, "Agree", 1),
                buildButton(context, "Neutral", 0),
                buildButton(context, "Disagree", -1),
                buildButton(context, "Strongly Disagree", -2),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, String text, int scoreIncrement) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Color(0x3df2a1b6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          onPressed: () async {
            setState(() {
              score += scoreIncrement;
              print(score);
              i++;
            });
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

Future<String> giveQuestion(BuildContext context, int sayi) async {
  if (sayi == 11) {
    await Future.delayed(Duration.zero);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CongPage(score)),
    );
    return '';
  } else {
    var truvaRef = objectCollectionRef.doc('question${sayi}');
    var response = await truvaRef.get();
    var rData = (response.data() as Map<String, dynamic>)['question'];
    return rData;
  }
}
