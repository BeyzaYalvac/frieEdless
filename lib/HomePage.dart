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
FirebaseFirestore.instance.collection(('Questions'));

int i=1;
int score=0;
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friendless'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: Text(
              "Personality Test",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              border: Border.all(width: 6),
            ),
            child: FutureBuilder<String>(
              future: giveQuestion(context,i),
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
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  );
                }
              },
            ),
          ),
          Column(
            children: [
              OutlinedButton(
                onPressed: () async {
                  setState(() {
                    i++;// Soru sayısını bir artır
                    score+=2;
                    print(score);

                  });
                },
                child: Text("Strongly Agree"),
              ),
              OutlinedButton(
                onPressed: () async {
                  setState(() {
                    i++; // Soru sayısını bir artır
                    score+=1;
                    print(score);

                  });
                },
                child: Text("Agree"),
              ),
              OutlinedButton(
                onPressed: () async {
                  setState(() {
                    i++; // Soru sayısını bir artır
                    score+=0;
                    print(score);

                  });
                },
                child: Text("Neutral"),
              ),
              OutlinedButton(
                onPressed: () async {
                  setState(() {
                    i++; // Soru sayısını bir artır
                    score-=1;
                    print(score);

                  });
                },
                child: Text("Disagree"),
              ),  OutlinedButton(
                onPressed: () async {
                  setState(() {
                    i++;
                    score-=2;
                    print(score);

                  });
                },
                child: Text("Strongly Disagree"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<String> giveQuestion(BuildContext context, int sayi) async {
  if (sayi == 11) {

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CongPage(score)),
    );
    return "11. soru"; // Örnek bir dönüş
  } else {
    var truvaRef = objectCollectionRef.doc('question${sayi}');
    var response = await truvaRef.get();
    var rData = (response.data() as Map<String, dynamic>)['question'];
    return rData;
  }
}


