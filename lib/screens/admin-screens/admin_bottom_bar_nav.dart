import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/screens/admin-screens/admin_home.dart';
import 'package:gympact/screens/admin-screens/admin_notification.dart';
import 'package:gympact/screens/admin-screens/admin_user_details.dart';
import 'package:gympact/screens/admin-screens/admin_gym_details.dart';

class AdminBottomBarNav extends StatefulWidget {
  static String adminMainScreenRoute = '/admin-screens';
  const AdminBottomBarNav({super.key});

  @override
  State<AdminBottomBarNav> createState() => _AdminBottomBarNavState();
}

class _AdminBottomBarNavState extends State<AdminBottomBarNav> {
  var _currentIndex = 0;

  var navList = const [
    AdminHome(),
    AdminUserDetails(),
    AdminNotification(),
    AdminGymDetails(),
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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.area_chart), label: '')
          ]),
      body: navList[_currentIndex],
    );
  }
}
