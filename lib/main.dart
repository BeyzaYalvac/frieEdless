import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:friendless/SwitchForExtrovert.dart';
import 'package:friendless/SwitchForIntroverted.dart';
import 'package:friendless/SwitchForNeutral.dart';
import 'package:friendless/SwitchForReversed.dart';
import 'package:friendless/SwitchForSocial.dart';
import 'package:friendless/services/auth.dart';
import 'package:provider/provider.dart';

import 'ChatPage.dart';
import 'HomePage.dart';
import 'Register.dart';
import 'Switch.dart';
import 'congratulations.dart';
import 'firebase_options.dart';
import 'logIn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Provider<Auth>(
      create: (context) => Auth(),
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Color(0xff8974b2),
            secondaryHeaderColor: Color(0xffb74f00),
            hintColor: Color(0x3df2a1b6)),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/routeHomepage': (context) => HomePage(),
          '/loginPage': (context) => LoginPage(),
          '/registerPage': (context) => RegPage(),
          '/CongratualitonsPage': (context) => CongPage(score),
          '/switchPage': (context) => SwitchPage(),
          '/chatPage': (context) => ChatPage(rightSwipedPersons: [],index:i),
          '/switchForReversed': (context) => SwitchForReversedPage(),
          '/switchForIntroverted': (context) => SwitchForIntrevertedPage(),
          '/switchForExtroverted': (context) => SwitchForExtrovertPage(),
          '/switchForNeutral': (context) => SwitchForNeutralPage(),
          '/switchForSocial': (context) => SwitchForSocialPage(),
        },
        home: const WelcomeScreen(),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff8974b2),
                Color(0xffb74f00),
              ],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 120.0),
                child: const Text(
                  'Welcome to',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Image(
                  width: 1500,
                  image: AssetImage('assets/FriEndless.png'),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              const SizedBox(height: 30),
              GestureDetector(
                
                onTap: () {
                  Navigator.pushNamed(context, '/loginPage');
                },
                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Center(
                    child: Text(
                      'LOG IN',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/registerPage');
                },
                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Center(
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
