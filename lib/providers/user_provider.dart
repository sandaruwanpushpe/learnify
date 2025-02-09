import 'package:learnify/components/bottom_navbar.dart';
import 'package:learnify/screens/auth/signin_screen.dart';
import 'package:learnify/utils/custom_navigator.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  //check user has signed in or signed out
  Future<void> checkAuthState(context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        Logger().i('User is currently signed out!');
        CustomNavigator.goto(context, const SignInPage());
      } else {
        Logger().i('User is signed in!');
        CustomNavigator.goto(context, BottomNavbar());
      }
    });
  }
}
