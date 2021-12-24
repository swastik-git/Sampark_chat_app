// import 'login_screen.dart';
// import 'registration_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:sampark/paddingbtn.dart';

// class WelcomeScreen extends StatefulWidget {
//   static String id = 'welcome_screen';
//   @override
//   _WelcomeScreenState createState() => _WelcomeScreenState();
// }

// class _WelcomeScreenState extends State<WelcomeScreen>
//     with SingleTickerProviderStateMixin {
//   AnimationController controller;
//   Animation animation;

//   @override
//   @override
//   void initState() {
//     super.initState();
//     controller =
//         AnimationController(duration: Duration(seconds: 2), vsync: this);
//     // animation = ColorTween(begin: Color(0xFF3B3561), end: Color(0xFF40479E))
//     //     .animate(controller);
//     controller.forward();

//     controller.addListener(() {
//       setState(() {});
//       // print(animation.value);
//     });
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.red,
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 Hero(
//                   tag: 'logo',
//                   child: Container(
//                     child: Image.asset('images/logo.png'),
//                     height: 80 * (controller.value),
//                   ),
//                 ),
//                 Expanded(
//                   child: DefaultTextStyle(
//                     child: AnimatedTextKit(
//                       isRepeatingAnimation: true,
//                       animatedTexts: [WavyAnimatedText('Sampark')],
//                     ),
//                     style: TextStyle(
//                         fontSize: 40.0,
//                         fontWeight: FontWeight.w900,
//                         color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 48.0,
//             ),
//             PaddingButton(
//               txt: 'Login',
//               color: Colors.blueGrey[200],
//               ontap: () {
//                 Navigator.pushNamed(context, LoginScreen.id);
//               },
//             ),
//             PaddingButton(
//               txt: 'Register',
//               color: Colors.blueGrey[500],
//               ontap: () {
//                 Navigator.pushNamed(context, RegistrationScreen.id);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

