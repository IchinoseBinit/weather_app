import 'package:flutter/material.dart';

class MyTextWidget extends StatelessWidget {
  final String title;
  final double? fontsize;
  final FontWeight? fontweight;
  final Color? color;

  const MyTextWidget(
      {super.key,
      required this.title,
      this.fontsize,
      this.fontweight,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: color ?? Colors.white,
        fontSize: fontsize,
        fontWeight: fontweight,
      ),
    );
  }
}
