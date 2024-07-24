import 'package:expense/expense.dart';
import 'package:flutter/material.dart';

var Kcolorscheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 84, 33, 171));
var kdarkcolorscheme =
    ColorScheme.fromSeed(brightness: Brightness.dark,seedColor: const Color.fromARGB(255, 5, 99, 125));
void main() {
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: kdarkcolorscheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(foregroundColor: kdarkcolorscheme.onPrimaryContainer,
                backgroundColor: kdarkcolorscheme.primaryContainer)),
      cardTheme: CardTheme().copyWith(
          color: kdarkcolorscheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
    ),
    theme: ThemeData().copyWith( 
        useMaterial3: true,
        colorScheme: Kcolorscheme,
        appBarTheme: AppBarTheme().copyWith(
            backgroundColor: Kcolorscheme.onPrimaryContainer,
            foregroundColor: Kcolorscheme.primaryContainer),
        cardTheme: CardTheme().copyWith(
            color: Kcolorscheme.secondaryContainer,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: Kcolorscheme.primaryContainer)),
        textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: Kcolorscheme.onSecondaryContainer,
                fontSize: 16))),
    // themeMode: ThemeMode.system,
    home: Expenses(),
  ));
}
