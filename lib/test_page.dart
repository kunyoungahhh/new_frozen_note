import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';
import 'package:new_frozen_note/auth_gate_test.dart';
import 'package:new_frozen_note/screens/search_screen.dart';
import 'package:new_frozen_note/screens/settings_screen.dart';

import 'package:mobile_scanner/mobile_scanner.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key, required dynamic userData}) : _user = userData;
  final dynamic _user;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  late dynamic _user;

  @override
  void initState() {
    _user = widget._user;
  }

  var name = "???";

  @override
  Widget build(BuildContext context) {
    print(_user);
    return Scaffold(
      appBar: AppBar(
        title: const Text("TEST PAGE"),
      ),
      body: Center(
          child: Container(
        child: Column(children: [
          const SizedBox(
            height: 100,
          ),
          Text(name),
          ElevatedButton(
            onPressed: () async {
              DocumentSnapshot test1docData =
                  await fireStore.collection("Test").doc('test1doc').get();
              setState(() {
                name = test1docData['name'];
              });
            },
            child: const Text('Fetch Data'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(const MakePostPage());
            },
            child: const Text("Go to Post Page"),
          ),
          ElevatedButton(
            onPressed: () async {
              DocumentSnapshot curUserData = await fireStore
                  .collection("UserData")
                  .doc("v9dIFSD2Y5SY6cL3u475keKVRNj1")
                  .get();
              // print(curUserData.data());
            },
            child: const Text("TEST3 button"),
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseUIAuth.signOut();
              Get.offAll(const AuthGate2());
            },
            child: const Text("SIGN OUT button"),
          ),
        ]),
      )),
    );
  }
}

class MakePostPage extends StatefulWidget {
  const MakePostPage({super.key});

  @override
  State<MakePostPage> createState() => _MakePostPageState();
}

class _MakePostPageState extends State<MakePostPage> {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  TextEditingController myController = TextEditingController();
  TextEditingController myController2 = TextEditingController();
  String postTitle = "";
  String content = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Upload Page"),
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: myController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Posting Title',
              ),
              onChanged: (value) {
                setState(() {
                  postTitle = value;
                });
              },
            ),
            TextField(
              controller: myController2,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Comment',
              ),
              maxLines: 10,
              onChanged: (value) {
                setState(() {
                  content = value;
                });
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Text(postTitle),
            Text(content),
            ElevatedButton(
              onPressed: () {
                fireStore.collection('Posts').doc().set({
                  "postTitle": postTitle,
                  "content": content,
                });
              },
              child: const Text("Upload!"),
            )
          ],
        ),
      ),
    );
  }
}

class TestPage2 extends StatefulWidget {
  const TestPage2({super.key});

  @override
  State<TestPage2> createState() => _TestPage2State();
}

class _TestPage2State extends State<TestPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              const SliverAppBar(
                bottom: TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.settings), text: "Settings"),
                    Tab(icon: Icon(Icons.search), text: "Search"),
                  ],
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              SettingsScreen(),
              SearchScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

class TestScanPage extends StatefulWidget {
  const TestScanPage({super.key});

  @override
  State<TestScanPage> createState() => _TestScanPageState();
}

class _TestScanPageState extends State<TestScanPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
