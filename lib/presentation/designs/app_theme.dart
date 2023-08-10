import 'package:calculator2/presentation/components/material_color_generator.dart';
import 'package:calculator2/presentation/designs/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    brightness: Brightness.light,
    primaryColor: AppColor.primary,
    primarySwatch: MaterialColorGenerator.from(AppColor.primary),
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: false,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static ThemeData dark = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
    ),
    brightness: Brightness.dark,
    primaryColor: AppColor.primary,
    primarySwatch: MaterialColorGenerator.from(AppColor.primary),
    scaffoldBackgroundColor: Colors.black,
    useMaterial3: false,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static void setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness:
          themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
      statusBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarColor:
          themeMode == ThemeMode.light ? Colors.white : Colors.black,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }
}
