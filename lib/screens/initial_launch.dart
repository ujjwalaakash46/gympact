import 'package:flutter/material.dart';
import 'package:gympact/constants/enums.dart';
import 'package:gympact/screens/admin-screens/admin_bottom_bar_nav.dart';
import 'package:gympact/screens/login.dart';
import 'package:gympact/screens/user-screens/user_bottom_bar_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialLaunch extends StatefulWidget {
  const InitialLaunch({super.key});

  @override
  State<InitialLaunch> createState() => _InitialLaunchState();
}

class _InitialLaunchState extends State<InitialLaunch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // snapshot.data?.clear();
            if (snapshot.data?.get("role") == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.loginScreenRoute);
                return;
              });
            } else {
              final currentRole = snapshot.data!.get("role");
              final role = Role.values.firstWhere(
                (e) => e.toString().split('.').last == currentRole,
                orElse: () => Role.member,
              );
              String route = LoginScreen.loginScreenRoute;
              // snapshot.data?.clear();
              if (role == Role.admin) {
                route = AdminBottomBarNav.adminMainScreenRoute;
              } else if (role == Role.member) {
                route = UserBottomBarNav.userMainScreenRoute;
              }
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacementNamed(route);
              });
              // Navigator.of(context).pushReplacementNamed(route);
            }
          }
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: CircularProgressIndicator()),
            ],
          );
        },
      ),
    );
  }
}

//  child: FutureBuilder(
//               future: SharedPreferences.getInstance(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Column(
//                     children: [
//                       Center(child: CircularProgressIndicator()),
//                     ],
//                   );
//                 } else if (snapshot.hasData) {
//                   if (snapshot.data?.get("role") == null) {
//                     return screenList[screenIndex];
//                   }
//                   final role = snapshot.data?.get("role") as Role;
//                   String route = UserBottomBarNav.userMainScreenRoute;
//                   if (role == Role.admin) {
//                     route = AdminBottomBarNav.adminMainScreenRoute;
//                   } else if (role == Role.member) {
//                     route = UserBottomBarNav.userMainScreenRoute;
//                   }
//                   Navigator.of(context).pushNamed(route);
//                 } else {}
//                 return screenList[screenIndex];
//               },
//             ),
