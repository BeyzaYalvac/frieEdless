import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'Switch.dart';

class CongPage extends StatefulWidget {
  final int score;

  CongPage(this.score);

  @override
  State<CongPage> createState() => _CongPageState();
}

class _CongPageState extends State<CongPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(color: Colors.green),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check,
                color: Colors.white,
                size: 80,
              ),
              SizedBox(height: 20),
              Text(
                'Congratulations! You did the test!',
                style: TextStyle(color: Colors.white, fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Personality(widget.score),
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SwitchPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Do you want to meet your personality soulmate?',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text Personality(int score) {
    if (score > -20 && score <= -10) {
      return Text('Your personality is: Social', style: TextStyle(color: Colors.white, fontSize: 20));
    } else if (score > -10 && score <= 0) {
      return Text('Your personality is: Extrovert', style: TextStyle(color: Colors.white, fontSize: 20));
    } else if (score > 0 && score <= 10) {
      return Text('Your personality is: Neutral', style: TextStyle(color: Colors.white, fontSize: 20));
    } else if (score > 10 && score <= 20) {
      return Text('Your personality is: Introverted', style: TextStyle(color: Colors.white, fontSize: 20));
    } else {
      return Text('Your personality is: Reserved', style: TextStyle(color: Colors.white, fontSize: 20));
    }
  }
}
