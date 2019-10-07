import 'dart:io';

import 'package:flutter/material.dart';
import 'package:twitter/home/home_view.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/search_view/search_view.dart';
import 'package:twitter/user_profile/user_profile_view.dart';

class MainView extends StatefulWidget {
  MainView({Key key}) : super(key: key);

  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;

  static User currentUser = User(
      "John Doe",
      "@johndoe",
      "jd@jd.com",
      File(
          "/Users/palmacoe/byu/cs340/cs340-project/pm2/twitter/lib/assets/placeholder.png"),
      [],
      []);

  final List<Widget> _views = [
    HomeView(),
    UserProfileView(
      user: currentUser,
    ),
    SearchView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavBar(),
      body: _views[currentIndex],
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      onTap: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.blue[50],
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          title: Container(height: 0.0),
          icon: Icon(
            Icons.home,
            size: 30,
          ),
        ),
        // BottomNavigationBarItem(
        //   title: Container(height: 0.0),
        //   icon: Icon(
        //     Icons.search,
        //     size: 30,
        //   ),
        // ),
        BottomNavigationBarItem(
          title: Container(height: 0.0),
          icon: Icon(
            Icons.person,
            size: 30,
          ),
        ),
        BottomNavigationBarItem(
          title: Container(height: 0.0),
          icon: Icon(
            Icons.settings,
            size: 30,
          ),
        ),
      ],
    );
  }
}
