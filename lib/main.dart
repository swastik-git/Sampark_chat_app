import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sampark/constants.dart';
import 'package:sampark/helper/authenticate.dart';
import 'package:sampark/helper/helperfunctions.dart';
import 'package:sampark/screens/afterSplash.dart';
import 'package:sampark/screens/chatRoom/chatrooms.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Sampark());
}

class Sampark extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _SamparkState createState() => _SamparkState();
}

class _SamparkState extends State<Sampark> {
// final Shader linearGradient = LinearGradient(
//       colors: <Color>[Colors.redAccent , Colors.redAccent],
//     ).createShader(Rect.fromLTWH(150.0, 70.0, 70.00, 200.0));

  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

// Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  bool userIsLoggedIn;

  @override
  void initState() {
    initializeFlutterFire();
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
    return Container(
      // color
      // child:SpinKitThreeBounce(
      //   color: Colors.blue,
      //   size: 80,
      // ),
    );
    }
    return 
    MaterialApp(
            title: 'Sampark',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // primaryColor: Color(0xFFDA0037),
              primaryColor: kPrimaryColor,
              // scaffoldBackgroundColor: Color(0xff1F1F1F),
              // scaffoldBackgroundColor: Color(0xff1F1F1F),
              accentColor:kPrimaryColor,
              fontFamily: "OverpassRegular",
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: userIsLoggedIn != null
                ? userIsLoggedIn
                    ? ChatRoom()
                    : Authenticate()
                : Container(
                    child: Center(
                      child: Authenticate(),
                    ),
                  ),
          );

    // _error
    //     ? Scaffold(
    //         appBar: AppBar(
    //           title: Text("Sampark"),
    //         ),
    //         body: Expanded(
    //             child: Container(
    //           child: Text(
    //               "Initialization Failed Start Your App Again And Check Your Internert Connection"),
    //         )),
    //       )
    // :
  }
}
