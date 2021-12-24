import 'package:flutter/material.dart';
import 'package:sampark/screens/Signup/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../constants.dart';
import 'package:flutter_svg/svg.dart';

// components
import 'package:sampark/components/already_have_an_account_acheck.dart';
import 'package:sampark/components/rounded_button.dart';
import 'package:sampark/components/rounded_input_field.dart';
import 'package:sampark/components/rounded_password_field.dart';
import 'package:sampark/components/text_field_container.dart';

// Screen
import 'package:sampark/screens/Login/login_screen.dart';
import 'package:sampark/screens/chatRoom/chatRooms.dart';
import 'package:sampark/screens/GroupChat.dart';
import 'package:sampark/Screens/Login/login_screen.dart';

// Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

// helper
import 'package:sampark/helper/authenticate.dart';
import 'package:sampark/helper/helperfunctions.dart';

// services
import 'package:sampark/services/auth.dart';
import 'package:sampark/services/database.dart';

// class SignUpScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BodySignup(),
//     );
//   }
// }

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp(this.toggleView);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  TextEditingController usernameEditingController = new TextEditingController();

  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  singUp() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signUpWithEmailAndPassword(
              emailEditingController.text, passwordEditingController.text)
          .then((result) {
        if (result != null) {
          Map<String, String> userDataMap = {
            "userName": usernameEditingController.text,
            "userEmail": emailEditingController.text
          };

          databaseMethods.addUserInfo(userDataMap);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              usernameEditingController.text);
          HelperFunctions.saveUserEmailSharedPreference(
              emailEditingController.text);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        }
      });
    }
  }

  IconData iconeye = Icons.visibility;
  bool eye = true;
  bool spinner = false;
  final _auth = FirebaseAuth.instance;
  String password;
  String email;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoading
        ? SpinKitThreeBounce(
            color: Color(0xFFfd7014),
            size: 80,
          )
        : Scaffold(
            backgroundColor: Color(0xff171717),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "SIGN UP",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                          letterSpacing: 1,
                          fontSize: 20),
                    ),
                    // SizedBox(height: size.height * 0.03),
                    SvgPicture.asset(
                      "assets/icons/signupGirl.svg",
                      height: size.height * 0.45,
                    ),
            
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          RoundedInputField(
                            validator: (val) {
                              return val.isEmpty || val.length < 4
                                  ? "Please Provide a valid username "
                                  : null;
                            },
                            cont: usernameEditingController,
                            hintText: "User Name",
                            onChanged: (value) {},
                          ),
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
                            icon: Icons.email,
                            type: TextInputType.emailAddress,
                            onChanged: (value) {
                              email = value;
                            },
                          ),
                          RoundedPasswordField(
                            validator: (val) {
                              return val.length < 6
                                  ? "Password Must 6 + Characters"
                                  : null;
                            },
                            cont: passwordEditingController,
                            eye: eye,
                            icon: iconeye,
                            onChanged: (value) {
                              password = value;
                            },
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
                    )
                    // TextFieldContainer(
                    //   child: TextField(
                    //     obscureText: eye,
                    //     onChanged: (value) {
                    //       password = value;
                    //     },
                    //     cursorColor: kPrimaryColor,
                    //     decoration: InputDecoration(
                    //       hintText: "Password",
                    //       icon: Icon(
                    //         Icons.lock,
                    //         color: kPrimaryColor,
                    //       ),
                    //       suffixIcon: MaterialButton(
                    //         onPressed: (){
                    //           setState(() {
                    //             if(eye){
                    //               eye = false
                    //             }
                    //             else{
                    //               eye =
                    //             }
                    //           });
                    //         },
                    //         child: Icon(
                    //           Icons.visibility,
                    //           color: kPrimaryColor,
                    //         ),
                    //       ),
                    //       border: InputBorder.none,
                    //     ),
                    //   ),
                    // ),
                    ,
                    RoundedButton(
                      text: "SIGN UP",
                      color:kPrimaryColor,
                      press: () {
                        singUp();
                        // if(emailcontroller.value != null && usernamecontroller.value != null && passwordcontroller.value != null  )
                        // {
            
                        // }
                        // setState(() {
                        //   spinner = true;
                        // });
            
                        // try {
                        //   final newUser = await _auth.createUserWithEmailAndPassword(
                        //       email: email, password: password);
                        //   if (newUser != null) {
                        //     Navigator.pushNamed(context, ChatScreen.id);
                        //     setState(() {
                        //       spinner = false;
                        //     });
                        //   }
                        // } catch (e) {
                        //   print(e);
                        // }
                      },
                    ),
                    SizedBox(height: size.height * 0.01),
                    AlreadyHaveAnAccountCheck(
                      login: false,
                      color: kPrimaryColor,
                      press: () {
                        widget.toggleView();
                        // Navigator.pushNamed(
                        //     context, loginScreen.LoginScreen.id);
                      },
                    ),
                    
                  ],
                ),
              ),
            ),
          );
  }
}
