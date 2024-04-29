// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:frozen_notes/auth_page.dart';
// import 'package:frozen_notes/screens/main_page.dart';
// import 'package:frozen_notes/utils/authentication.dart';

// class CustomColors {
//   static const Color firebaseNavy = Color(0xFF2C384A);
//   static const Color firebaseOrange = Color(0xFFF57C00);
//   static const Color firebaseAmber = Color(0xFFFFA000);
//   static const Color firebaseYellow = Color(0xFFFFCA28);
//   static const Color firebaseGrey = Color(0xFFECEFF1);
//   static const Color googleBackground = Color(0xFF4285F4);
// }

// class GoogleSignInButton extends StatefulWidget {
//   const GoogleSignInButton({super.key});

//   @override
//   _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
// }

// class _GoogleSignInButtonState extends State<GoogleSignInButton> {
//   bool _isSigningIn = false;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: _isSigningIn
//           ? const CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//             )
//           : OutlinedButton(
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.white),
//                 shape: MaterialStateProperty.all(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(40),
//                   ),
//                 ),
//               ),
//               onPressed: () async {
//                 setState(() {
//                   _isSigningIn = true;
//                 });
//                 User? user =
//                     await Authentication.signInWithGoogle(context: context);

//                 setState(() {
//                   _isSigningIn = false;
//                 });

//                 if (user != null) {
//                   Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(
//                       builder: (context) => MainPage(
//                         user: user,
//                       ),
//                     ),
//                   );
//                 }
//               },
//               child: const Padding(
//                 padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Image(
//                       image: AssetImage("assets/google_logo.png"),
//                       height: 35.0,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: 10),
//                       child: Text(
//                         'Sign in with Google',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.black54,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }

// class AppBarTitle extends StatelessWidget {
//   const AppBarTitle({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Image.asset(
//           'assets/images/frozennote.jpeg',
//           height: 20,
//         ),
//         const SizedBox(width: 8),
//         const Text(
//           '꽁꽁노트',
//           style: TextStyle(
//             color: CustomColors.firebaseYellow,
//             fontSize: 18,
//           ),
//         ),
//         const Text(
//           ' by @kunyoungahhh',
//           style: TextStyle(
//             color: CustomColors.firebaseOrange,
//             fontSize: 18,
//           ),
//         ),
//       ],
//     );
//   }
// }
