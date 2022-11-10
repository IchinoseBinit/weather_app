import 'package:flutter/material.dart';
import 'package:weather_app/constants/secure_storage_constants.dart';
import 'package:weather_app/screens/homepage_screen.dart';
import 'package:weather_app/screens/help_screen.dart';
import 'package:weather_app/utils/secure_storage_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final hasSeen = await SecureStorageHelper()
          .readKey(key: SecureStorageConstants.hasSeen) !=
      null;
  final location = await SecureStorageHelper()
          .readKey(key: SecureStorageConstants.locationName) ??
      "";
  runApp(MyApp(
    hasSeen: hasSeen,
    location: location,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.hasSeen, required this.location});

  final bool hasSeen;
  final String location;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: hasSeen
          ? HomeScreen(
              location: location,
            )
          : HelpScreen(
              location: location,
            ),
    );
  }
}
