import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/screens/user-screens/user_home.dart';
import 'package:gympact/screens/user-screens/user_notification.dart';
import 'package:gympact/screens/user-screens/user_profile.dart';
import 'package:gympact/screens/user-screens/user_progress.dart';

class UserBottomBarNav extends StatefulWidget {
  static String userMainScreenRoute = '/user-screens';
  const UserBottomBarNav({super.key});

  @override
  State<UserBottomBarNav> createState() => _UserBottomBarNavState();
}

class _UserBottomBarNavState extends State<UserBottomBarNav> {
  var _currentIndex = 0;

  var navList = const [
    UserHome(),
    UserProgress(),
    UserNotification(),
    UserProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      bottomNavigationBar: SnakeNavigationBar.color(
          behaviour: SnakeBarBehaviour.floating,
          snakeShape: SnakeShape.circle,
          snakeViewColor: Pallete.primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          // padding: const EdgeInsets.all(12),
          selectedItemColor: Pallete.surfaceColor,
          unselectedItemColor: Pallete.whiteDarkColor,
          backgroundColor: Pallete.surfaceColor2,
          showSelectedLabels: true,
          currentIndex: _currentIndex,
          onTap: (value) => setState(() {
                _currentIndex = value;
              }),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'tickets'),
            BottomNavigationBarItem(
                icon: Icon(Icons.area_chart), label: 'calendar'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'microphone'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'search')
          ]),
      body: navList[_currentIndex],
    );
  }
}
