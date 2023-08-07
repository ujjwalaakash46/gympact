import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/models/user.dart';
import 'package:gympact/provider/user_state.dart';
import 'package:gympact/screens/login.dart';
import 'package:gympact/screens/user-screens/user_home.dart';
import 'package:gympact/screens/user-screens/user_notification.dart';
import 'package:gympact/screens/user-screens/user_profile.dart';
import 'package:gympact/screens/user-screens/user_progress.dart';

import '../../provider/gym_state.dart';

class UserBottomBarNav extends ConsumerStatefulWidget {
  static String userMainScreenRoute = '/user-screens';
  const UserBottomBarNav({super.key});

  @override
  ConsumerState<UserBottomBarNav> createState() => _UserBottomBarNavState();
}

class _UserBottomBarNavState extends ConsumerState<UserBottomBarNav> {
  var _currentIndex = 0;

  var navList = const [
    UserHome(),
    UserProgress(),
    UserNotification(),
    UserProfile()
  ];

  bool ready = false;
  late User user;
  fetchInitialData() async {
    var userState = ref.read(userProvider.notifier);
    if (userState.get() != null) {
      user = userState.get()!;
    } else {
      var userData = await userState.fetchUserData();
      if (userData != null) {
        user = userData;
      } else {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.of(context).popAndPushNamed(LoginScreen.loginScreenRoute);
        });
      }
    }
    var gymState = ref.read(gymProvider.notifier);
    if (gymState.get() == null) {
      var gymData = await gymState.fetchGymDetail();
      if (gymData == null) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.of(context).popAndPushNamed(LoginScreen.loginScreenRoute);
        });
      }
    } else {}
    setState(() {
      ready = true;
    });
  }

  @override
  void initState() {
    fetchInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !ready
        ? const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: CircularProgressIndicator()),
            ],
          )
        : Scaffold(
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
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'tickets'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.area_chart), label: 'calendar'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.notifications), label: 'microphone'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'search')
                ]),
            body: navList[_currentIndex],
          );
  }
}
