// import 'package:sampark/constants.dart';
import 'package:sampark/helper/authenticate.dart';
import 'package:sampark/helper/constants.dart';
import 'package:sampark/helper/helperfunctions.dart';
import 'package:sampark/helper/theme.dart';
import 'package:sampark/services/auth.dart';
import 'package:sampark/services/database.dart';
import 'package:sampark/screens/chat.dart';
import 'package:sampark/screens/search.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream chatRooms;

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    // userName: snapshot.data.docs[index].data['chatRoomId']
                    userName: snapshot.data.docs[index].get('chatRoomId')
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(Constants.myName, ""),
                    // chatRoomId: snapshot.data.docs[index].data["chatRoomId"],
                    chatRoomId: snapshot.data.docs[index].get('chatRoomId'),

                  );
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Sampark"),
        elevation: 0.0,
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () async{
              HelperFunctions.removeUserEmailsharedPreference();
              HelperFunctions.removeUserLoggedInSharedPreference();
              HelperFunctions.removeUserNameSharedPreference();
              AuthService().signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
                // padding: EdgeInsets.symmetric(horizontal: 16),
                margin: EdgeInsets.only(top: 15,right: 5),
                child: Text("Sign Out " ,style: TextStyle(fontSize: 16,),),)
          )
        ],
      ),
      body: Container(
        child: chatRoomsList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search,size: 30,),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search()));
        },
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName,@required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Chat(
            chatRoomId: chatRoomId,
          )
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Colors.white70,
            width:0.2 ,
          ),
          shape: BoxShape.rectangle,
        ),
        
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Color(0xFF0C3C78),
                  borderRadius: BorderRadius.circular(30)),
              child: Center(
                child: Text(userName.substring(0, 1).toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'OverpassRegular',
                        fontWeight: FontWeight.w300)),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Text(userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w300))
          ],
        ),
      ),
    );
  }
}
