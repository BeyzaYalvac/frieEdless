import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

class CongPage extends StatefulWidget {

int score;
  @override
  State<CongPage> createState() => _CongPageState();

CongPage(this.score);
}

class _CongPageState extends State<CongPage> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          'friENDLESS',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.green),
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check,color: Colors.white,),
            Text('Congratulations! You did the test!'),
            Personality(score),
            TextButton(onPressed: (){}, child: Text('So Do you wanna meet your personality soulmate?'))
          ],
        ),),
      ),
    );
  }

  Text Personality(int score) {
    if (score > -20 && score <= -10) {
      return Text('Your personality is: Social');
    } else if (score > -10 && score <= 0) {
      return Text('Your personality is: extrovert');
    } else if (score > 0 && score <= 10) {
      return Text('Your personality is: Neutral');
    } else if (score > 10 && score <= 20) {
      return Text('Your personality is: Introverted');
    } else {
      return Text('Your personality is: reserved');
    }
  }
   }


