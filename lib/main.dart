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
      create: ( context) => Auth(),
      child: MaterialApp(
        initialRoute: '/', // Başlangıç rotası olarak kullanılabilir
        routes: {
          '/routeHomepage': (context) => HomePage(),
          '/CongratualitonsPage':(context)=>CongPage(score),
        },
        home: LoginPage(),// Başlangıç sayfası olarak LoginPage belirtildi
      ),
    );
  }
}

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
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.deepPurpleAccent[100]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (String val) => _searchTerm = val,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderSide: BorderSide.none),
                labelText: 'Username',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.white,
                  backgroundColor: Colors.indigo,
                ),
                hintText: 'your_user_name',
                hintStyle: TextStyle(color: Colors.indigo[400], fontSize: 20),
                prefixIcon: Icon(
                  Icons.verified_user,
                  color: Colors.indigo,
                ),
              ),
              controller: _usernameController,
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true, // Şifrenin görünmemesi için
              onChanged: (String val) => _searchTerm = val,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderSide: BorderSide.none),
                labelText: 'Password',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.white,
                  backgroundColor: Colors.indigo,
                ),
                hintText: 'your_password',
                hintStyle: TextStyle(color: Colors.indigo[400], fontSize: 20),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.indigo,
                ),
              ),
              controller: _passwordController,
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ElevatedButton(
                onPressed: _login, // Login fonksiyonunu çağırın
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                style: ElevatedButton.styleFrom(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


