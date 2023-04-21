import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  AppThemeData._();
  static ThemeData lightThemeData = themeData(brightness: Brightness.light);
  static ThemeData darkThemeData = themeData(brightness: Brightness.dark);

  static ThemeData themeData({required Brightness brightness}) {
    return ThemeData(
      brightness: brightness,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: NoShadowCupertinoPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}
