import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sampark/Screens/Login/components/body.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sampark/constants.dart';
import 'package:sampark/screens/Login/components/or_divider.dart';
import 'package:sampark/screens/Login/components/social_icon.dart';

// screens
import 'package:sampark/screens/chatRoom/chatrooms.dart';
import 'package:sampark/screens/GroupChat.dart';
import 'package:sampark/Screens/Signup/signup_screen.dart';

// components
import 'package:sampark/components/already_have_an_account_acheck.dart';
import 'package:sampark/components/rounded_button.dart';
import 'package:sampark/components/rounded_input_field.dart';
import 'package:sampark/components/rounded_password_field.dart';

// firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// services
import 'package:sampark/services/auth.dart';
import 'package:sampark/services/database.dart';

// helper
import 'package:sampark/helper/authenticate.dart';
import 'package:sampark/helper/helperfunctions.dart';

// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Body(),
//     );
//   }
// }

class SignIn extends StatefulWidget {
  // static String id = 'signIn_screen';
  final Function toggleView;
  SignIn(this.toggleView);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();

  AuthService authService = new AuthService();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  signIn() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signInWithEmailAndPassword(
              emailEditingController.text, passwordEditingController.text)
          .then((result) async {
        if (result != null) {
          QuerySnapshot userInfoSnapshot =
              await DatabaseMethods().getUserInfo(emailEditingController.text);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSna
              1w
              16e
              6i6w1.w
              6pshot.docs[0].get('userName'));
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.docs[0].get('userEmail'));

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        } else {
          setState(() {
            isLoading = false;
            //show snackbar
          });
        }
      });
    }
  }

  IconData iconeye = Icons.visibility;
  bool eye = true;
  bool spinner = false;
  String email;
  String password;
  // final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff171717),
      body: isLoading
          ? SpinKitThreeBounce(
              color: Color(0xFFfd7014),
              size: 80,
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "SIGN IN",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                          fontSize: 20,
                          letterSpacing: 3),
                    ),
                    SizedBox(height: size.height * 0.03),
                    SvgPicture.asset(
                      "assets/icons/Loginpana.svg",
                      height: size.height * 0.40,
                    ),
                    SizedBox(height: size.height * 0.02),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          RoundedInputField(
                            cont: emailEditingController,
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)
                                  ? null
                                  : "Please Provide a valid email ";
                            },
                            hintText: "Your Email",
                            type: TextInputType.emailAddress,
                            // onChanged: (value) {
                            //   email = value;
                            // },
                          ),
                          RoundedPasswordField(
                            cont: passwordEditingController,
                            validator: (val) {
                              return val.length < 6
                                  ? "Password Must 6 + Characters"
                                  : null;
                            },
                            eye: eye,
                            icon: iconeye,
                            // onChanged: (value) {
                            //   password = value;
                            // },
                            ontapicon: () {
                              setState(() {
                                if (eye) {
                                  eye = false;
                                  iconeye = Icons.visibility_off;
                                } else {
                                  eye = true;
                                  iconeye = Icons.visibility;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    RoundedButton(
                      text: "SIGN IN",
                      color: kPrimaryColor,
                      press: () {
                        signIn();
                      },
                    ),
                    SizedBox(height: size.height * 0.015),
                    AlreadyHaveAnAccountCheck(
                      color: kPrimaryColor,
                      press: () {
                        widget.toggleView();
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return SignUpScreen();
                        //     },
                        //   ),
                        // );
                      },
                    ),
                    OrDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SocalIcon(
                          iconSrc: "assets/icons/google.svg",
                          press: () {
                            Fluttertoast.showToast(
                                msg: "Not Availiable Now",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            ;
                          },
                        ),
                        SocalIcon(
                          iconSrc: "assets/icons/facebook.svg",
                          press: () {
                            Fluttertoast.showToast(
                                msg: "Not Availiable Now",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            ;
                          },
                        ),
                        SocalIcon(
                          iconSrc: "assets/icons/twitter.svg",
                          press: () {
                            Fluttertoast.showToast(
                                msg: "Not Availiable Now",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            ;
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
