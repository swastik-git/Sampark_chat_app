// import 'dart:io';
import 'dart:io';

// import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sampark/helper/constants.dart';
import 'package:sampark/main.dart';
import 'package:sampark/services/database.dart';
import 'package:sampark/components/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:emoji_picker/emoji_picker.dart';

// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:permission_handler/permission_handler.dart';

// const APP_ID = 'e2740c99dae84f329d89830afb8c895d';
// // f9c7e6ebb51c4cd4aab01fd4ec3c13d7
// const Token =
//     '006e2740c99dae84f329d89830afb8c895dIACxpMaQcX8aBADA4HzQzxq2+0TVY4Ejvs6NmasaHRPY3eTYpQcAAAAAEAAm+nFWn8nZYAEAAQCfydlg';

const kmsgdecoreationForME = BorderRadius.only(
    topLeft: Radius.circular(23),
    topRight: Radius.circular(23),
    bottomLeft: Radius.circular(23));

const kmsgdecoreationForOther = BorderRadius.only(
  topLeft: Radius.circular(23),
  topRight: Radius.circular(23),
  bottomRight: Radius.circular(23),
);

class Chat extends StatefulWidget {
  final String chatRoomId;
  Chat({this.chatRoomId});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool showEmoji = false;
  FocusNode focusNode = new FocusNode();
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();

  // void pickImage({@required ImageSource source}) async{
  // File selectedImage = await Utils.pickImage(source: source);
  // DatabaseMethods().uploadImage(
  //     image: selectedImage,
  //     receiverId: widget.receiver.uid,
  //     senderId: _currentUserId,
  //     imageUploadProvider: _imageUploadProvider);
  // }

  Widget chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Expanded(
                child: ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return MessageTile(
                        // message: snapshot.data.docs[index].data["message"],
                        message: snapshot.data.docs[index].get("message"),
                        // sendByMe: Constants.myName == snapshot.data.docs[index].data["sendBy"],
                        sendByMe: Constants.myName ==
                            snapshot.data.docs[index].get("sendBy"),

                        padding: MediaQuery.of(context).size.aspectRatio,
                        samay: snapshot.data.docs[index].get("samay"),
                      );
                    }),
              )
            : Container();
      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": Constants.myName,
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
        'samay': TimeOfDay.now().format(context).toString().toLowerCase(),
      };

      DatabaseMethods().addMessage(widget.chatRoomId, chatMessageMap);
      print(TimeOfDay.now().format(context));

      setState(() {
        messageEditingController.clear();
      });
    }
  }

  @override
  void initState() {
    DatabaseMethods().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showEmoji = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFDA0037),
        leading: null,
        title: Text(widget.chatRoomId
            .toString()
            .replaceAll("_", "")
            .replaceAll(Constants.myName, "")),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.video_call, size: 25),
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "Not Availiable Now",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP_LEFT,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }),
          // SizedBox(
          //   width: 10,
          // ),
          IconButton(
              icon: Icon(Icons.call, size: 25),
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "Not Availiable Now",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP_LEFT,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }),
              // IconButton(onPressed: (){

              // }, icon: Icon(Icons.brush,size: 25))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          // color: Colors.black26,
          image: DecorationImage(
            image: AssetImage('assets/images/bgWhite.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: WillPopScope(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              chatMessages(),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20,bottom: 6),
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(30)),
                // padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            focusNode.unfocus();
                            focusNode.canRequestFocus = false;
                            showEmoji = !showEmoji;
                          });
                        },
                        icon: const Icon(
                          Icons.emoji_emotions_outlined,
                          color: Color(0xFFDA0037),
                          size: 30,
                        ),
                      ),
                    ),
                    Expanded(
                        child: TextField(
                      focusNode: focusNode,
                      controller: messageEditingController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          hintText: " Type Message..",
                          hintStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                          border: InputBorder.none),
                    )),
                    // SizedBox(width: 16,),
                    // GestureDetector(
                    //   onTap: (){
                    //     // pickImage(source: ImageSource.camera);
                    //   },
                    //   child: Container(
                    //     child: Icon(Icons.camera_alt),
                    //     constraints:
                    //           BoxConstraints(maxWidth: 30, maxHeight: 30),

                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () {
                        addMessage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.send,
                          color: Color(0xFFDA0037),
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              showEmoji ? emojiSelect() : Container(),
            ],
          ),
          onWillPop: () {
            if (showEmoji) {
              setState(() {
                showEmoji = false;
              });
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
        ),
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
      rows: 4,
      columns: 8,
      onEmojiSelected: (emoji, category) {
        setState(() {
          messageEditingController.text += emoji.emoji;
        });
      },
    );
  }
}

// class MessageTile extends StatelessWidget {
//   final String message;
//   final bool sendByMe;

//   MessageTile({@required this.message, @required this.sendByMe});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(
//           top: 8,
//           bottom: 8,
//           left: sendByMe ? 0 : 24,
//           right: sendByMe ? 24 : 0),
//       alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: sendByMe
//             ? EdgeInsets.only(left: 30)
//             : EdgeInsets.only(right: 30),
//         padding: EdgeInsets.only(
//             top: 17, bottom: 17, left: 20, right: 20),
//         decoration: BoxDecoration(
//             borderRadius: sendByMe ? BorderRadius.only(
//                 topLeft: Radius.circular(23),
//                 topRight: Radius.circular(23),
//                 bottomLeft: Radius.circular(23)
//             ) :
//             BorderRadius.only(
//         topLeft: Radius.circular(23),
//           topRight: Radius.circular(23),
//           bottomRight: Radius.circular(23),
//           ),
//             gradient: LinearGradient(
//               colors: sendByMe ? [
//                 const Color(0xff007EF4),
//                 const Color(0xff2A75BC)
//               ]
//                   : [
//                 const Color(0x1AFFFFFF),
//                 const Color(0x1AFFFFFF)
//               ],
//             )
//     ),
//     child: Text(message,
//         textAlign: TextAlign.start,
//         style: TextStyle(
//         color: Colors.white,
//         fontSize: 16,
//         fontFamily: 'OverpassRegular',
//         fontWeight: FontWeight.w300)),
//   ),
// );
//   }
// }

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  final double padding;
  final String samay;

  MessageTile(
      {@required this.message,
      @required this.sendByMe,
      this.padding,
      this.samay});
  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: sendByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
          padding: EdgeInsets.only(
              top: 8,
              bottom: 8,
              left: sendByMe ? 0 : 7,
              right: sendByMe ? 7 : 0),
          child: Container(
            // margin: sendByMe
            // ? EdgeInsets.only(left: 20)
            // : EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
        //       boxShadow:[
        //  //background color of box
        //   BoxShadow(
        //     color: Colors.black,
        //     blurRadius:10.0, // soften the shadow
        //     spreadRadius: 1.0, //extend the shadow
        //     offset: Offset(
        //       2.0, // Move to right 10  horizontally
        //       2.0, // Move to bottom 10 Vertically
        //     ),
        //   )
        // ], 
                borderRadius:
                    sendByMe ? kmsgdecoreationForME : kmsgdecoreationForOther,
                // gradient: LinearGradient(
                //   colors: sendByMe
                //       ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                //       : [const Color(0x1AFFFFFf), const Color(0x1AFFFFffd)],
                // )
                color: sendByMe ? Colors.amber[100] : Colors.blue[50]),
            child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
              child: Text(
                '$message     $samay',
                style: TextStyle(
                  color: sendByMe ? Colors.black : Colors.black,
                  fontSize: 15,
                  // fontFamily: 'OverpassRegular',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
