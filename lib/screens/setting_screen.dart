import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: FlatButton(
            child: Text('Go Back'),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ),
      ),
    );
  }
}
