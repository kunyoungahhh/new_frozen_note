import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';
import 'package:new_frozen_note/screens/home_screen.dart';
import 'package:new_frozen_note/screens/search_screen.dart';
import 'package:new_frozen_note/screens/settings_screen.dart';
import 'package:new_frozen_note/screens/stack_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required dynamic userData}) : _user = userData;

  final User _user;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late User _user;
  // late User? user;
  // final _user = widget._user;
  @override
  void initState() {
    _user = widget._user;
    // () async {
    //   user = await Authentication.signInWithGoogle(context: context);
    //   if (user != null) {
    //     _user = user;
    //   }
    // };
  }

  int _selectedIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Icons.home),
    ),
    const BottomNavigationBarItem(
      label: 'Search',
      icon: Icon(Icons.search),
    ),
    const BottomNavigationBarItem(
      label: 'Recommend',
      icon: Icon(Icons.thumbs_up_down),
    ),
    const BottomNavigationBarItem(
      label: 'Friends',
      icon: Icon(Icons.people),
    ),
    const BottomNavigationBarItem(
      label: 'Settings',
      icon: Icon(Icons.settings_outlined),
    ),
  ];
  //TODO

  @override
  Widget build(BuildContext context) {
    List pages = [
      HomeScreen(
        user: _user,
      ),
      const SearchScreen(),
      const StackScreen(),
      const StackScreen(),
      const SettingsScreen(),
    ];
    // print(_user.displayName);
    return Scaffold(
      // appBar: AppBar(
      //   title: GestureDetector(
      //     onTap: () {
      //       Get.to(const TestPage());
      //     },
      //     child: const Text("TEST PAGE TAP"),
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.withOpacity(0.6),
          selectedFontSize: 14,
          unselectedFontSize: 10,
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: bottomItems),
      body: pages[_selectedIndex],
    );
  }
}
