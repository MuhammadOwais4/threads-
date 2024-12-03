import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0,
    surfaceTintColor: Colors.black,
  ),
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    surface: Colors.black,
    onSurface: Colors.white,
    surfaceTint: Colors.black12,
    primary: Colors.white,
    onPrimary: Colors.white,
  ),
  navigationBarTheme: NavigationBarThemeData(
    labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    indicatorColor: Colors.transparent,
    height: 55,
    backgroundColor: Colors.black,
    iconTheme: WidgetStateProperty.all<IconThemeData>(
      const IconThemeData(
        color: Colors.white,
        size: 30,
      ),
    ),
  ),
);
