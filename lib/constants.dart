import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

// const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryColor = Color(0xFFfd7014);
const kPrimaryLightColor = Color(0xFFF1E6FF);

const kSendButtonTextStyle = TextStyle(
  color: Color(0xFF5E67FF),
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.black12, width: 2.0),
  ),
);



const kmsgdecoreationForME = BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            );

const kmsgdecoreationForOther = BorderRadius.only(
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            );



class Constants{
  static String myName = "";
}


// const kTextFieldDecoration = InputDecoration(
//   hintText: 'Enter your value', 
//   contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal:10.0),
//   border: OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(30.0)),
//   ),
//   enabledBorder: OutlineInputBorder(
//     borderSide: BorderSide(color: Colors.blueAccent, width: 1.5),
//     borderRadius: BorderRadius.all(Radius.circular(30.0)),
//   ),
//   focusedBorder: OutlineInputBorder(
//     borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
//     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//   ),
// );