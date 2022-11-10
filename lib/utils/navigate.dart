import 'package:flutter/material.dart';

navigate(BuildContext context, Widget screen) async {
  return await Navigator.push(
      context, MaterialPageRoute(builder: (_) => screen));
}

navigateReplacement(BuildContext context, Widget screen) async {
  return await Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (_) => screen));
}

// navigateAndRemoveAll(BuildContext context, Widget screen) {
//   return Navigator.pushAndRemoveUntil(
//     context,
//     MaterialPageRoute(builder: (_) => screen),
//     (Route<dynamic> route) => false,
//   );
// }
