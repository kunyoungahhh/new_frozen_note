// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:frozen_notes/auth_page.dart';
// import 'package:frozen_notes/screens/main_page.dart';
// import 'package:get/instance_manager.dart';
// import 'package:get/route_manager.dart';

// class LandingPage extends StatefulWidget {
//   const LandingPage({super.key});

//   @override
//   State<LandingPage> createState() => _LandingPageState();
// }

// class _LandingPageState extends State<LandingPage> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     Timer(const Duration(seconds: 2), () {
//       Get.offAll(const SignInScreen());
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(alignment: Alignment.center, children: [
//         Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           color: Colors.blue.shade100,
//           child: Center(
//             // child: Text("꽁꽁노트"),
//             child: Image.asset(
//               'assets/images/frozennote.jpeg',
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         const CircularProgressIndicator(),
//       ]),
//     );
//   }
// }
