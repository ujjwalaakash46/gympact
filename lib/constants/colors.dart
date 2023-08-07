import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class Pallete {
  // Colors
  // static const primaryColor = Color.fromARGB(255, 196, 255, 46);
  static const primaryColor = Color.fromARGB(255, 227, 255, 46);
  static const secondaryColor = Color.fromRGBO(255, 255, 255, 1);
  static const brightness = Brightness.light;
  static const onPrimaryColor = Color.fromARGB(255, 37, 37, 37);
  static const onSecondaryColor = Color.fromARGB(255, 37, 37, 37);
  static const errorColor = Colors.redAccent;
  static const onErrorColor = Colors.white;
  static const backgroundColor = Color.fromARGB(255, 32, 32, 32);
  static const onBackgroundColor = Color.fromRGBO(255, 255, 255, 1);
  static const surfaceColor = Color.fromARGB(255, 44, 44, 44);
  static const onSurfaceColor = Color.fromARGB(255, 255, 255, 255);
  static const ligthBlack = Color.fromARGB(184, 0, 0, 0);
  static const grayColor = Color.fromRGBO(186, 201, 255, 0.05);
  static const commonBlueColor = Color.fromARGB(255, 34, 142, 237);
  static const successColor = Color.fromARGB(255, 9, 189, 36);
  static const blackColor = Colors.black;
  static const greyColor = Color.fromRGBO(26, 39, 45, 1); // secondary color
  static const drawerColor = Color.fromRGBO(18, 18, 18, 1);
  static const whiteColor = Colors.white;
  static const whiteDarkColor = Color.fromARGB(255, 209, 209, 209);
  static const whiteFadeColor = Color.fromARGB(255, 241, 241, 241);
  static var redColor = Colors.red.shade500;
  static var blueColor = Colors.blue.shade300;
  static const surfaceColor2 = Color.fromARGB(255, 50, 50, 50);
  static const surfaceColor3 = Color.fromARGB(255, 68, 68, 68);
  static const surfaceColor4 = Color.fromARGB(255, 112, 112, 112);
  static const orange = Color.fromARGB(255, 240, 106, 29);
  static const orangeFade = Color.fromARGB(159, 203, 116, 66);
  static const primaryFade = Color.fromARGB(255, 213, 255, 123);
  static const primaryFade2 = Color.fromARGB(255, 196, 255, 68);
  static const primaryDarkFade = Color.fromARGB(255, 59, 59, 56);
  static const primaryDarkFade2 = Color.fromARGB(255, 32, 32, 29);

  // Themes
  static var darkModeAppTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: blackColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: drawerColor,
      iconTheme: IconThemeData(
        color: whiteColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: drawerColor,
    ),
    primaryColor: redColor,
    backgroundColor:
        drawerColor, // will be used as alternative background color
  );

  static var lightModeAppTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: whiteColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: blackColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: whiteColor,
    ),
    primaryColor: redColor,
    backgroundColor: whiteColor,
  );
}

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeMode _mode;
  ThemeNotifier({ThemeMode mode = ThemeMode.dark})
      : _mode = mode,
        super(
          Pallete.darkModeAppTheme,
        ) {
    getTheme();
  }

  ThemeMode get mode => _mode;

  void getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme');

    if (theme == 'light') {
      _mode = ThemeMode.light;
      state = Pallete.lightModeAppTheme;
    } else {
      _mode = ThemeMode.dark;
      state = Pallete.darkModeAppTheme;
    }
  }

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_mode == ThemeMode.dark) {
      _mode = ThemeMode.light;
      state = Pallete.lightModeAppTheme;
      prefs.setString('theme', 'light');
    } else {
      _mode = ThemeMode.dark;
      state = Pallete.darkModeAppTheme;
      prefs.setString('theme', 'dark');
    }
  }
}

class GlobalVariables {
  static const primaryColor = Color.fromARGB(255, 162, 255, 0);
  static const secondaryColor = Color.fromARGB(255, 143, 220, 12);
  static const brightness = Brightness.light;
  static const onPrimaryColor = Color.fromARGB(255, 37, 37, 37);
  static const onSecondaryColor = Color.fromARGB(255, 37, 37, 37);
  static const errorColor = Colors.redAccent;
  static const onErrorColor = Colors.white;
  static const backgroundColor = Color.fromARGB(255, 32, 32, 32);
  static const onBackgroundColor = Color.fromRGBO(255, 255, 255, 1);
  static const surfaceColor = Color.fromARGB(255, 51, 51, 51);
  static const onSurfaceColor = Color.fromARGB(255, 34, 34, 34);
  static const ligthBlack = Color.fromARGB(184, 0, 0, 0);
  static const grayColor = Color.fromRGBO(186, 201, 255, 0.05);
  static const commonBlueColor = Color.fromARGB(255, 34, 142, 237);
  static const successColor = Color.fromARGB(255, 9, 189, 36);
  static const blackColor = Colors.black;
}
