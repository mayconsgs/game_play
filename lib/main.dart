import 'package:flutter/material.dart';
import 'package:game_play/controllers/authController.dart';
import 'package:game_play/screens/homeScreen.dart';
import 'package:game_play/screens/signInScreen.dart';
import 'package:game_play/screens/splashScreen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GamePlay',
      darkTheme: ThemeData(
        primaryColor: Color.fromARGB(255, 229, 28, 68),
        primarySwatch: Colors.blue,
        backgroundColor: Color.fromARGB(255, 11, 16, 54),
        scaffoldBackgroundColor: Color.fromARGB(255, 11, 16, 54),
        textTheme: TextTheme(
          headline3: GoogleFonts.rajdhani(
            color: Color.fromARGB(255, 221, 227, 240),
            fontWeight: FontWeight.bold,
          ),
          headline5: GoogleFonts.rajdhani(
            color: Color.fromARGB(255, 221, 227, 240),
            fontWeight: FontWeight.normal,
          ),
          subtitle1: GoogleFonts.inter(
            color: Color.fromARGB(255, 171, 177, 204),
            fontSize: 13,
            fontWeight: FontWeight.normal,
          ),
          bodyText1: GoogleFonts.inter(
            color: Color.fromARGB(255, 221, 227, 240),
          ),
          bodyText2: GoogleFonts.rajdhani(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 221, 227, 240),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: GoogleFonts.inter(fontSize: 15),
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            primary: Color.fromARGB(255, 229, 28, 68),
          ),
        ),
        appBarTheme: AppBarTheme(backgroundColor: Color(0xFF1D2766)),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Color.fromARGB(255, 11, 16, 54),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFF243189)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFF243189)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFF243189)),
          ),
          fillColor: Color(0xFF1D2766),
          filled: true,
        ),
      ),
      themeMode: ThemeMode.dark,
      home: FutureBuilder(
        future: _authController.getCredentials(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (_authController.hasClient) return HomeScreen();

            return SignInScreen();
          }

          return SplashScreen();
        },
      ),
    );
  }
}
