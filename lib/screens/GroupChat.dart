import 'package:flutter/material.dart';
import 'package:sampark/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msgFieldController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  String msgText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout_outlined),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text(_auth.currentUser.email),
        backgroundColor: Color(0xFF5E67FF),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('messages').snapshots(),
                // ignore: non_constant_identifier_names
                builder: (context, AsyncSnapshot) {
                  if (!AsyncSnapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.amber,
                      ),
                    );
                  } else {
                    final messages = AsyncSnapshot.data.docs.reversed;
                    List<MsgBubble> msgBubbles = [];
                    for (var message in messages) {
                      final messageText = message.get('text');
                      final messageSender = message.get('sender');
                      final currentUser = loggedInUser.email;

                      if (currentUser == messageSender) {
                        // The message From The Logged in user
                      }

                      final messageBubble = MsgBubble(
                          messageSender,
                          messageText,
                          size.aspectRatio * 10,
                          currentUser == messageSender);
                      msgBubbles.add(messageBubble);
                    }
                    return Expanded(
                      child: ListView(
                        reverse: true,
                        padding: EdgeInsets.symmetric(
                            horizontal: size.aspectRatio * 10,
                            vertical: size.aspectRatio * 10),
                        children: msgBubbles,
                      ),
                    );
                  }
                }),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: msgFieldController,
                      onChanged: (value) {
                        msgText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      msgFieldController.clear();
                      if (msgText != null) {
                        // msgText + loggedInUser.email
                        _firestore.collection('messages').add({
                          'text': msgText,
                          'sender': loggedInUser.email,
                        });
                      }
                    },
                    child: Icon(
                      Icons.send,
                      color: Color(0xFF5E67FF),
                    ),
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

class MsgBubble extends StatelessWidget {
  final String sender;
  final String text;
  final double padd;
  final bool isme;
  MsgBubble(this.sender, this.text, this.padd, this.isme);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padd * 3, vertical: padd * 1.8),
      child: Column(
        crossAxisAlignment: isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: padd * 2.3,
              color: Colors.black45,
            ),
          ),
          SizedBox(height: 2),
          Material(
            borderRadius: isme? kmsgdecoreationForME : kmsgdecoreationForOther,
            elevation: 5.0,
            color: isme ? Color(0xFF5E67FF) : Color(0xFFAB48EE),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: padd * 5, vertical: padd * 2),
              child: Text(
                '$text',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: padd * 3.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
