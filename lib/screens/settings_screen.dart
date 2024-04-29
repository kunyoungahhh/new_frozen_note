import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';
import 'package:new_frozen_note/auth_gate_test.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.power_settings_new_rounded,
          ),
          onPressed: () {
            FirebaseUIAuth.signOut();
            Get.offAll(() => const AuthGate2());
          },
        ),
      ),
      body: Column(
        children: [
          const Center(
            child: Text("Profile Info TODO"),
          ),
          const ListTile(
            title: Text("General"),
            selectedTileColor: Colors.grey,
          ),
          ListTile(
            title: const Text("Personal Info"),
            onTap: () {
              Get.to(const ProfileScreen());
            },
          ),
          ListTile(
            title: const Text("Sign Out"),
            onTap: () {
              FirebaseUIAuth.signOut();
              Get.offAll(() => const AuthGate2());
            },
          )
        ],
      ),
    );
  }
}
