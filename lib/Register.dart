import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'logIn.dart';

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  late String email, password, name;
  final formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return true;
      },
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Stack(
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
                    'Create Your\nAccount',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.deepPurpleAccent,width: 3))
                  ),
                  height: double.infinity,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please fill all fields!";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            name = value!;
                          },
                          decoration: const InputDecoration(

                            label: Text(
                              'Full Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:  Color(0xffb74f00),
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please fill all fields!";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            email = value!;
                          },
                          decoration: const InputDecoration(

                            label: Text(
                              'Hotmail or Gmail',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:  Color(0xffb74f00),
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please fill all fields!";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            password = value!;
                          },
                          decoration: const InputDecoration(

                            label: Text(
                              'Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:  Color(0xffb74f00),
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: confirmPasswordController,

                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please fill all fields!";
                            }
                            if (value.length < 8) {
                              return "Password must be at least 8 characters long!";
                            }
                            if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                              return "Password cannot contain special characters!";
                            }
                            return null;
                          },

                          decoration: const InputDecoration(

                            label: Text(
                              'Confirm Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:  Color(0xffb74f00),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 70),
                        ElevatedButton(
                          onPressed: () async{
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              try{
                                var userResult= await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print('yeni user kayıt edildi ${userResult.user!.uid}');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginPage()),
                                );
                              }
                              catch(e){
                                print(e);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ).copyWith(
                            backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.transparent;
                                }
                                return Colors.transparent;
                              },
                            ),
                            elevation: MaterialStateProperty.all(0.0),
                            shadowColor: MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xff8974b2),
                                  Color(0xffb74f00),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Container(
                              height: 55,
                              width: 300,
                              alignment: Alignment.center,
                              child: const Text(
                                'SIGN IN',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 80),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
