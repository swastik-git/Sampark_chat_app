// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:sampark/constants.dart';

// // screens
// import 'package:sampark/screens/chatRoom/chatrooms.dart';
// import 'package:sampark/screens/GroupChat.dart';
// import 'package:sampark/Screens/Login/components/background.dart';
// import 'package:sampark/Screens/Signup/signup_screen.dart';

// // components
// import 'package:sampark/components/already_have_an_account_acheck.dart';
// import 'package:sampark/components/rounded_button.dart';
// import 'package:sampark/components/rounded_input_field.dart';
// import 'package:sampark/components/rounded_password_field.dart';

// // firebase
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// // services
// import 'package:sampark/services/auth.dart';
// import 'package:sampark/services/database.dart';


// // helper
// import 'package:sampark/helper/authenticate.dart';
// import 'package:sampark/helper/helperfunctions.dart';


// class Body extends StatefulWidget {
//    final Function toggleView;

//   Body(this.toggleView);
//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//  TextEditingController emailEditingController = new TextEditingController();
//   TextEditingController passwordEditingController = new TextEditingController();

//   AuthService authService = new AuthService();

//   final formKey = GlobalKey<FormState>();

//   bool isLoading = false;

//   signIn() async {
//     if (formKey.currentState.validate()) {
//       setState(() {
//         isLoading = true;
//       });

//       await authService
//           .signInWithEmailAndPassword(
//               emailEditingController.text, passwordEditingController.text)
//           .then((result) async {
//         if (result != null) {
//           QuerySnapshot userInfoSnapshot =
//               await DatabaseMethods().getUserInfo(emailEditingController.text);

//           HelperFunctions.saveUserLoggedInSharedPreference(true);
//           HelperFunctions.saveUserNameSharedPreference(
//               userInfoSnapshot.docs[0].get('userName'));
//           HelperFunctions.saveUserEmailSharedPreference(
//               userInfoSnapshot.docs[0].get('userEmail'));

//           Navigator.pushReplacement(
//               context, MaterialPageRoute(builder: (context) => ChatRoom()));
//         } else {
//           setState(() {
//             isLoading = false;
//             //show snackbar
//           });
//         }
//       });
//     }
//   }

//   IconData iconeye = Icons.visibility;
//   bool eye = true;
//   bool spinner = false;
//   String email;
//   String password;
//   // final _auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Color(0xFFE0CCEC),
//       body: isLoading
//           ? SpinKitThreeBounce(color: Colors.blue,size: 80,)
//           : Background(
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       "SIGN IN",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black54,
//                           fontSize: 20,
//                           letterSpacing: 3),
//                     ),
//                     SizedBox(height: size.height * 0.03),
//                     SvgPicture.asset(
//                       "assets/icons/login.svg",
//                       height: size.height * 0.35,
//                     ),
//                     SizedBox(height: size.height * 0.03),
//                     Form(
//                       key: formKey,
//                       child: Column(
//                         children: [
//                           RoundedInputField(
//                             cont: emailEditingController,
//                             validator: (val) {
//                               return RegExp(
//                                           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                                       .hasMatch(val)
//                                   ? null
//                                   : "Please Provide a valid email ";
//                             },
//                             hintText: "Your Email",
//                             type: TextInputType.emailAddress,
//                             // onChanged: (value) {
//                             //   email = value;
//                             // },
//                           ),
//                           RoundedPasswordField(
//                             cont: passwordEditingController,
//                             validator: (val) {
//                               return val.length < 6
//                                   ? "Password Must 6 + Characters"
//                                   : null;
//                             },
//                             eye: eye,
//                             icon: iconeye,
//                             // onChanged: (value) {
//                             //   password = value;
//                             // },
//                             ontapicon: () {
//                               setState(() {
//                                 if (eye) {
//                                   eye = false;
//                                   iconeye = Icons.visibility_off;
//                                 } else {
//                                   eye = true;
//                                   iconeye = Icons.visibility;
//                                 }
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     RoundedButton(
//                       text: "SIGN IN",
//                       color: Color(0xFFAB48EE),
//                       press: ()  {
//                         signIn();
//                       },
//                     ),
//                     SizedBox(height: size.height * 0.03),
//                     AlreadyHaveAnAccountCheck(
//                       color: Color(0xFFAB48EE),
//                       press: () {
//                           widget.toggleView();
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //     builder: (context) {
//                         //       return SignUpScreen();
//                         //     },
//                         //   ),
//                         // );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
