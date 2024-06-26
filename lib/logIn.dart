import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:friendless/HomePage.dart';
import 'package:friendless/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendless/HomePage.dart';

import 'congratulations.dart';
import 'firebase_options.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var _searchTerm;

  // Firebase Authentication nesnesi oluştur
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login fonksiyonu
  void _login() async {
    try {
      // Kullanıcı adı ve şifre ile giriş yap
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _usernameController.text,
        password: _passwordController.text,
      );

      // Giriş başarılı ise kullanıcı bilgilerini alabilirsiniz
      User? user = userCredential.user;

      // Kullanıcı bilgilerini kullanabilirsiniz, örneğin kullanıcı adını yazdırabiliriz:
      print('Logged in user: ${user!.uid}');

      Navigator.pushNamed(context, '/routeHomepage');

      // İşlem başarılı olduysa, bir sonraki sayfaya yönlendirebilirsiniz
      // Örneğin: Navigator.pushNamed(context, '/home');
    } catch (e) {
      // Hata durumunda, hatayı yazdırabiliriz
      print('Login failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xff8974b2),
                  Color(0xffb74f00),
                ]),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'Hello\nWELCOME to friENDLESS!',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.deepPurpleAccent,width: 3)),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          label: Text(
                            'Username',
                            style: TextStyle(

                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                          ),
                        ),
                        controller: _usernameController,
                      ),
                      SizedBox(height: 20),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(

                          label: Text(
                            'Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                          ),
                        ),
                        controller: _passwordController,
                      ),
                                          SizedBox(height: 70),
                      GestureDetector(
                        onTap: _login,
                        child: Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff8974b2),
                                Color(0xffb74f00),
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
