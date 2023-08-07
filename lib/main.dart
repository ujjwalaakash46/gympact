import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympact/screens/admin-screens/admin_bottom_bar_nav.dart';
import 'package:gympact/screens/admin-screens/admin_diets.dart';
import 'package:gympact/screens/admin-screens/admin_package_list.dart';
import 'package:gympact/screens/admin-screens/admin_packages.dart';
import 'package:gympact/screens/admin-screens/admin_user_add.dart';
import 'package:gympact/screens/admin-screens/admin_workouts.dart';
import 'package:gympact/screens/admin-screens/admin_birthday.dart';
import 'package:gympact/screens/initial_launch.dart';
import 'package:gympact/screens/login.dart';
import 'package:gympact/screens/common/add_todays_details.dart';
import 'package:gympact/screens/common/create_workout.dart';
import 'package:gympact/screens/common/diet_plan.dart';
import 'package:gympact/screens/user-screens/user_attendance.dart';
import 'package:gympact/screens/user-screens/user_bottom_bar_nav.dart';
import 'package:gympact/screens/user-screens/user_past_workout.dart';
import 'package:gympact/screens/user-screens/user_setting.dart';
import 'package:gympact/screens/user-screens/user_workout.dart';

import 'constants/colors.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gympact',
      theme: ThemeData(
        fontFamily: "MontserratMedium",
        colorScheme: const ColorScheme(
          primary: Pallete.primaryColor,
          secondary: Pallete.secondaryColor,
          brightness: Brightness.dark,
          onPrimary: Pallete.onPrimaryColor,
          onSecondary: Pallete.onSecondaryColor,
          error: Pallete.errorColor,
          onError: Pallete.onErrorColor,
          background: Pallete.backgroundColor,
          onBackground: Pallete.onBackgroundColor,
          surface: Pallete.surfaceColor,
          onSurface: Pallete.onSurfaceColor,
        ),
      ),
      home: const MyHomePage(),
      routes: {
        UserBottomBarNav.userMainScreenRoute: (context) => UserBottomBarNav(),
        AdminBottomBarNav.adminMainScreenRoute: (context) =>
            AdminBottomBarNav(),
        UserSetting.userSettingRoute: (context) => UserSetting(),
        UserAttendance.userAttendanceRoute: (context) => UserAttendance(),
        UserWorkout.userWorkoutRoute: (context) => UserWorkout(),
        CreateWorkout.createWorkoutRoute: (context) => CreateWorkout(),
        UserPastWorkout.userPastWorkoutRoute: (context) => UserPastWorkout(),
        DietPlan.dietPlanRoute: (context) => DietPlan(),
        AddTodaysDetails.addTodaysDetailsRoute: (context) => AddTodaysDetails(),
        AdminPackages.adminPackagesRoute: (context) => AdminPackages(),
        AdminPackageList.adminPackageListRoute: (context) => AdminPackageList(),
        AdminWorkouts.adminWorkoutsRoute: (context) => AdminWorkouts(),
        AdminDiets.adminDietsRoute: (context) => AdminDiets(),
        AdminBirthday.adminBirthdayRoute: (context) => AdminBirthday(),
        AdminUserAdd.adminUserAddRoute: (context) => AdminUserAdd(),
        LoginScreen.loginScreenRoute: (context) => LoginScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return InitialLaunch();
  }
}
