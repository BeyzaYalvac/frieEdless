import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SwitchPage extends StatefulWidget {
  const SwitchPage({Key? key}) : super(key: key);

  @override
  _SwitchPageState createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  List<Map<String, dynamic>> persons = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchPersons();
  }

  Future<void> _fetchPersons() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Persons').get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

    setState(() {
      persons = documents.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container( height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff8974b2),
            Color(0xffb74f00),
          ]),
        ),
        child: Center(
          child: persons.isEmpty
              ? CircularProgressIndicator()
              : Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            onDismissed: (direction) {
              setState(() {
                currentIndex = (currentIndex + 1) % persons.length;
              });
              String action = direction == DismissDirection.startToEnd ? 'sağa' : 'sola';
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${persons[currentIndex-1]['person_name']} $action kaydırıldı')),
              );
            },
            background: Container(

              color: Color(0xff8974b2),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(Icons.check, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Color(0xffb74f00),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: _buildCard(persons[currentIndex]),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> personData) {
    String personName = personData['person_name'];
    String personSurname = personData['person_surname'];
    String personPersonality = personData['person_personality'];
    String personCountry = personData['person_country'];
    int personAge = personData['person_age'];
    String personHoroscope = personData['person_horoscope'];

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                  image: DecorationImage(
                    image: AssetImage('assets/kiz1.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$personName $personSurname',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.deepPurpleAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '$personPersonality',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Chip(
                          label: Text(
                            '$personAge',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.green,
                        ),
                        SizedBox(width: 8.0),
                        Chip(
                          label: Text(
                            '$personCountry',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.deepOrange,
                        ),
                        SizedBox(width: 8.0),
                        Chip(
                          label: Text(
                            '$personHoroscope',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.deepPurpleAccent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
