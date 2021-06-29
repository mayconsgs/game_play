import 'package:flutter/material.dart';
import 'package:game_play/screens/homeScreen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GamePlay',
      darkTheme: ThemeData(
        primaryColor: Color.fromARGB(255, 229, 28, 68),
        backgroundColor: Color.fromARGB(255, 11, 16, 54),
        scaffoldBackgroundColor: Color.fromARGB(255, 11, 16, 54),
        textTheme: TextTheme(
          headline3: TextStyle(
            color: Color.fromARGB(255, 221, 227, 240),
            fontWeight: FontWeight.bold,
          ),
          headline5: TextStyle(
            color: Color.fromARGB(255, 221, 227, 240),
            fontWeight: FontWeight.normal,
          ),
          subtitle1: GoogleFonts.inter(
              color: Color.fromARGB(255, 171, 177, 204),
              fontSize: 13,
              fontWeight: FontWeight.normal),
          bodyText1: GoogleFonts.inter(
            color: Color.fromARGB(255, 221, 227, 240),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: GoogleFonts.inter(fontSize: 15),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            primary: Color.fromARGB(255, 229, 28, 68),
          ),
        ),
      ),
      themeMode: ThemeMode.dark,
      home: HomeScreen(),
    );
  }
}
