import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget largeScreen;
  final Widget smallScreen;
  final Widget mediumScreen;
  const Responsive({
    required Key key,
    required this.mediumScreen,
    required this.smallScreen,
    required this.largeScreen,
  }) : super(key: key);

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 904;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 904 &&
        MediaQuery.of(context).size.width <= 1280;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1280;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1280) {
          return largeScreen;
        } else if (constraints.maxWidth <= 1280 &&
            constraints.maxWidth >= 904) {
          return mediumScreen;
        } else {
          return smallScreen;
        }
      },
    );
  }
}
