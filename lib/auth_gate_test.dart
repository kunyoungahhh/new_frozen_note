import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_apple.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'package:new_frozen_note/screens/main_page.dart';

// class AuthGate2 extends StatelessWidget {
//   const AuthGate2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final providers = [EmailAuthProvider()];

//     return MaterialApp(
//       initialRoute:
//           FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/profile',
//       routes: {
//         '/sign-in': (context) {
//           return SignInScreen(
//             providers: providers,
//             actions: [
//               AuthStateChangeAction<SignedIn>((context, state) {
//                 Navigator.pushReplacementNamed(context, '/profile');
//               }),
//             ],
//           );
//         },
//         '/profile': (context) {
//           return ProfileScreen(
//             providers: providers,
//             actions: [
//               SignedOutAction((context) {
//                 Navigator.pushReplacementNamed(context, '/sign-in');
//               }),
//             ],
//           );
//         },
//       },
//     );
//   }
// }
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions().currentPlatform);

//   FirebaseUIAuth.configureProviders([
//     GoogleProvider(clientId: "kunyoungjung"),
//   ]);
// }
class AuthGate2 extends StatelessWidget {
  const AuthGate2({super.key});

  @override
  Widget build(BuildContext context) {
    // final providers = [EmailAuthProvider(), GoogleAuthProvider()];
    // final providers = [
    //   EmailAuthProvider(),
    //   GoogleProvider(clientId: "kunyoungjung"),
    // ];
    FirebaseUIAuth.configureProviders([
      GoogleProvider(
          clientId:
              "170068570586-1lo42eagotr5min48tpfbg25c5ufgq01.apps.googleusercontent.com"),
    ]);
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            showAuthActionSwitch: true,
            providers: [
              // EmailAuthProvider(),
              GoogleProvider(
                  clientId:
                      "170068570586-1lo42eagotr5min48tpfbg25c5ufgq01.apps.googleusercontent.com"),
              // AppleProvider(),
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/images/frozennote.jpeg'),
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('꽁꽁노트 로그인')
                    : const Text('꽁꽁노트 회원가입'),
              );
            },
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  '꽁꽁 얼어붙은 한강 위로 고양이가 지나갑니다 \n\nMaintained by @kj_josh',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
            sideBuilder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/images/frozennote.jpeg'),
                ),
              );
            },
          );
        }

        // else {
        // print(snapshot.data);
        // final auth =
        //     FirebaseAuth.instance.setPersistence(Persistence.SESSION);
        // print(auth.currentUser?.displayName);
        // Toast.show("Signed In as: ${snapshot.data}",
        //     duration: Toast.lengthShort, gravity: Toast.top);
        // Toastification()
        //     .show(context: context, title: "Signed In as: ${snapshot.data}");
        // }
        // return WarehouseApp();
        // FirebaseAuth.instance.setPersistence(Persistence.SESSION);
        // print(snapshot.data);
        // print("HELLLOOOWEKOFKOASDKFOASDFK");
        // FirebaseUIAuth.signOut();
        // return TestPage(
        //   userData: snapshot.data,
        // );
        return snapshot.hasData
            ? MainPage(
                userData: snapshot.data,
              )
            : const AuthGate2();
        // return const UpdateScreen(
        //     sku: "Assembly-Chain-N-19-G",
        //     quantity: 123,
        //     lastUpdatedBy: "lastUpdatedBy",
        //     lastUpdatedOn: "lastUpdatedOn");
      },
    );
  }
}
