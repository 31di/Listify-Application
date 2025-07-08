import 'package:flutter/material.dart';
import 'package:listify/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://nygjkmgxpbsxnxktdthw.supabase.co",//https://nygjkmgxpbsxnxktdthw.supabase.co
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im55Z2prbWd4cGJzeG54a3RkdGh3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgxMzYzMDksImV4cCI6MjA1MzcxMjMwOX0.UVBBF2PR1BD_2MVQaYU9TmbaaojA_w6qRIhTbfiHxQE',
  );
  runApp(MyApp());
}

class AppThemes {
  static const Color primaryColor = Color(0xff076777);
  static const Color secondaryColor = Color(0xffa4d3c9);
  static const Color backgroundColor = Colors.white;
  static const Color darkBackgroundColor = Color(0xff121212);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    fontFamily: "Kanit-Regular",
    appBarTheme: AppBarTheme(
      // backgroundColor: secondaryColor,
      titleTextStyle: TextStyle(
        fontFamily: "Kanit-Regular",
        color: primaryColor,
        fontSize: 25,
      ),
      centerTitle: true,
      // elevation: 2,
      iconTheme: IconThemeData(color: backgroundColor),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        color: primaryColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        color: primaryColor,
      ),
    ),
    iconTheme: IconThemeData(color: backgroundColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: secondaryColor.withOpacity(0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: primaryColor.withOpacity(0.6)),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: secondaryColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    fontFamily: "Kanit-Regular",
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      titleTextStyle: TextStyle(
        fontFamily: "Kanit-Regular",
        color: secondaryColor,
        fontSize: 25,
      ),
      centerTitle: true,
      elevation: 2,
      iconTheme: IconThemeData(color: secondaryColor),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: secondaryColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        color: secondaryColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        color: secondaryColor,
      ),
    ),
    iconTheme: IconThemeData(color: secondaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryColor,
        foregroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: primaryColor.withOpacity(0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: secondaryColor.withOpacity(0.6)),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      home: Login(),
    );

  }
}

