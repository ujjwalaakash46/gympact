import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/models/user.dart';
import 'package:gympact/provider/gym_state.dart';
import 'package:gympact/provider/user_state.dart';
import 'package:gympact/screens/admin-screens/admin_home.dart';
import 'package:gympact/screens/admin-screens/admin_notification.dart';
import 'package:gympact/screens/admin-screens/admin_user_details.dart';
import 'package:gympact/screens/admin-screens/admin_gym_details.dart';
import 'package:gympact/screens/login.dart';

class AdminBottomBarNav extends ConsumerStatefulWidget {
  static String adminMainScreenRoute = '/admin-screens';
  const AdminBottomBarNav({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminBottomBarNavState();
}

class _AdminBottomBarNavState extends ConsumerState<AdminBottomBarNav> {
  var _currentIndex = 0;
  var ready = false;
  late User user;

  var navList = const [
    AdminHome(),
    AdminUserDetails(),
    AdminNotification(),
    AdminGymDetails(),
  ];

  @override
  void initState() {
    ready = false;
    fetchInitialData();
    super.initState();
    // final userNotifier = context.read(userProvider.notifier);
  }

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

  fetchGym() async {
    // var userState = ref.read(userProvider.notifier);
    // if (userState.get() != null) {
    //   user = userState.get()!;
    // } else {
    // var userData = await userState.fetchUserData();
    // if (userData != null) {
    //   user = userData;
    // } else {
    //   //do something
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     Navigator.of(context).popAndPushNamed(LoginScreen.loginScreenRoute);
    //   });
    // }
    // }
    // setState(() {
    //   ready = true;
    // });
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
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.notifications), label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.area_chart), label: '')
                ]),
            body: navList[_currentIndex],
          );
  }
}
