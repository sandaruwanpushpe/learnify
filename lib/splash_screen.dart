import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnify/components/bottom_navbar.dart';
import 'package:learnify/screens/auth/signin_screen.dart';
import 'package:learnify/utils/custom_navigator.dart';
import 'package:learnify/utils/responsive.dart';
import 'package:logger/logger.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkAuthState(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icon/splash.png',
                    width: Responsive.isSmallScreen(context)
                        ? size.width / 3
                        : size.width / 2,
                    height: Responsive.isSmallScreen(context)
                        ? size.height / 3
                        : size.height / 2,
                  ),
                ],
              )),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '© LEARNIFY',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> checkAuthState(context) async {
    await Future.delayed(const Duration(seconds: 4));
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        Logger().i('User is currently signed out!');
        CustomNavigator.replasement(context, const SignInPage());
      } else {
        Logger().i('User is signed in!');
        CustomNavigator.replasement(context, BottomNavbar());
      }
    });
  }
}
