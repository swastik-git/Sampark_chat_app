// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import '../../../constants.dart';
// import 'package:flutter_svg/svg.dart';

// // components
// import 'package:sampark/components/already_have_an_account_acheck.dart';
// import 'package:sampark/components/rounded_button.dart';
// import 'package:sampark/components/rounded_input_field.dart';
// import 'package:sampark/components/rounded_password_field.dart';
// import 'package:sampark/components/text_field_container.dart';

// // Screen
// import 'package:sampark/screens/Login/login_screen.dart';
// import 'package:sampark/screens/chatRoom/chatRooms.dart';
// import 'package:sampark/screens/GroupChat.dart';
// import 'package:sampark/Screens/Login/login_screen.dart';
// import 'package:sampark/Screens/Signup/components/background.dart';
// import 'package:sampark/Screens/Signup/components/or_divider.dart';
// import 'package:sampark/Screens/Signup/components/social_icon.dart';

// // Firebase
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

// // helper
// import 'package:sampark/helper/authenticate.dart';
// import 'package:sampark/helper/helperfunctions.dart';




// // services


// class Body extends StatefulWidget {
//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   bool isLoading = false;
//   AuthMethods authMethods = new AuthMethods();
//   DatabaseMethods dbm = new DatabaseMethods();
//   // HelperFunctions helperFunction = new HelperFunctions();

  

//   final _formKey = GlobalKey<FormState>();
//   TextEditingController usernamecontroller = new TextEditingController();
//   TextEditingController emailcontroller = new TextEditingController();
//   TextEditingController passwordcontroller = new TextEditingController();

//   signMeUp() {
//     if (_formKey.currentState.validate()) {
//       Map<String, String> userInfoMap = {
//         "name": usernamecontroller.text,
//         "email": emailcontroller.text,
//       };
//       HelperFunctions.saveUserNameSharedPrefrence(usernamecontroller.text);
//       HelperFunctions.saveUserEmailSharedPrefrence(emailcontroller.text);

//       setState(() {
//         isLoading = true;
//       });

//       authMethods
//           .signUpWithEmailAndPassword(
//               emailcontroller.text, passwordcontroller.text)
//           .then((value) {
//         // print("${value.uid}");

//         HelperFunctions.saveUserLoggedInsharedPrefrence(true);

//         dbm.uploadUserInfo(userInfoMap);
//         HelperFunctions.saveUserLoggedInsharedPrefrence(true);
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ChatRoom(),
//           ),
//         );
//       });
//     }
//   }

//   IconData iconeye = Icons.visibility;
//   bool eye = true;
//   bool spinner = false;
//   final _auth = FirebaseAuth.instance;
//   String password;
//   String email;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return isLoading
//         ? SpinKitThreeBounce(color: Colors.blue,size: 80,)
//         : Scaffold(
//             backgroundColor: Color(0xFFBCB8F7),
//             body: Background(
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       "SIGN UP",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black54,
//                           letterSpacing: 1,
//                           fontSize: 20),
//                     ),
//                     // SizedBox(height: size.height * 0.03),
//                     SvgPicture.asset(
//                       "assets/icons/signup.svg",
//                       height: size.height * 0.41,
//                     ),

//                     Form(
//                       key: _formKey,
//                       child: Column(
//                         children: [
//                           RoundedInputField(
//                             validator: (val) {
//                               return val.isEmpty || val.length < 4
//                                   ? "Please Provide a valid username "
//                                   : null;
//                             },
//                             cont: usernamecontroller,
//                             hintText: "User Name",
//                             onChanged: (value) {},
//                           ),
//                           RoundedInputField(
//                             cont: emailcontroller,
//                             validator: (val) {
//                               return RegExp(
//                                           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                                       .hasMatch(val)
//                                   ? null
//                                   : "Please Provide a valid email ";
//                             },
//                             hintText: "Your Email",
//                             icon: Icons.email,
//                             type: TextInputType.emailAddress,
//                             onChanged: (value) {
//                               email = value;
//                             },
//                           ),
//                           RoundedPasswordField(
//                             validator: (val) {
//                               return val.length < 6
//                                   ? "Password Must 6 + Characters"
//                                   : null;
//                             },
//                             cont: passwordcontroller,
//                             eye: eye,
//                             icon: iconeye,
//                             onChanged: (value) {
//                               password = value;
//                             },
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
//                     )
//                     // TextFieldContainer(
//                     //   child: TextField(
//                     //     obscureText: eye,
//                     //     onChanged: (value) {
//                     //       password = value;
//                     //     },
//                     //     cursorColor: kPrimaryColor,
//                     //     decoration: InputDecoration(
//                     //       hintText: "Password",
//                     //       icon: Icon(
//                     //         Icons.lock,
//                     //         color: kPrimaryColor,
//                     //       ),
//                     //       suffixIcon: MaterialButton(
//                     //         onPressed: (){
//                     //           setState(() {
//                     //             if(eye){
//                     //               eye = false
//                     //             }
//                     //             else{
//                     //               eye =
//                     //             }
//                     //           });
//                     //         },
//                     //         child: Icon(
//                     //           Icons.visibility,
//                     //           color: kPrimaryColor,
//                     //         ),
//                     //       ),
//                     //       border: InputBorder.none,
//                     //     ),
//                     //   ),
//                     // ),
//                     ,
//                     RoundedButton(
//                       text: "SIGN UP",
//                       color: Color(0xFF695EFF),
//                       press: () {
//                         signMeUp();
//                         // if(emailcontroller.value != null && usernamecontroller.value != null && passwordcontroller.value != null  )
//                         // {

//                         // }
//                         // setState(() {
//                         //   spinner = true;
//                         // });

//                         // try {
//                         //   final newUser = await _auth.createUserWithEmailAndPassword(
//                         //       email: email, password: password);
//                         //   if (newUser != null) {
//                         //     Navigator.pushNamed(context, ChatScreen.id);
//                         //     setState(() {
//                         //       spinner = false;
//                         //     });
//                         //   }
//                         // } catch (e) {
//                         //   print(e);
//                         // }
//                       },
//                     ),
//                     SizedBox(height: size.height * 0.03),
//                     AlreadyHaveAnAccountCheck(
//                       login: false,
//                       color: Color(0xFF695EFF),
//                       press: () {
//                         Navigator.pushNamed(
//                             context, loginScreen.LoginScreen.id);
//                       },
//                     ),
//                     // OrDivider(),
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.center,
//                     //   children: <Widget>[
//                     //     SocalIcon(
//                     //       iconSrc: "assets/icons/facebook.svg",
//                     //       press: () {},
//                     //     ),
//                     //     SocalIcon(
//                     //       iconSrc: "assets/icons/twitter.svg",
//                     //       press: () {},
//                     //     ),
//                     //     SocalIcon(
//                     //       iconSrc: "assets/icons/google-plus.svg",
//                     //       press: () {},
//                     //     ),
//                     //   ],
//                     // )
//                   ],
//                 ),
//               ),
//             ),
//           );
//   }
// }
