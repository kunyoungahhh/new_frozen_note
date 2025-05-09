// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:frozen_notes/constants.dart';
// import 'package:frozen_notes/screens/home_screen.dart';
// import 'package:frozen_notes/utils/authentication.dart';

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});

//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(
//             left: 16.0,
//             right: 16.0,
//             bottom: 20.0,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               const Row(),
//               Expanded(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Flexible(
//                       flex: 0,
//                       child: Image.asset(
//                         'assets/images/frozennote.jpeg',
//                         height: 400,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     // const Text(
//                     //   '꽁꽁 얼어붙은 노트 위로 고양이가 걸어갑니다.',
//                     //   style: TextStyle(
//                     //     color: Colors.lightBlue,
//                     //     fontSize: 40,
//                     //   ),
//                     // ),
//                     // const Text(
//                     //   '꽁꽁노트',
//                     //   style: TextStyle(
//                     //     color: Colors.blue,
//                     //     fontSize: 40,
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//               FutureBuilder(
//                 future: Authentication.initializeFirebase(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) {
//                     return const Text('Error initializing Firebase');
//                   } else if (snapshot.connectionState == ConnectionState.done) {
//                     return const Column(
//                       children: [
//                         GoogleSignInButton(),
//                       ],
//                     );
//                   }
//                   return const CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(
//                       Colors.blue,
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class UserInfoScreen extends StatefulWidget {
//   const UserInfoScreen({Key? key, required User user})
//       : _user = user,
//         super(key: key);

//   final User _user;

//   @override
//   _UserInfoScreenState createState() => _UserInfoScreenState();
// }

// class _UserInfoScreenState extends State<UserInfoScreen> {
//   late User _user;
//   bool _isSigningOut = false;

//   Route _routeToSignInScreen() {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) =>
//           const SignInScreen(),
//       // const HomeScreen(),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         var begin = const Offset(-1.0, 0.0);
//         var end = Offset.zero;
//         var curve = Curves.ease;

//         var tween =
//             Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//         return SlideTransition(
//           position: animation.drive(tween),
//           child: child,
//         );
//       },
//     );
//   }

//   @override
//   void initState() {
//     _user = widget._user;

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: CustomColors.firebaseNavy,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: CustomColors.firebaseNavy,
//         title: const AppBarTitle(),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(
//             left: 16.0,
//             right: 16.0,
//             bottom: 20.0,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Row(),
//               _user.photoURL != null
//                   ? ClipOval(
//                       child: Material(
//                         color: CustomColors.firebaseGrey.withOpacity(0.3),
//                         child: Image.network(
//                           _user.photoURL!,
//                           fit: BoxFit.fitHeight,
//                         ),
//                       ),
//                     )
//                   : ClipOval(
//                       child: Material(
//                         color: CustomColors.firebaseGrey.withOpacity(0.3),
//                         child: const Padding(
//                           padding: EdgeInsets.all(16.0),
//                           child: Icon(
//                             Icons.person,
//                             size: 60,
//                             color: CustomColors.firebaseGrey,
//                           ),
//                         ),
//                       ),
//                     ),
//               const SizedBox(height: 16.0),
//               const Text(
//                 'Hello',
//                 style: TextStyle(
//                   color: CustomColors.firebaseGrey,
//                   fontSize: 26,
//                 ),
//               ),
//               const SizedBox(height: 8.0),
//               Text(
//                 _user.displayName!,
//                 style: const TextStyle(
//                   color: CustomColors.firebaseYellow,
//                   fontSize: 26,
//                 ),
//               ),
//               const SizedBox(height: 8.0),
//               Text(
//                 '( ${_user.email!} )',
//                 style: const TextStyle(
//                   color: CustomColors.firebaseOrange,
//                   fontSize: 20,
//                   letterSpacing: 0.5,
//                 ),
//               ),
//               const SizedBox(height: 24.0),
//               Text(
//                 'You are now signed in using your Google account. To sign out of your account click the "Sign Out" button below.',
//                 style: TextStyle(
//                     color: CustomColors.firebaseGrey.withOpacity(0.8),
//                     fontSize: 14,
//                     letterSpacing: 0.2),
//               ),
//               const SizedBox(height: 16.0),
//               _isSigningOut
//                   ? const CircularProgressIndicator(
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                     )
//                   : ElevatedButton(
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(
//                           Colors.redAccent,
//                         ),
//                         shape: MaterialStateProperty.all(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       onPressed: () async {
//                         setState(() {
//                           _isSigningOut = true;
//                         });
//                         await Authentication.signOut(context: context);
//                         setState(() {
//                           _isSigningOut = false;
//                         });
//                         Navigator.of(context)
//                             .pushReplacement(_routeToSignInScreen());
//                       },
//                       child: const Padding(
//                         padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
//                         child: Text(
//                           'Sign Out',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             letterSpacing: 2,
//                           ),
//                         ),
//                       ),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
