import 'package:flutter/material.dart';
import 'package:weather_app/screens/homepage_screen.dart';
import 'package:weather_app/screens/setting_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) {
          return HomeScreen();
        },
        '/settings': (context) {
          return SettingScreen();
        }
      },
    );
  }
}
