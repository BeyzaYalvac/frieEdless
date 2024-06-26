import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final List<Map<String, dynamic>> rightSwipedPersons;
  final int index;

  ChatPage({
    required this.rightSwipedPersons,
    required this.index,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  List<String> _messages = [];

  void _sendMessage() {
    setState(() {
      _messages.add(_controller.text);
      _controller.clear();
    });
  }

  String _buildAppBarTitle() {
    // Ensure index is within bounds
    if (widget.index >= 0 && widget.index < widget.rightSwipedPersons.length) {
      return '${widget.rightSwipedPersons[widget.index]['person_name']} ${widget.rightSwipedPersons[widget.index]['person_surname']}';
    } else {
      return 'Chat'; // Fallback title
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_buildAppBarTitle()),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_messages[index]),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _sendMessage();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
