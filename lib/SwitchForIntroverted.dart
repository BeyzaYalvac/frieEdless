import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ChatPage.dart';

class SwitchForIntrevertedPage extends StatefulWidget {
  const SwitchForIntrevertedPage({Key? key}) : super(key: key);

  @override
  _SwitchForIntrevertedPageState createState() => _SwitchForIntrevertedPageState();
}

class _SwitchForIntrevertedPageState extends State<SwitchForIntrevertedPage> {
  List<Map<String, dynamic>> persons = [];
  List<Map<String, dynamic>> rightSwipedPersons = [];
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
      persons = documents.map((doc) => doc.data() as Map<String, dynamic>).where((person) =>
          ['neutral','introverted'].contains(person['person_personality'])).toList();
    });
  }

  void _goToChatPeople(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ChatPeople(rightSwipedPersons: rightSwipedPersons)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        body: Container(
          height: double.infinity,
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
                if (direction == DismissDirection.startToEnd) {
                  rightSwipedPersons.add(persons[currentIndex]);
                }
                setState(() {
                  currentIndex += 1;
                });

                if (currentIndex >= persons.length) {
                  _goToChatPeople(context);
                } else {
                  String action = direction == DismissDirection.startToEnd ? 'sağa' : 'sola';
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${persons[currentIndex - 1]['person_name']} $action kaydırıldı')),
                  );
                }
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
              child: currentIndex < persons.length
                  ? _buildCard(persons[currentIndex])
                  : Container(), // Handle case when all cards are swiped
            ),
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

class ChatPeople extends StatelessWidget {
  final List<Map<String, dynamic>> rightSwipedPersons;

  ChatPeople({required this.rightSwipedPersons});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).hintColor,
          title: Text('Your Favorite People'),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: SweepGradient(
              colors: [
                Color(0xff8974b2),
                Color(0xffb74f00),
              ],
            ),
          ),
          child: Center(
            child: rightSwipedPersons.isEmpty
                ? Text('No people swiped right.')
                : ListView.builder(
              itemCount: rightSwipedPersons.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(

                    shadowColor: Colors.black,
                    color: Color(0x3df2a1b6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 8,
                    child: ListTile(

                      contentPadding: EdgeInsets.all(16.0),
                      title: Text(
                        '${rightSwipedPersons[index]['person_name']} ${rightSwipedPersons[index]['person_surname']}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        'Age: ${rightSwipedPersons[index]['person_age']} | Country: ${rightSwipedPersons[index]['person_country']}',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(
                          rightSwipedPersons[index]['person_name'][0],
                          style: TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      trailing: Icon(Icons.message), // Mesaj ikonu
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(rightSwipedPersons: rightSwipedPersons,index: index,),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
