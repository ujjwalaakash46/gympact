import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympact/common/widgets/bottom_bar_nav.dart';
import 'package:gympact/screens/user_setting.dart';

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
      routes: {UserSetting.userSettingRoute: (context) => UserSetting()},
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomBarNav();
  }
}
