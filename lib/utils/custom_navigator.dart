import 'package:flutter/material.dart';

class CustomNavigator {
  static void goto(BuildContext context, Widget widget) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ));
  }

  static void replasement(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ));
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
