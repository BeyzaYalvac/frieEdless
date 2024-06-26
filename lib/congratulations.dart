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
              Text(
                _getPersonalityType(widget.score),
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  if (widget.score > -20 && widget.score <= -10) {
                    Navigator.pushNamed(context, '/switchForReversed');
                  } else if (widget.score > -10 && widget.score <= 0) {
                    Navigator.pushNamed(context, '/switchForExtroverted');
                  } else if (widget.score > 0 && widget.score <= 20) {
                    Navigator.pushNamed(context, '/switchForExtroverted');
                  } else {
                    // Handle scores outside the specified ranges
                    Navigator.pushNamed(context, '/switchForExtroverted');
                  }
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

  String _getPersonalityType(int score) {
    if (score > -20 && score <= -10) {
      return ' Reserved';
    } else if (score > -10 && score < 0) {
      return ' Introverted';
    } else if (score == 0) {
      return 'Neutral';
    } else if (score > 0 && score <= 10) {
      return 'Extrovert';
    } else {
      return 'Social';
    }
  }
}
