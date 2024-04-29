import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';
import 'package:new_frozen_note/auth_gate_test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      // home: LandingPage(),
      home: AuthGate2(),
      // home: (),
    );
  }
}
